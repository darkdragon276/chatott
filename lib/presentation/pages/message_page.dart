import 'package:chatott/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:chatott/data/data_sources/conversation_data_source_impl.dart';
import 'package:chatott/data/repositories/conversation_repository_impl.dart';
import 'package:chatott/domain/entities/conversation.dart';
import 'package:chatott/domain/repositories/conversation_repository.dart';
import 'package:chatott/domain/use_cases/get_all_conversation_uc.dart';
import 'package:chatott/presentation/widgets/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:chatott/presentation/widgets/web_state.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key, required this.fontSize, required this.isMobile});

  final double fontSize;
  final bool isMobile;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  String time;

  ChatUsers(
      {required this.name,
      required this.messageText,
      required this.imageURL,
      required this.time});

  static List<ChatUsers> getChatUsers() {
    return [
      ChatUsers(
          name: "Jane Russel",
          messageText: "Awesome Setup",
          imageURL: "https://picsum.photos/id/123/200/200",
          time: "Now"),
      ChatUsers(
          name: "Glady's Murphy",
          messageText: "That's Great",
          imageURL: "https://picsum.photos/id/124/200/200",
          time: "Yesterday"),
      ChatUsers(
          name: "Jorge Henry",
          messageText: "Hey where are you?",
          imageURL: "https://picsum.photos/id/125/200/200",
          time: "31 Mar"),
      ChatUsers(
          name: "Philip Fox",
          messageText: "Busy! Call me in 20 mins",
          imageURL: "https://picsum.photos/id/126/200/200",
          time: "28 Mar"),
      ChatUsers(
          name: "Debra Hawkins",
          messageText: "Thankyou, It's awesome",
          imageURL: "https://picsum.photos/id/127/200/200",
          time: "23 Mar"),
      ChatUsers(
          name: "Jacob Pena",
          messageText: "will update you in evening",
          imageURL: "https://picsum.photos/id/128/200/200",
          time: "17 Mar"),
      ChatUsers(
          name: "Andrey Jones",
          messageText: "Can you please share the file?",
          imageURL: "https://picsum.photos/id/129/200/200",
          time: "24 Feb"),
      ChatUsers(
          name: "John Wick",
          messageText: "How are you?",
          imageURL: "https://picsum.photos/id/130/200/200",
          time: "18 Feb"),
    ];
  }
}

class _MessagePageState extends State<MessagePage> {
  List<ChatUsers> _chatUsers = ChatUsers.getChatUsers();
  List<Conversation> _conversations = [];
  late ConversationDataSourceImpl _remoteDataSource;
  late ConversationRepositoryImpl _repository;

  @override
  void initState() {
    super.initState();
    print("initState");
    _remoteDataSource = ConversationDataSourceImpl();
    _repository =
        ConversationRepositoryImpl(remoteDataSource: _remoteDataSource);
    GetAllConversationUseCase(repository: _repository)
        .call(AuthRemoteDataSourceImpl().user.jwt!)
        .then((value) {
      setState(() {
        _conversations = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                excludeHeaderSemantics: false,
                automaticallyImplyLeading: false, // Remove the back button
                toolbarHeight: super.widget.isMobile ? 0 : 40,
                snap: true,
                floating: true,
                forceElevated: true,
                pinned: true,
                backgroundColor: Colors.white,
                title: super.widget.isMobile ? 
                SizedBox(height: 1,)
                :
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: SizedBox(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 220,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Tìm kiếm',
                              prefixIcon: Icon(Icons.search),
                            )
                          ),
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.person_add_alt_1_outlined),
                        alignment: Alignment.center,
                        iconSize: 20,),
                        IconButton(onPressed: () {}, icon: Icon(Icons.group_add_outlined),
                        alignment: Alignment.center,
                        iconSize: 20,)
                      ],
                    )
                  ),
                ),
                bottom: TabBar(
                  splashFactory: NoSplash.splashFactory,
                  indicatorColor: Colors.grey[800],
                  unselectedLabelColor: Colors.grey[500],
                  labelColor: Colors.grey[800],
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    Tab(
                        child: Text(
                      'Ưu tiên',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: super.widget.fontSize),
                    )),
                    Tab(
                        child: Text('Khác',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: super.widget.fontSize))),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            clipBehavior: Clip.none,
            children: <Widget>[
              ListView.separated(
                  itemCount:
                      _conversations.isNotEmpty ? _conversations.length : 0,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (BuildContext context, int index) => ChatCard(
                        data: ChatCardData(
                          name: _conversations[index].listUsername.join(", "),
                          messageText:
                              _conversations[index].listUsername.length > 1
                                  ? "Group"
                                  : "Single",
                          imageUrl:
                              "https://picsum.photos/id/${_conversations[index].id * 5}/200/200",
                          time: ChatCardData.fromCurrentTime(
                              _conversations[index].createAt),
                          isMessageRead: _conversations[index].status == 'read',
                        ),
                        onTap: () {
                          if (super.widget.isMobile) {
                            Navigator.pushNamed(context, '/chat',
                              arguments: _conversations[index].id);
                          } else {
                            WebInheritedWid.of(context).notifier!.updateConversation(_conversations[index]);
                          }
                          
                        },
                      ),
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                        height: 1,
                      )),
              ListView.separated(
                itemCount: _chatUsers.length,
                itemBuilder: (BuildContext context, int index) => ChatCard(
                    data: ChatCardData(
                      name: _chatUsers[index].name,
                      messageText: _chatUsers[index].messageText,
                      imageUrl: _chatUsers[index].imageURL,
                      time: _chatUsers[index].time,
                      isMessageRead: (index == 0 || index == 3) ? true : false,
                    ),
                    onTap: () {}),
                separatorBuilder: (BuildContext context, int index) =>
                    Container(
                  height: 1,
                ),
              ),
            ],
          ),
        ));
  }
}
