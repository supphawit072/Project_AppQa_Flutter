import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:test/models/user_model.dart';
import 'package:test/provider/admin_provider.dart';
import 'package:test/varbles.dart';

import '../models/user_model.dart';

class UserController {
  Future<UserModel> createUser(BuildContext context,
      {required String userPrefix,
      required String userFname,
      required String userLname,
      required String userName,
      required String password,
      required String role,
      required String userPhone,
      required String userEmail}) async {
    final Map<String, dynamic> userData = {
      'user_prefix': userPrefix,
      'user_Fname': userFname,
      'user_Lname': userLname,
      'user_name': userName,
      'password': password,
      'role': role,
      'user_phone': userPhone,
      'user_email': userEmail,
    };
    print(userData);

    final response = await http.post(
      Uri.parse('$apiURL/api/admin/user/newuser'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userData),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('สร้างผู้ใช้ไม่สำเร็จ');
    }
  }

  // Other methods...

  Future<List<UserModel>> getUsers(BuildContext context) async {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    var accessToken = adminProvider.accessToken;
    final response = await http.get(
      Uri.parse('$apiURL/api/admin/user/viewusers'),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => UserModel.fromJson(item)).toList();
    } else {
      throw Exception('ไม่สามารถโหลดข้อมูลผู้ใช้ได้');
    }
  }

  Future<UserModel> getUser(BuildContext context, String userId) async {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    var accessToken = adminProvider.accessToken;
    final response = await http.get(
      Uri.parse('$apiURL/api/admin/user/viewuser/$userId'),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return UserModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('ไม่สามารถโหลดข้อมูลผู้ใช้ได้');
    }
  }

  Future<UserModel> updateUser(
      BuildContext context, String userId, UserModel user) async {
    final response = await http.put(
      Uri.parse('$apiURL/api/admin/user/$userId'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('ไม่สามารถอัปเดตข้อมูลผู้ใช้ได้');
    }
  }

  Future<void> deleteUser(BuildContext context, String userId) async {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    var accessToken = adminProvider.accessToken;
    final response = await http.delete(
      Uri.parse('$apiURL/api/admin/user/$userId'),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      // ถ้าลบสำเร็จ ให้แสดงข้อความแจ้งเตือน
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ลบผู้ใช้เรียบร้อยแล้ว')),
      );
    } else {
      // กรณีลบไม่สำเร็จ ให้แสดงสถานะและข้อความที่ได้จากเซิร์ฟเวอร์
      print('สถานะการตอบกลับจากเซิร์ฟเวอร์: ${response.statusCode}');
      print('รายละเอียดเพิ่มเติม: ${response.body}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'ไม่สามารถลบผู้ใช้ได้: สถานะ ${response.statusCode} - ${response.body}',
          ),
        ),
      );
      throw Exception('ไม่สามารถลบผู้ใช้ได้: สถานะ ${response.statusCode}');
    }
  }
}
