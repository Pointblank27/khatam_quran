import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatam_quran/app/routes/app_pages.dart';

import '../controllers/data_mengaji_admin_controller.dart';

class DataMengajiAdminView extends GetView<DataMengajiAdminController> {
  final RxInt _selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Mengaji Admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            SizedBox(height: 18.0),
            UserProfileWidget(),
            SizedBox(height: 50.0),
            DataTextWidget(),
            SizedBox(height: 20.0),
            WhiteRectangleWidget(controller: controller),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: _selectedIndex.value,
          onTap: (index) {
            _selectedIndex.value = index;
            switch (index) {
              case 0:
                Get.offAllNamed(Routes.HOME);
                break;
              case 1:
                Get.offAllNamed(Routes.PERSETUJUAN);
                break;
              case 2:
                // Add logic for the button in DataMengajiAdminView
                break;
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.upload),
              label: 'Button',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Button',
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfileWidget extends StatelessWidget {
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
              'Nama Ustad',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            Text(
              'Admin',
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
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Data',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Color(0xFF008000),
          ),
        ),
        SizedBox(width: 8.0),
        Text(
          'Mengaji',
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
  final DataMengajiAdminController controller;

  WhiteRectangleWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: controller.getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text('No data available');
        } else {
          // Extract data from the snapshot
          Map<String, dynamic> data = snapshot.data!;

          // Use the data to populate your DataTable or other widgets
          return Container(
            height: MediaQuery.of(context).size.height * 0.150,
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
                  offset: Offset(3, 3),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('No')),
                  DataColumn(label: Text('Nama')),
                  DataColumn(label: Text('NIM')),
                  DataColumn(label: Text('Video')),
                  DataColumn(label: Text('Informasi Al-Quran')),
                  DataColumn(label: Text('Tanggal')),
                  DataColumn(label: Text('Reject')),
                  DataColumn(label: Text('Accept')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('Nama Mahasiswa')),
                    DataCell(Text('NIM Mahasiswa')),
                    DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.video_library,
                              color: Colors.black, size: 32.0),
                          SizedBox(height: 4.0),
                          Text('20:00', style: TextStyle(fontSize: 10.0)),
                        ],
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(data['juz'] ?? ''),
                          SizedBox(width: 16.0),
                          Text(data['surah'] ?? ''),
                          SizedBox(width: 16.0),
                          Text(data['ayat'] ?? ''),
                          SizedBox(width: 16.0),
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(data['create_at'] ?? ''),
                          SizedBox(width: 16.0),
                        ],
                      ),
                    ),
                    DataCell(IconButton(
                      icon: Icon(Icons.not_interested),
                      onPressed: () {
                        controller.reject(data['postId']);
                      },
                    )),
                    DataCell(IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        controller.accept(data['postId']);
                      },
                    )),
                  ]),
                  // Add more DataRow entries as needed
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
