import 'package:flutter/material.dart';
import 'package:chatott/presentation/widgets/web_state.dart';
import 'package:chatott/domain/entities/conversation.dart';

class ConversationInfo extends StatefulWidget {
  const ConversationInfo({super.key, required this.conversation});

  final Conversation conversation;

  @override
  State<ConversationInfo> createState() => _ConversationInfoState();
}

class _ConversationInfoState extends State<ConversationInfo> {
  List<bool> isOpen = List.generate(4, (index) => false);
  List<String> titleNames = ["Ảnh/Video", "File", "Link", "Thiết lập bảo mật"];
  ExpansionTile dummyExpansionTile(String titleName, bool isExpanded) {
    return ExpansionTile(
      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white)),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            titleName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
      //  isExpanded: isExpanded,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
            child: Text(
              "Chưa có $titleName được chia sẻ trong hội thoại này",
              style: TextStyle(
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          stretch: true,
          automaticallyImplyLeading: false,
          pinned: true,
          centerTitle: true,
          elevation: 2,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey)),
          titleTextStyle:
              TextStyle(fontSize: 20, fontFamily: "Ariel", color: Colors.black),
          title: Text(
            "Thông tin hội thoại",
          ),
        ),
        SliverList.list(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: CircleAvatar(
                  // backgroundColor: Colors.red,
                  backgroundImage: NetworkImage(
                      "https://picsum.photos/id/${super.widget.conversation.id * 5}/200/200"),
                  radius: 30,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                super.widget.conversation.listUsername.join(", "),
                maxLines: 1,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Ariel",
                    overflow: TextOverflow.ellipsis),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ColumnButton(
                    text: "Tắt thông báo",
                    icon: Icons.notifications,
                    onIconPress: () {},
                  ),
                  ColumnButton(
                    text: "Ghim hội thoại",
                    icon: Icons.push_pin,
                    onIconPress: () {},
                  ),
                  ColumnButton(
                    text: "Tạo nhóm trò chuyện",
                    icon: Icons.group_add,
                    onIconPress: () {},
                  ),
                ],
              ),
              Divider(
                height: 10,
                thickness: 10,
                color: Colors.grey[200],
              ),
              dummyExpansionTile("Ảnh/Video", isOpen[0]),
              Divider(
                height: 10,
                thickness: 10,
                color: Colors.grey[200],
              ),
              dummyExpansionTile("File", isOpen[1]),
              Divider(
                height: 10,
                thickness: 10,
                color: Colors.grey[200],
              ),
              dummyExpansionTile("Link", isOpen[2]),
              Divider(
                height: 10,
                thickness: 10,
                color: Colors.grey[200],
              ),
              ExpansionTile(
                initiallyExpanded: true,
                shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white)),
                title: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Thiết lập bảo mật",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                //  isExpanded: isExpanded,
                children: [
                  Center(
                      child: Column(
                    children: [
                      ListTile(
                        tileColor: Colors.white,
                        leading: Icon(Icons.timer_sharp, color: Colors.grey),
                        title: Text('Tin nhắn tự xóa'),
                        subtitle: Text('Không bao giờ'),
                        // trailing:
                        //     Icon(Icons.chevron_right_outlined, color: Colors.blueAccent),
                        onTap: () {
                          print('Tin nhắn tự xóa');
                        },
                      ),
                      ListTile(
                        tileColor: Colors.white,
                        leading: Icon(Icons.visibility_off, color: Colors.grey),
                        title: Text('Ẩn trò chuyện'),
                        // subtitle: Text('Không bao giờ'),
                        trailing:
                            Icon(Icons.toggle_off_outlined, color: Colors.grey),
                        onTap: () {
                          print('Ẩn trò chuyện');
                        },
                      ),
                      ListTile(
                        tileColor: Colors.white,
                        leading: Icon(Icons.warning_amber, color: Colors.grey),
                        title: Text('Báo xấu'),
                        // subtitle: Text('Không bao giờ'),
                        // trailing:
                        //     Icon(Icons.chevron_right_outlined, color: Colors.blueAccent),
                        onTap: () {
                          print('Báo xấu');
                        },
                      ),
                      ListTile(
                        tileColor: Colors.white,
                        leading: Icon(Icons.delete_outline_outlined, color: Colors.red),
                        title: Text('Xóa lịch sử trò chuyện',
                        style: TextStyle(color: Colors.red),),
                        // subtitle: Text('Không bao giờ'),
                        // trailing:
                        //     Icon(Icons.chevron_right_outlined, color: Colors.blueAccent),
                        onTap: () {
                          print('Xóa lịch sử trò chuyện');
                        },
                      ),
                    ],
                  )),
                ],
              )
            ],
          ),
        ])
      ],
    );
  }
}

class ColumnButton extends StatelessWidget {
  const ColumnButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.onIconPress});

  final String text;
  final IconData icon;
  final Function onIconPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: IconButton(
                onPressed: () {
                  onIconPress();
                },
                icon: Icon(icon)),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 15,
            ),
            softWrap: true,
          )
        ],
      ),
    );
  }
}
