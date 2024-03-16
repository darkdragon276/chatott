import 'package:flutter/material.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) => _buildStoryCard(),
    );
  }

  Card _buildStoryCard() {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://picsum.photos/60/60'),
                  radius: 30,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Posted 2 hours ago',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc id aliquet ultricies, nunc mauris lacinia nunc, id ullamcorper nunc nunc sit amet nunc.',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
              margin: EdgeInsets.all(10),
              child: Image.network('https://picsum.photos/400/400')),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Add your button's onPressed logic here
                },
                icon: Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.grey,
                ),
                label: Text('Thích',
                    style: const TextStyle(fontSize: 15, color: Colors.grey)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  surfaceTintColor: Colors.grey,
                  foregroundColor: Colors.grey,
                  fixedSize: Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Container(
                  width: 300,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Nhập bình luận',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ))
            ],
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
