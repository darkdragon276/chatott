import 'package:chatott/presentation/widgets/top_bar.dart';
import 'package:chatott/presentation/widgets/chat_card.dart';
import 'package:chatott/presentation/pages/message_page.dart';
import 'package:chatott/presentation/screens/chat_box_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class WebState extends ChangeNotifier{
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

  static WebInheritedWid of(BuildContext context) {   //static function allow us to call the class without initialize it.
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          NavBar(),
          NavFunction(),
          Expanded(
            child: ChatBoxScreen(),
          ),
          Container(
            // color: Colors.blue,
            width: 350,
            child: Placeholder(),
          ),
          NavBar(),
        ]),
      ),
    ));
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
        child = MessagePage(fontSize: 15,);
      case 1:
        child = Placeholder();
      case 2:
        child = Placeholder();
      case 3:
        child = Placeholder();
      default:
        child = MessagePage(fontSize: 15,);
    }

    return SizedBox(
      // color: Colors.black,
      width: 335,
      child: child
    );
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
                    shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
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
