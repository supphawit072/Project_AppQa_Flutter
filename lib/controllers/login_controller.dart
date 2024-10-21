import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:test/course/newcourse.dart';
import 'package:test/models/admin_mdel.dart';
import 'package:test/pagenew_accont/create_accont.dart';
import 'package:test/provider/admin_provider.dart';
import 'package:test/varbles.dart'; // เปลี่ยนเป็นไฟล์ที่ใช้งานจริง
// เปลี่ยนเป็นไฟล์ที่ใช้งานจริง

class LoginController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final String adminUsername = usernameController.text;
    final String adminPassword = passwordController.text;

    // ตรวจสอบว่าช่อง username และ password ไม่เป็นค่าว่าง
    if (adminUsername.isEmpty || adminPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('กรุณากรอก Username และ Password'),
          backgroundColor: Colors.red,
        ),
      );
      return;
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
      // บันทึก token ถ้าต้องการ
      // await saveTokens(accessToken, refreshToken);
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
}
