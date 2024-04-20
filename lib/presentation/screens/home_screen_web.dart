import 'package:chatott/presentation/widgets/top_bar.dart';
import 'package:chatott/presentation/widgets/chat_card.dart';
import 'package:chatott/presentation/pages/message_page.dart';
import 'package:chatott/presentation/screens/chat_box_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class WebState extends ChangeNotifier {
  WebState();

  int indexNav = 0;
  int indexChat = 0;

  List indexInfo() {
    return [indexNav, indexChat];
  }

  void updateNav(int newNavIndex) {
    indexNav = newNavIndex;
    notifyListeners();
  }

  void updateChat(int newChatIndex) {
    indexChat = newChatIndex;
    notifyListeners();
  }
}

class WebInheritedWid extends InheritedNotifier<WebState> {
  WebInheritedWid({
    super.key,
    super.notifier,
    required super.child,
  });

  static WebInheritedWid? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WebInheritedWid>();
  }

  static WebInheritedWid of(BuildContext context) {
    //static function allow us to call the class without initialize it.
    final WebInheritedWid? result = maybeOf(context);
    assert(result != null, 'No Webnotifier found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(WebInheritedWid oldWidget) {
    // print("${notifier.indexNav} and ${oldWidget.notifier.indexNav}");
    return (notifier != oldWidget.notifier);
    // throw UnimplementedError();
  }
}

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({super.key});

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  // int _index = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: WebInheritedWid(
          notifier: WebState(),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 1200) {
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    NavBar(),
                    NavFunction(),
                    Expanded(
                      child: ChatBoxScreen(conversationId: 1),
                    ),
                    SizedBox(
                      width: 350,
                      child: ConversationInfo(),
                    )

                    // NavBar(),
                  ]);
            } else if (constraints.maxWidth > 800) {
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    NavBar(),
                    NavFunction(),
                    Expanded(
                      child: ChatBoxScreen(conversationId: 1),
                    ),

                    // NavBar(),
                  ]);
            } else if (constraints.maxWidth > 600) {
              return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                NavBar(),
                Expanded(
                  child: ChatBoxScreen(conversationId: 1),
                ),

                // NavBar(),
              ]);
            } else {
              return Placeholder();
            }
          })),
    ));
  }
}

class ConversationInfo extends StatefulWidget {
  const ConversationInfo({
    super.key,
  });

  @override
  State<ConversationInfo> createState() => _ConversationInfoState();
}

class _ConversationInfoState extends State<ConversationInfo> {
  List<bool> isOpen = List.generate(4, (index) => false);
  List<String> titleNames = ["Ảnh/Video", "File", "Link", "Thiết lập bảo mật"];
  ExpansionTile dummyExpansionTile(String titleName, bool isExpanded) {
    return ExpansionTile(
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
          pinned: true,
          centerTitle: true,
          elevation: 2,
          backgroundColor: Colors.grey[200],
          shape: RoundedRectangleBorder(side: BorderSide()),
          titleTextStyle: TextStyle(fontSize: 20, fontFamily: "Ariel"),
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
                  backgroundColor: Colors.red,
                  radius: 30,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "John Wick",
                style: TextStyle(fontSize: 20, fontFamily: "Ariel"),
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
              dummyExpansionTile("Thiết lập bảo mật", isOpen[3]),
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

class NavFunction extends StatefulWidget {
  const NavFunction({
    super.key,
  });

  @override
  State<NavFunction> createState() => _NavFunctionState();
}

class _NavFunctionState extends State<NavFunction> {
  late Widget child;

  @override
  Widget build(BuildContext context) {
    switch (WebInheritedWid.of(context).notifier!.indexNav) {
      case 0:
        child = MessagePage(
          fontSize: 15,
          isMobile: false,
        );
      // child = Placeholder();
      case 1:
        child = Placeholder();
      case 2:
        child = Placeholder();
      case 3:
        child = Placeholder();
      default:
        child = Placeholder();
    }

    return SizedBox(
        // color: Colors.black,
        width: 335,
        child: child);
  }
}

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Column>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.account_circle),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    )),
                    iconSize: MaterialStateProperty.all<double>(30),
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 30, horizontal: 0)),
                  ),
                ),
                navIcon(
                  normalIcon: Icon(Icons.chat_outlined),
                  selectedIcon: Icon(Icons.chat),
                  index: 0,
                  currentIndex: WebInheritedWid.of(context).notifier!.indexNav,
                  onIconPress: () {
                    setState(
                      () {
                        WebInheritedWid.of(context).notifier!.updateNav(0);
                      },
                    );
                  },
                ),
                navIcon(
                  normalIcon: Icon(Icons.contact_page_outlined),
                  selectedIcon: Icon(Icons.contact_page),
                  index: 1,
                  currentIndex: WebInheritedWid.of(context).notifier!.indexNav,
                  onIconPress: () {
                    setState(
                      () {
                        WebInheritedWid.of(context).notifier!.updateNav(1);
                      },
                    );
                  },
                ),
                navIcon(
                  normalIcon: Icon(Icons.check_box_outlined),
                  selectedIcon: Icon(Icons.check_box),
                  index: 2,
                  currentIndex: WebInheritedWid.of(context).notifier!.indexNav,
                  onIconPress: () {
                    setState(
                      () {
                        WebInheritedWid.of(context).notifier!.updateNav(2);
                      },
                    );
                  },
                ),
                navIcon(
                  normalIcon: Icon(Icons.videocam_outlined),
                  selectedIcon: Icon(Icons.videocam),
                  index: 3,
                  currentIndex: WebInheritedWid.of(context).notifier!.indexNav,
                  onIconPress: () {
                    setState(
                      () {
                        WebInheritedWid.of(context).notifier!.updateNav(3);
                      },
                    );
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                navIcon(
                  normalIcon: Icon(Icons.cloud_queue),
                  selectedIcon: Icon(Icons.cloud_queue),
                  index: 1,
                  currentIndex: 0,
                  onIconPress: () {},
                ),
                navIcon(
                  normalIcon: Icon(Icons.crop_free_outlined),
                  selectedIcon: Icon(Icons.crop_free_outlined),
                  index: 1,
                  currentIndex: 0,
                  onIconPress: () {},
                ),
                navIcon(
                  normalIcon: Icon(Icons.home_repair_service_outlined),
                  selectedIcon: Icon(Icons.home_repair_service),
                  index: 1,
                  currentIndex: 0,
                  onIconPress: () {},
                ),
                navIcon(
                  normalIcon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  index: 1,
                  currentIndex: 0,
                  onIconPress: () {},
                ),
              ],
            )
          ],
        ));
  }
}

class navIcon extends StatelessWidget {
  const navIcon({
    super.key,
    required this.normalIcon,
    required this.selectedIcon,
    required this.index,
    required this.currentIndex,
    this.onIconPress,
  });

  final Icon normalIcon;
  final Icon selectedIcon;
  final int index;
  final int currentIndex;
  final Function? onIconPress;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onIconPress!();
      },
      icon: normalIcon,
      selectedIcon: selectedIcon,
      isSelected: currentIndex == index,
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          )),
          iconSize: MaterialStateProperty.all<double>(30),
          padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(vertical: 15, horizontal: 10)),
          iconColor: MaterialStatePropertyAll(Colors.white)),
    );
  }
}
