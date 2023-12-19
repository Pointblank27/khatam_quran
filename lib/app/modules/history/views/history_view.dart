import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/history_controller.dart';
import 'package:khatam_quran/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryView extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            SizedBox(height: 18.0),
            FutureBuilder<Map<String, dynamic>?>(
              future: getProfile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return UserProfileWidget(
                      userName: snapshot.data?['nama'] ?? 'han',
                      userNIM: snapshot.data?['userNIM'] ?? '',
                    );
                  } else {
                    return Text('Failed to load profile data');
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            SizedBox(height: 50.0),
            FutureBuilder<Map<String, dynamic>?>(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return DataTextWidget(
                      rekap: snapshot.data?['rekap'] ?? '',
                      mengaji: snapshot.data?['mengaji'] ?? '',
                    );
                  } else {
                    return Text('Failed to load data');
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('posts').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final posts = snapshot.data?.docs ?? [];

                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post =
                            posts[index].data() as Map<String, dynamic>;

                        final juz = post['juz'] ?? '';
                        final surah = post['surah'] ?? '';
                        final ayat = post['ayat'] ?? '';

                        return WhiteRectangleWidget(
                          juz: juz,
                          surah: surah,
                          ayat: ayat,
                          date: post['date'] ?? '',
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Get.offAllNamed(Routes.PERSETUJUAN);
              },
            ),
            IconButton(
              icon: Icon(Icons.upload),
              onPressed: () {
                Get.offAllNamed(Routes.DATA_MENGAJI);
              },
            ),
            IconButton(
              icon: Icon(Icons.history),
              onPressed: () {
                // Do nothing or add specific logic if needed
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfileWidget extends StatelessWidget {
  final String userName;
  final String userNIM;

  UserProfileWidget({
    required this.userName,
    required this.userNIM,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundImage: AssetImage('assets/foto_profil.jpg'),
        ),
        SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            Text(
              userNIM,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DataTextWidget extends StatelessWidget {
  final String rekap;
  final String mengaji;

  DataTextWidget({
    required this.rekap,
    required this.mengaji,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          rekap,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Color(0xFF008000),
          ),
        ),
        SizedBox(width: 8.0),
        Text(
          mengaji,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class WhiteRectangleWidget extends StatelessWidget {
  final String juz;
  final String surah;
  final String ayat;
  final String date;

  WhiteRectangleWidget({
    required this.juz,
    required this.surah,
    required this.ayat,
    required this.date,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.120,
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(15.0),
          right: Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.video_library, color: Colors.black, size: 32.0),
                SizedBox(height: 4.0),
                Text('20:00', style: TextStyle(fontSize: 10.0)),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Juz $juz',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 16.0),
                Text(
                  'Surah $surah',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 16.0),
                Text(
                  'Ayat $ayat',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '15 Desember 2023',
                  style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
