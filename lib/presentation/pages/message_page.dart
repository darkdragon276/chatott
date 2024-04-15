import 'package:chatott/domain/repositories/chat_users_repository.dart';
import 'package:chatott/presentation/widgets/chat_card.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/chat_users.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key, required this.fontSize});

  final double fontSize;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<ChatUsers> chatUsers = ChatUsersRepository.getChatUsers();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                excludeHeaderSemantics: false,
                toolbarHeight: 0,
                snap: true,
                floating: true,
                forceElevated: true,
                backgroundColor: Colors.white,
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
                  itemCount: chatUsers.length,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (BuildContext context, int index) => ChatCard(
                        data: ChatCardData(
                          name: chatUsers[index].name,
                          messageText: chatUsers[index].messageText,
                          imageUrl: chatUsers[index].imageURL,
                          time: chatUsers[index].time,
                          isMessageRead:
                              (index == 0 || index == 3) ? true : false,
                        ),
                        onTap: () {},
                      ),
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                        height: 1,
                      )),
              ListView.separated(
                itemCount: chatUsers.length,
                itemBuilder: (BuildContext context, int index) => ChatCard(
                    data: ChatCardData(
                      name: chatUsers[index].name,
                      messageText: chatUsers[index].messageText,
                      imageUrl: chatUsers[index].imageURL,
                      time: chatUsers[index].time,
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
