import 'package:flutter/material.dart';

class NavIcon extends StatelessWidget {
  const NavIcon({
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
