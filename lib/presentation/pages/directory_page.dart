import 'package:chatott/data/data_sources/conversation_data_source_impl.dart';
import 'package:chatott/data/repositories/conversation_repository_impl.dart';
import 'package:chatott/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:chatott/data/repositories/auth_repository_impl.dart';
import 'package:chatott/domain/entities/user.dart' as entity;
import 'package:flutter/material.dart';
import 'package:chatott/domain/entities/conversation.dart' as entity;
import 'package:chatott/domain/use_cases/create_conversation_uc.dart';

class DirectoryPage extends StatefulWidget {
  const DirectoryPage({super.key});

  @override
  State<DirectoryPage> createState() => _DirectoryPageState();
}

class _DirectoryPageState extends State<DirectoryPage> {
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
    Navigator.pushNamed(context, '/chat', arguments: [conversation.id, 
                                conversation.listUsername.join(", ")]);
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

  void _onTapUser(entity.User user) {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                forceElevated: true,
                backgroundColor: Colors.white,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: Align(
                    alignment: Alignment.center,
                    child: TabBar.secondary(
                      splashFactory: NoSplash.splashFactory,
                      indicatorColor: Colors.blueAccent,
                      unselectedLabelColor: Colors.grey[500],
                      labelColor: Colors.grey[800],
                      isScrollable: true,
                      tabAlignment: TabAlignment.center,
                      tabs: [
                        SizedBox(width: 100, child: Tab(text: 'Bạn bè')),
                        SizedBox(width: 100, child: Tab(text: 'Nhóm')),
                        SizedBox(width: 100, child: Tab(text: 'OA')),
                      ],
                    ),
                  ),
                ),
              )
            ];
          },
          body: TabBarView(
            clipBehavior: Clip.none,
            children: <Widget>[
              SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 70,
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: ListTile(
                            leading: _buildFilledIcon(Icons.person),
                            title: Text('Lời mời kết bạn'),
                          )),
                      Container(
                          height: 70,
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: ListTile(
                              tileColor: Colors.white,
                              leading:
                                  _buildFilledIcon(Icons.contact_page_rounded),
                              title: Text('Danh bạ máy'),
                              subtitle: Text('Các số liên hệ có dùng Zalo'))),
                      Container(
                          height: 70,
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: ListTile(
                              tileColor: Colors.white,
                              leading: _buildFilledIcon(Icons.cake),
                              title: Text('Lịch sinh nhật'),
                              subtitle: Text('Theo dõi sinh nhật của bạn bè'))),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              _listUsers.isNotEmpty ? _listUsers.length : 0,
                          itemBuilder: (BuildContext context, int index) =>
                              _remoteAuthSource.user.username == _listUsers[index].username ? 
                              SizedBox(height: 1,)
                              : GestureDetector(
                                  onTap: () async {
                                      toConversation(_listUsers[index]);
                                    },
                                  child: Container(
                                      height: 70,
                                      alignment: Alignment.center,
                                      color: Colors.white,
                                      child: ListTile(
                                        tileColor: Colors.white,
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              _listUsers[index].photoURL!),
                                        ),
                                        title: Text(
                                            " ${_listUsers[index].username} "),
                                        trailing: Wrap(
                                            spacing: 12,
                                            children: <Widget>[
                                              Icon(
                                                  Icons.phone_in_talk_outlined),
                                              Icon(Icons
                                                  .video_camera_front_outlined)
                                            ]),
                                      )))),
                    ],
                  )),
              const Text("Nhóm"),
              const Text("OA"),
            ],
          ),
        ));
  }

  Widget _buildFilledIcon(IconData iconData) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        iconData,
        color: Colors.white,
      ),
    );
  }
}
