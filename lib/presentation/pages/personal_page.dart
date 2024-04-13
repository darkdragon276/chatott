import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            tileColor: Colors.white,
            minVerticalPadding: 20,
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://picsum.photos/60/60'),
            ),
            title: Text('Nhạc chờ Zalo'),
            subtitle: Text('Đăng ký nhạc chờ, thể hiện cá tính'),
            trailing: Icon(Icons.person_3_outlined, color: Colors.blueAccent),
            onTap: () {
              print('Nhạc chờ Zalo');
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            tileColor: Colors.white,
            leading: Icon(Icons.music_video_outlined, color: Colors.blueAccent),
            title: Text('Nhạc chờ Zalo'),
            subtitle: Text('Đăng ký nhạc chờ, thể hiện cá tính'),
            onTap: () {
              print('Nhạc chờ Zalo');
            },
          ),
          ListTile(
            tileColor: Colors.white,
            leading: Icon(Icons.wallet_outlined, color: Colors.blueAccent),
            title: Text('Ví QR'),
            subtitle: Text('Lưu trữ và xuất trình các mã QR quan trọng'),
            onTap: () {
              print('Ví QR');
            },
          ),
          ListTile(
            tileColor: Colors.white,
            leading:
                Icon(Icons.cloud_upload_outlined, color: Colors.blueAccent),
            title: Text('Cloud của tôi'),
            subtitle: Text('Lưu trữ các tin nhắn quan trọng'),
            trailing:
                Icon(Icons.chevron_right_outlined, color: Colors.blueAccent),
            onTap: () {
              print('Cloud của tôi');
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            tileColor: Colors.white,
            leading: Icon(Icons.pie_chart_outline, color: Colors.blueAccent),
            title: Text('Dung lượng và dữ liệu'),
            subtitle: Text('Quản lý dữ liệu Zalo của bạn'),
            trailing:
                Icon(Icons.chevron_right_outlined, color: Colors.blueAccent),
            onTap: () {
              print('Dung lượng và dữ liệu');
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            tileColor: Colors.white,
            leading: Icon(Icons.security_outlined, color: Colors.blueAccent),
            title: Text('Tài khoản và bảo mật'),
            trailing: Icon(Icons.chevron_right_outlined),
            onTap: () {
              print('Tài khoản và bảo mật');
            },
          ),
          ListTile(
            tileColor: Colors.white,
            leading: Icon(Icons.lock_outline, color: Colors.blueAccent),
            title: Text('Quyền riêng tư'),
            trailing: Icon(Icons.chevron_right_outlined),
            onTap: () {
              print('Quyền riêng tư');
            },
          ),
          ListTile(
            tileColor: Colors.white,
            leading: Icon(Icons.logout_outlined, color: Colors.blueAccent),
            title: Text('Đăng xuất'),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}
