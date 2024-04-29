import 'dart:io';

import 'package:chatott/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:chatott/data/data_sources/message_data_source_impl.dart';
import 'package:chatott/data/repositories/message_repository_impl.dart';
import 'package:chatott/domain/entities/message.dart' as entity;
import 'package:chatott/domain/use_cases/send_message_uc.dart';
import 'package:chatott/domain/use_cases/stream_get_conversation_message_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:open_filex/open_filex.dart';
import 'package:mime/mime.dart';

class ChatBoxScreen extends StatefulWidget {
  final int conversationId;
  final String conversationName;
  final bool isMobile;
  const ChatBoxScreen({super.key, required this.conversationId, required this.conversationName, 
  required this.isMobile});

  @override
  State<ChatBoxScreen> createState() => _ChatBoxScreenState();
}

class _ChatBoxScreenState extends State<ChatBoxScreen> {
  List<types.Message> _messages = [];
  final entity.Sender _sender =
      entity.Sender.fromUser(AuthRemoteDataSourceImpl().user);
  late int _conversationId;
  late int _userId;
  late MessageDataSourceImpl _dataSource;
  late MessageRepositoryImpl _repository;

  @override
  void initState() {
    super.initState();
    _dataSource = MessageDataSourceImpl();
    _repository = MessageRepositoryImpl(dataSource: _dataSource);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SizedBox(
        height: 144,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              tileColor: Colors.blue[100],
              leading: const Icon(Icons.photo),
              title: const Text('Photo'),
              onTap: () {
                Navigator.pop(context);
                _handleImageSelection();
              },
            ),
            ListTile(
              tileColor: Colors.blue[100],
              leading: const Icon(Icons.insert_drive_file),
              title: const Text('File'),
              onTap: () {
                Navigator.pop(context);
                _handleFileSelection();
              },
            ),
            ListTile(
              tileColor: Colors.blue[100],
              leading: const Icon(Icons.close),
              title: const Text('Cancel'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _sender.toChatTypeUser(),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _sender.toChatTypeUser(),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          const documentsDir =
              ''; //(await getApplicationDocumentsDirectory()).path
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    SendMessageUC(_repository).call(
      userId: _sender.id,
      content: message.text,
      conversationId: _conversationId,
      sessionId: (_messages.isNotEmpty) ? _messages[0].roomId! : _conversationId.toString(),
    );
  }

  Stream<List<entity.Message>> _loadMessages(int userId, int conversationId) {
    return StreamGetConversationMessageUC(_repository)
        .call(userId, conversationId);
  }

  @override
  Widget build(BuildContext context) {
    _conversationId = widget.conversationId;
    _userId = AuthRemoteDataSourceImpl().user.id!;
    return Scaffold(
      appBar: AppBar(
        leading: super.widget.isMobile ? IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            }) : SizedBox(width: 1,height: 1,),
        title: Text("Chat Box of ${super.widget.conversationName}"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<entity.Message>>(
        stream: _loadMessages(_userId, _conversationId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data);
            _messages = snapshot.data!.map((e) => e.toTextMessage()).toList();
          }
          return Chat(
            messages: _messages,
            onAttachmentPressed: _handleAttachmentPressed,
            onMessageTap: _handleMessageTap,
            onPreviewDataFetched: _handlePreviewDataFetched,
            onSendPressed: _handleSendPressed,
            showUserAvatars: true,
            showUserNames: true,
            user: _sender.toChatTypeUser(),
            theme: const DefaultChatTheme(
              inputBackgroundColor: Colors.white,
              backgroundColor: Color.fromRGBO(187, 222, 251, 1),
              attachmentButtonIcon: Icon(
                Icons.more_horiz_outlined,
                color: Color.fromRGBO(66, 66, 66, 1),
              ),
              inputTextColor: Colors.grey,
              primaryColor: Color.fromARGB(255, 68, 172, 241),
              secondaryColor: Colors.white,
              seenIcon: Text(
                'read',
                style: TextStyle(
                  fontSize: 10.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
