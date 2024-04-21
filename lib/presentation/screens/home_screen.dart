// home_screen.dart
import 'package:chatott/presentation/pages/message_page.dart';
import 'package:chatott/presentation/pages/diary_page.dart';
import 'package:chatott/presentation/pages/directory_page.dart';
import 'package:chatott/presentation/pages/discovery_page.dart';
import 'package:chatott/presentation/pages/personal_page.dart';
import 'package:chatott/presentation/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    late Widget child;
    switch (_index) {
      case 0:
        child = MessagePage(fontSize: 20, isMobile: true,);
      case 1:
        child = DirectoryPage();
      case 2:
        child = DiscoveryPage();
      case 3:
        child = DiaryPage();
      case 4:
        child = PersonalPage();
      default:
        child = MessagePage(fontSize: 20, isMobile: true);
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: TopBar(),
      body: SizedBox.expand(child: child),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Tin nhắn",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Danh bạ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Khám phá",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: "Nhật ký",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Cá nhân",
          )
        ],
        currentIndex: _index,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (newIndex) => setState(() => _index = newIndex),
      ),
    );
  }
}
