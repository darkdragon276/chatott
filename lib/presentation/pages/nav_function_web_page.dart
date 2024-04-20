import 'package:flutter/material.dart';
import 'package:chatott/presentation/widgets/nav_web_icon.dart';
import 'package:chatott/presentation/widgets/web_state.dart';
import 'package:chatott/presentation/pages/message_page.dart';

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