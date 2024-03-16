import 'package:chatott/domain/repositories/chat_users_repository.dart';
import 'package:chatott/presentation/widgets/chat_card.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/chat_users.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

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
                snap: true,
                floating: true,
                expandedHeight: 60.0,
                forceElevated: true,
                backgroundColor: Colors.white,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar.secondary(
                      splashFactory: NoSplash.splashFactory,
                      indicatorColor: Colors.grey[800],
                      unselectedLabelColor: Colors.grey[500],
                      labelColor: Colors.grey[800],
                      isScrollable: true,
                      tabs: [
                        Tab(
                            child: Text(
                          'Ưu tiên',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                        Tab(
                            child: Text('Khác',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20))),
                      ],
                    ),
                  ),
                ),
              )
            ];
          },
          body: TabBarView(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: <Widget>[
              ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: chatUsers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ChatCard(
                      data: ChatCardData(
                        name: chatUsers[index].name,
                        messageText: chatUsers[index].messageText,
                        imageUrl: chatUsers[index].imageURL,
                        time: chatUsers[index].time,
                        isMessageRead:
                            (index == 0 || index == 3) ? true : false,
                      ),
                      onTap: () {},
                    );
                  }),
              ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: chatUsers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ChatCard(
                        data: ChatCardData(
                          name: chatUsers[index].name,
                          messageText: chatUsers[index].messageText,
                          imageUrl: chatUsers[index].imageURL,
                          time: chatUsers[index].time,
                          isMessageRead:
                              (index == 0 || index == 3) ? true : false,
                        ),
                        onTap: () {});
                  }),
            ],
          ),
        ));
  }
}
