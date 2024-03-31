import 'package:flutter/material.dart';

class DirectoryPage extends StatefulWidget {
  const DirectoryPage({super.key});

  @override
  State<DirectoryPage> createState() => _DirectoryPageState();
}

class _DirectoryPageState extends State<DirectoryPage> {
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
                          itemCount: 15,
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                                  height: 70,
                                  alignment: Alignment.center,
                                  color: Colors.white,
                                  child: ListTile(
                                    tileColor: Colors.white,
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          'https://picsum.photos/60/60'),
                                    ),
                                    title: Text('Nguyễn Văn A'),
                                    trailing:
                                        Wrap(spacing: 12, children: <Widget>[
                                      Icon(Icons.phone_in_talk_outlined),
                                      Icon(Icons.video_camera_front_outlined)
                                    ]),
                                  ))),
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
