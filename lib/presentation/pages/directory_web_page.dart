import 'package:chatott/data/data_sources/conversation_data_source_impl.dart';
import 'package:chatott/data/repositories/conversation_repository_impl.dart';
import 'package:chatott/domain/use_cases/create_conversation_uc.dart';
import 'package:flutter/material.dart';
import 'package:chatott/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:chatott/data/repositories/auth_repository_impl.dart';
import 'package:chatott/domain/entities/user.dart' as entity;
import 'package:chatott/domain/entities/conversation.dart' as entity;
import 'package:chatott/presentation/widgets/web_state.dart';

class DirectoryWeb extends StatefulWidget {
  const DirectoryWeb({
    super.key,
  });

  @override
  State<DirectoryWeb> createState() => _DirectoryWebState();
}

class _DirectoryWebState extends State<DirectoryWeb> {
  List<entity.User> _listUsers = [];
  List<entity.Conversation> _listConversation = [];
  late AuthRemoteDataSourceImpl _remoteAuthSource;
  late ConversationDataSourceImpl _remoteConverSource;
  late ConversationRepositoryImpl _converRepository;
  late AuthRepositoryImpl _authRepository;

  entity.Conversation searchConversation(entity.User friendUser) {
    // print(friendUser.username);
    for (entity.Conversation conversation in _listConversation) {
      if (conversation.listUsername.length < 3 &&
          conversation.listUsername.contains(friendUser.username)) {
        print("Found conversation ${conversation.id}");
        return conversation;
      }
    }
    return entity.Conversation.empty;
  }

  void openChatbox(entity.Conversation conversation) {
    conversation.listUsername.remove(
        AuthRepositoryImpl(remoteDataSource: AuthRemoteDataSourceImpl())
            .storeUser
            .username);
    WebInheritedWid.of(context).notifier!.updateConversation(conversation);
    WebInheritedWid.of(context).notifier!.updateNav(0);
    WebInheritedWid.of(context).notifier!.updateChat(conversation.id);
  }

  void toConversation(entity.User friendUser) async {
    entity.Conversation conversation = searchConversation(friendUser);
    if (conversation != entity.Conversation.empty) {
      openChatbox(conversation);
    } else {
      List<String> userList = [
        _remoteAuthSource.user.id.toString(),
        friendUser.id.toString()
      ];
      conversation =
          await CreateConversationUseCase(_converRepository).call(userList, "");
      openChatbox(conversation);
      print("Created a NEW conversation");
    }
  }

  @override
  void initState() {
    super.initState();
    _remoteAuthSource = AuthRemoteDataSourceImpl();
    _authRepository = AuthRepositoryImpl(remoteDataSource: _remoteAuthSource);
    _authRepository.getAllUser(_remoteAuthSource.user.jwt!).then((value) {
      setState(() {
        _listUsers = value;
      });
    });
    _remoteConverSource = ConversationDataSourceImpl();
    _converRepository =
        ConversationRepositoryImpl(remoteDataSource: _remoteConverSource);
    // getAllconversation related to the current user.
    _converRepository
        .getAllConversation(_remoteAuthSource.user.jwt!)
        .then((value) {
      setState(() {
        _listConversation = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          excludeHeaderSemantics: false,
          automaticallyImplyLeading: false, // Remove the back button
          toolbarHeight: 60,
          snap: true,
          floating: true,
          forceElevated: true,
          pinned: true,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(side: BorderSide()),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SizedBox(
              height: 60,
              child: ListTile(
                leading: Icon(Icons.view_list_outlined),
                title: Text("Danh sách bạn bè",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                onTap: () {},
                iconColor: Colors.black,
                selectedColor: Colors.black,
                selectedTileColor: Color.fromARGB(255, 225, 237, 252),
                // selected: true,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          sliver: SliverToBoxAdapter(
            child: Text(
                "Bạn bè (${_listUsers.isNotEmpty ? _listUsers.length : 0})",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
        ),
        SliverList.builder(
            itemCount: _listUsers.isNotEmpty ? _listUsers.length : 0,
            itemBuilder: (BuildContext context, int index) =>
                _remoteAuthSource.user.username == _listUsers[index].username
                    ? SizedBox(
                        height: 1,
                      )
                    : ListTile(
                        tileColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        onTap: () async {
                          toConversation(_listUsers[index]);
                        },
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(_listUsers[index].photoURL!),
                        ),
                        title: Container(
                          decoration: BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(" ${_listUsers[index].username} "),
                          ),
                        ),
                        trailing: Wrap(spacing: 12, children: <Widget>[
                          Icon(Icons.phone_in_talk_outlined),
                          Icon(Icons.video_camera_front_outlined)
                        ]),
                      ))
      ],
    );
  }
}
