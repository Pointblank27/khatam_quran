import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatam_quran/app/routes/app_pages.dart';
import '../controllers/data_mengaji_controller.dart';

class DataMengajiView extends GetView<DataMengajiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Mengaji'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            SizedBox(height: 18.0),
            UserProfileWidget(),
            SizedBox(height: 50.0),
            DataTextWidget(),
            SizedBox(height: 20.0),
            VideoUploadWidget(pickMedia: controller.pickMedia),
            SizedBox(height: 20.0),
            WhiteRectangleWidget(
                pickMedia: controller.pickMedia,
                label: 'Juz',
                controller: controller.juzC),
            SizedBox(height: 20.0),
            WhiteRectangleWidget(
                pickMedia: controller.pickMedia,
                label: 'Surah',
                controller: controller.surahC),
            SizedBox(height: 20.0),
            WhiteRectangleWidget(
                pickMedia: controller.pickMedia,
                label: 'Ayat',
                controller: controller.ayatC),
            SizedBox(height: 21.0),
            Align(
              alignment: Alignment.bottomLeft,
              child: SimpanButton(),
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
                Get.offAllNamed(Routes.HOME);
              },
            ),
            IconButton(
              icon: Icon(Icons.upload),
              onPressed: () {
                // Handle navigation to upload screen
              },
            ),
            IconButton(
              icon: Icon(Icons.history),
              onPressed: () {
                Get.offAllNamed(Routes.HISTORY);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfileWidget extends GetView<DataMengajiController> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: controller.getProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          Map<String, dynamic> userData = snapshot.data!;
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
                    userData['nama'] ?? 'Nama Mahasiswa',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    userData['nim'] ?? 'NIM Mahasiswa',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return Text("No data available");
        }
      },
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

class VideoUploadWidget extends StatelessWidget {
  final Function pickMedia;

  VideoUploadWidget({required this.pickMedia});

  @override
  Widget build(BuildContext context) {
    return WhiteRectangleWidget(
      label: 'Input Video',
      isVideoUpload: true,
      pickMedia: pickMedia, // Directly pass the pickMedia function
    );
  }
}

class WhiteRectangleWidget extends StatefulWidget {
  final String label;
  final Function pickMedia;
  final bool isVideoUpload;
  final TextEditingController? controller;

  WhiteRectangleWidget({
    required this.label,
    required this.pickMedia,
    this.isVideoUpload = false,
    this.controller,
  });

  @override
  _WhiteRectangleWidgetState createState() => _WhiteRectangleWidgetState();
}

class _WhiteRectangleWidgetState extends State<WhiteRectangleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.135,
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
      child: Stack(
        children: [
          Positioned(
            top: 15.0,
            left: 20.0,
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            left: 20.0,
            right: 20.0,
            child: widget.isVideoUpload
                ? GestureDetector(
                    onTap: () {
                      widget.pickMedia();
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.upload,
                          size: 20.0,
                          color: Colors.black,
                        ),
                        Text(
                          'Upload Video',
                          style: TextStyle(
                            fontSize: 8.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                : TextFormField(
                    controller: widget.controller,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class SimpanButton extends GetView<DataMengajiController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          controller.upload();
        },
        style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 0, 128, 0),
          padding: EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          'Simpan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
