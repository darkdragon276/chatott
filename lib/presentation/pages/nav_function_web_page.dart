import 'package:flutter/material.dart';
import 'package:chatott/presentation/widgets/web_state.dart';
import 'package:chatott/presentation/pages/message_page.dart';
import 'package:chatott/presentation/pages/directory_func_web_page.dart';

class NavFunction extends StatefulWidget {
  const NavFunction({super.key, required this.isMobile});
  final bool isMobile;
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
          isMobile: super.widget.isMobile,
        );
      // child = Placeholder();
      case 1:
        child = DictionaryFunc();
      case 2:
        child = Expanded(
          child: Center(child: Text("Todo list", style: TextStyle(fontSize: 30),),)
        );
      case 3:
         child = Expanded(
          child: Center(child: Text("Video", style: TextStyle(fontSize: 30),),)
        );;
      default:
        child = Placeholder();
    }

    return super.widget.isMobile
        ? Expanded(child: child)
        : SizedBox(
            // color: Colors.black,
            width: 335,
            child: child);
  }
}


