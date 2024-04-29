import 'package:flutter/material.dart';
class DictionaryFunc extends StatefulWidget {
  const DictionaryFunc({
    super.key,
  });

  @override
  State<DictionaryFunc> createState() => _DictionaryFuncState();
}

class _DictionaryFuncState extends State<DictionaryFunc> {
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
                title: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                  )),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.person_add_alt_1_outlined),
                                  alignment: Alignment.center,
                                  iconSize: 20,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.group_add_outlined),
                                  alignment: Alignment.center,
                                  iconSize: 20,
                                )
                              ],
                            )),
                      ),
                
              ),
              SliverList.list(
                children: [
                  ListTile(
                    leading: Icon(Icons.view_list_outlined),
                    title: Text("Danh sách bạn bè",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black
                    )),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    onTap: () {},
                    iconColor: Colors.black,
                    selectedColor: Colors.black,
                    selectedTileColor: Color.fromARGB(255, 225, 237, 252),
                    selected: true,
                  ),
                  ListTile(
                    leading: Icon(Icons.group_outlined),
                    title: Text("Danh sách nhóm và cộng đồng",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black
                    )),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    onTap: () {},
                    iconColor: Colors.black,
                    selectedColor: Colors.black,
                    selectedTileColor: Color.fromARGB(255, 225, 237, 252),
                    // selected: true,
                  ),
                  ListTile(
                    leading: Icon(Icons.person_add_alt_1_outlined),
                    title: Text("Lời mời kết bạn",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black
                    )),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    onTap: () {},
                    iconColor: Colors.black,
                    selectedColor: Colors.black,
                    selectedTileColor: Color.fromARGB(255, 225, 237, 252),
                    // selected: true,
                  ),
                  ListTile(
                    leading: Icon(Icons.group_add_outlined),
                    title: Text("Lời mời vào nhóm và cộng đồng",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black
                    )),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    onTap: () {},
                    iconColor: Colors.black,
                    selectedColor: Colors.black,
                    selectedTileColor: Color.fromARGB(255, 225, 237, 252),
                    // selected: true,
                  ),
                ]
                )
      ],
    );
  }
}