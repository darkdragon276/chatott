import 'package:flutter/material.dart';

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({super.key});

  @override
  State<DiscoveryPage> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      ListTile(
        tileColor: Colors.white,
        leading: Icon(Icons.rotate_left_outlined, color: Colors.blueAccent),
        title: Text('Zalo Video'),
        trailing: Icon(Icons.chevron_right_outlined, color: Colors.grey[400]),
        onTap: () {
          print('Cloud của tôi');
        },
      ),
      GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 8,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (BuildContext context, int index) =>
              _buildIconCard(icon: Icons.music_video_outlined))
    ]);
  }

  Widget _buildIconCard({required icon}) {
    return Card(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.blueAccent),
          const SizedBox(height: 10),
          Text(
            'Nhạc chờ Zalo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
