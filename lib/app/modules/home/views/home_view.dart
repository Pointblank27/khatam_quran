import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatam_quran/app/routes/app_pages.dart';
import '../../../../tema.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetWidget<HomeController> {
  final RxInt _selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WhiteRectangleWidget(),
            RectangleWidget(
              color: AppThemes.greyRectangleColor,
              height: MediaQuery.of(context).size.height * 0.9,
            ),
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
                dataFunction();
                break;
              case 2:
                historyFunction();
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
              label: 'Data',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> dataFunction() async {
    try {
      bool isAdmin = await controller.isAdmin();
      if (isAdmin) {
        Get.offAllNamed(Routes.PERSETUJUAN);
      } else {
        Get.offAllNamed(Routes.HISTORY);
      }
    } catch (e) {
      print("Error in someFunction: $e");
    }
  }

  Future<void> historyFunction() async {
    try {
      bool isAdmin = await controller.isAdmin();
      if (isAdmin) {
        Get.offAllNamed(Routes.DATA_MENGAJI_ADMIN);
      } else {
        Get.offAllNamed(Routes.DATA_MENGAJI);
      }
    } catch (e) {
      print("Error in someFunction: $e");
    }
  }
}

class RectangleWidget extends StatelessWidget {
  final Color color;
  final double height;

  const RectangleWidget({
    required this.color,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: color == AppThemes.greyRectangleColor
            ? BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              )
            : null,
      ),
      child: color == AppThemes.greyRectangleColor
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 16.0),
                Image.asset(
                  'assets/logo.png',
                  height: 270,
                  width: 270,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text(
                    'Sistem Program Khatam Al – Qur’an (SIPKHARAN) merupakan '
                    'Suatu Sistem yang di kembangkan untuk mempermudah '
                    'mahasiswa dalam menyelesaikan program khatam Al- Qur’an '
                    'sebagai salah satu syarat untuk mengajukan pendaftaran '
                    'yudisium. Di dalam sistem ini, mahasiswa dapat mengupload '
                    'file rekaman video mengaji disertai dengan keterangan surah '
                    'Al- Qur\'an yang telah diselesaikan. Pada aplikasi SIPKHARAN, '
                    'Ustad selaku admin juga berwenang untuk melakukan validasi '
                    'terhadap rekaman tersebut dengan opsi untuk menolak atau '
                    'menerima. Jika rekaman video tidak memenuhi persyaratan '
                    'yang ditetapkan, ustad dapat menolaknya.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            )
          : null,
    );
  }
}

class WhiteRectangleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: HomeController().getProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          Map<String, dynamic>? profileData = snapshot.data;
          String userName = profileData?['nama'] ?? 'Nama';

          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              color: AppThemes.whiteRectangleColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/foto.jpg'),
                ),
                SizedBox(height: 8.0),
                Text(
                  userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Admin',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
                LogoutButton(),
              ],
            ),
          );
        } else {
          return Text('No data available');
        }
      },
    );
  }
}

class LogoutButton extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          _showLogoutConfirmationDialog(context);
        },
        style: ElevatedButton.styleFrom(
          primary: AppThemes.buttonBackgroundColor,
          padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
        ),
        child: Text(
          'Keluar',
          style: TextStyle(
            color: AppThemes.buttonTextColor,
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yakin ingin keluar?'),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yakin'),
              onPressed: () {
                controller.logout();
              },
            ),
          ],
        );
      },
    );
  }
}
