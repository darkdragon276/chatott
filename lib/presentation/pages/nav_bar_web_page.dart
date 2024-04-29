import 'package:flutter/material.dart';
import 'package:chatott/presentation/widgets/web_state.dart';
import 'package:chatott/presentation/widgets/nav_web_icon.dart';

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
                MenuAnchor(
                  builder: (BuildContext context, MenuController controller,
                      Widget? child) {
                    return IconButton(
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
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
                    );
                  },
                  style: MenuStyle(
                      alignment: Alignment.centerRight,
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.white)),
                  menuChildren: <MenuItemButton>[
                    MenuItemButton(
                      // onPressed: () {print("Nâng cấp tài khoản");},

                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white)),
                      child: Text('John Cena',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    MenuItemButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white)),
                      onPressed: () {
                        print("Nâng cấp tài khoản");
                      },
                      child: Text('Nâng cấp tài khoản'),
                    ),
                    MenuItemButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white)),
                      onPressed: () {
                        print("Hồ sơ của bạn");
                      },
                      child: Text('Hồ sơ của bạn'),
                    ),
                    MenuItemButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white)),
                      onPressed: () {
                        print("Cài đặt");
                      },
                      child: Text('Cài đặt'),
                    ),
                    MenuItemButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white)),
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      child: Text('Đăng xuất'),
                    ),
                  ],
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
                MenuAnchor(
                  builder: (BuildContext context, MenuController controller,
                      Widget? child) {
                    return navIcon(
                      normalIcon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings),
                      index: 1,
                      currentIndex: 0,
                      onIconPress: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                    );
                  },
                  style: MenuStyle(
                      alignment: Alignment.topLeft,
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ))),
                  alignmentOffset: Offset(10, 10),
                  menuChildren: <MenuItemButton>[
                    MenuItemButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white)),
                      onPressed: () {
                        print("Thông tin tài khoản");
                      },
                      leadingIcon: Icon(Icons.person_2_outlined),
                      child: Text(
                        'Thông tin tài khoản',
                      ),
                    ),
                    MenuItemButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white)),
                      onPressed: () {
                        print("Cài đặt");
                      },
                      leadingIcon: Icon(Icons.settings_outlined),
                      child: Text("Cài đặt"),
                    ),
                    MenuItemButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white)),
                      onPressed: () {
                        print("Dữ liệu");
                      },
                      leadingIcon: Icon(Icons.storage_rounded),
                      child: Text("Dữ liệu"),
                    ),
                    MenuItemButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white)),
                      onPressed: () {
                        print("Công cụ");
                      },
                      leadingIcon: Icon(Icons.build_outlined),
                      child: Text("Công cụ"),
                    ),
                    MenuItemButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white)),
                      onPressed: () {
                        print("Ngôn ngữ");
                      },
                      leadingIcon: Icon(Icons.language),
                      child: Text("Ngôn ngữ"),
                    ),
                    MenuItemButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white)),
                      onPressed: () {
                        print("Giới thiệu");
                      },
                      leadingIcon: Icon(Icons.info_outline),
                      child: Text("Giới thiệu"),
                    ),
                    MenuItemButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white)),
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      child: Text(
                        'Đăng xuất',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
