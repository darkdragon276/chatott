import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'D',
    'A',
    'B',
    'C',
    'D',
    'A',
    'B',
    'C',
    'D',
    'A',
    'B',
    'C',
    'D',
    'A',
    'B',
    'C',
    'D',
    'A',
    'B',
    'C',
    'D',
    'A',
    'B',
    'C',
    'D',
    'A',
    'B',
    'C',
    'D',
  ];

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
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      color: Colors.blueAccent[(index * 100) % 900],
                      child: Center(child: Text('Entry ${entries[index]}')),
                    );
                  }),
              Icon(Icons.directions_transit, size: 350),
            ],
          ),
        ));
  }
}
