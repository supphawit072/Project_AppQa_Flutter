import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/course/index_course.dart';
import 'package:test/course/newcourse.dart';
import 'package:test/form/index_form.dart';
import 'package:test/form/newform.dart';
import 'package:test/home/admin_home.dart';
import 'package:test/models/admin_mdel.dart';
import 'package:test/pagenew_accont/create_accont.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test/pagenew_accont/index_user.dart';
import 'package:test/provider/admin_provider.dart';
import 'package:test/varbles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  Future<void> login() async {
    final String adminUsername = _usernameController.text;
    final String adminPassword = _passwordController.text;

    // ตรวจสอบว่าช่อง username และ password ไม่เป็นค่าว่าง
    if (adminUsername.isEmpty || adminPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('กรุณากรอก Username และ Password'),
          backgroundColor: Colors.red,
        ),
      );
    }

    final response = await http.post(
      Uri.parse('$apiURL/api/admin/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'admin_username': adminUsername,
        'admin_password': adminPassword,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      AdminModel adminModel = AdminModel.fromJson(data);
      Provider.of<AdminProvider>(context, listen: false).onLogin(adminModel);
      print(adminModel);

      // บันทึก token ถ้าต้องการ
      // await saveTokens(accessToken, refreshToken);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IndexCourse()),
      );
    } else if (response.statusCode == 400) {
      // แจ้งเตือนเมื่อชื่อผู้ใช้หรือรหัสผ่านผิด
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('ชื่อผู้ใช้หรือรหัสผ่านผิด'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // จัดการกับความล้มเหลวอื่นๆ
      print('Login failed: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: ${response.body}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade800, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: login, // เรียกใช้ฟังก์ชัน login
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Log In'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
