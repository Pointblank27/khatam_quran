import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:khatam_quran/app/routes/app_pages.dart';
import '../controllers/persetujuan_controller.dart';

class PersetujuanView extends GetView<PersetujuanController> {
  final RxInt _selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persetujuan'),
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
            Expanded(
                child: MyHomePage()), // Use Expanded to take remaining space
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
                Get.offAllNamed(Routes.HOME);
                break;
              case 2:
                Get.offAllNamed(Routes.HOME);
                break;
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.upload), // Change the icon to your desired button icon
              label: 'Button',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Home',
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
          'Rekap',
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

class MyHomePage extends StatelessWidget {
  final PersetujuanController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildDataTable("Data Diterima", controller.getDataDiterima),
            buildDataTable("Data Ditolak", controller.getDataDitolak),
          ],
        ),
      ),
    );
  }

  Widget buildDataTable(String title,
      Future<List<Map<String, dynamic>>?> Function() getDataFunction) {
    return FutureBuilder<List<Map<String, dynamic>>?>(
      future: getDataFunction(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while data is being fetched.
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No data available.');
        } else {
          List<Map<String, dynamic>> dataList = snapshot.data!;
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 110.0,
                    columns: [
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('Nama')),
                      DataColumn(label: Text('NIM')),
                      DataColumn(label: Text('Video')),
                      DataColumn(label: Text('Ayat')),
                      DataColumn(label: Text('Surah')),
                      DataColumn(label: Text('Juz')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Tanggal')),
                      DataColumn(label: Text('Edit')),
                      DataColumn(label: Text('Delete')),
                    ],
                    rows: List.generate(dataList.length, (index) {
                      final data = dataList[index];
                      return DataRow(cells: [
                        DataCell(Text((index + 1).toString())),
                        DataCell(Text(data['nama'] ?? '')),
                        DataCell(Text(data['nim'] ?? '')),
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
                        DataCell(Text(data['ayat'] ?? '')),
                        DataCell(Text(data['surah'] ?? '')),
                        DataCell(Text(data['juz'] ?? '')),
                        DataCell(Text(data['status'] ?? '')),
                        DataCell(Text(data['create_at'] ?? '')),
                        DataCell(IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Handle edit action here
                            // You can use the index to identify the item to be edited
                          },
                        )),
                        DataCell(IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Handle delete action here
                            // You can use the index to identify the item to be deleted
                          },
                        )),
                      ]);
                    }),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
