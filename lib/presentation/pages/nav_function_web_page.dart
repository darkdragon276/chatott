import 'package:flutter/material.dart';
import 'package:chatott/presentation/widgets/web_state.dart';
import 'package:chatott/presentation/pages/message_page.dart';

class NavFunction extends StatefulWidget {
  const NavFunction({
    super.key, required this.isMobile
  });
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
        child = Placeholder();
      case 2:
        child = Placeholder();
      case 3:
        child = Placeholder();
      default:
        child = Placeholder();
    }

    return super.widget.isMobile ? Expanded(child: child) 
    : SizedBox(
        // color: Colors.black,
        width: 335,
        child: child);
  }
}

