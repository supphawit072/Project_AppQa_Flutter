// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/course/newcourse.dart';
import 'package:test/form/newform.dart';
import 'package:test/login/Login_Page.dart';
import 'package:test/pagenew_accont/create_accont.dart';
import 'package:test/pagenew_accont/index_user.dart';
import 'package:test/provider/user_provider.dart'; // ตรวจสอบให้แน่ใจว่า import path ถูกต้อง
import 'package:test/provider/admin_provider.dart'; // อย่าลืม import AdminProvider ด้วย

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(
            create: (context) => AdminProvider()), // เพิ่ม AdminProvider ที่นี่
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
