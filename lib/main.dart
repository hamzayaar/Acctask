import 'dart:async';

import 'package:acctask/screen/signin_screen.dart';
import 'package:acctask/screen/home_screen.dart';
import 'package:acctask/utility/auth_controller.dart';
import 'package:acctask/utility/post_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  Get.put(PostController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
      darkTheme: ThemeData.dark(),
      // getPages: [
      //   GetPage(name: '/', page: () => AuthWrapper()),
      //   GetPage(name: '/signIn', page: () => SignInPage()),
      //   GetPage(name: '/signUp', page: () => SignUpPage()),
      //   GetPage(name: '/home', page: () => HomePage()),
      //   GetPage(name: '/profile', page: () => ProfilePage()),
      // ],
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (AuthController.instance.isLoading.value) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return AuthController.instance.firebaseUser.value == null
            ? SignInPage()
            : HomePage();
      }
    });
  }
}
