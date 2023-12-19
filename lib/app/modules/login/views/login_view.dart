import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatam_quran/app/routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    bool _obscureText = true;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/logo.png',
                      width: 280,
                      height: 280,
                    ),
                  ],
                ),
                TextField(
                  controller: controller.emailC,
                  decoration: InputDecoration(
                    labelText: 'NIM',
                    prefixIcon: const Icon(
                      Icons.account_circle,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 14.0),
                TextField(
                  controller: controller.passC,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(
                      Icons.lock,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text(
                      'Lupa Password?',
                      style: TextStyle(
                        color: Colors.red, // Warna teks lupa password
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    controller.login();
                  },
                  child: const Text('Login'),
                  style: ElevatedButton.styleFrom(
                    elevation: 8.0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    primary: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
