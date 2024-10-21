import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:test/provider/admin_provider.dart';
import 'package:test/varbles.dart'; // เปลี่ยนเป็นไฟล์ที่ใช้งานจริง

class CourseController {
  Future<void> createCourse(
    BuildContext context, {
    required String coursecode,
    required String coursename,
    required int credits,
    required String instructor,
    required String groups,
    required int accepting,
  }) async {
    // เข้าถึง AdminProvider
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    var accessToken = adminProvider.accessToken;
    print(accessToken);

    final Map<String, dynamic> courseData = {
      'coursecode': coursecode,
      'coursename': coursename,
      'credits': credits,
      'instructor': instructor,
      'groups': groups,
      'accepting': accepting,
    };

    print(courseData);

    final response = await http.post(
      Uri.parse('$apiURL/api/admin/course/newcourse'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken", // เพิ่ม Token ใน Header
      },
      body: jsonEncode(courseData),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      // Handle successful creation of course
      print('Course created successfully');
    } else {
      throw Exception('สร้างวิชาไม่สำเร็จ');
    }
  }

  Future<List<dynamic>> getCourses(BuildContext context) async {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    var accessToken = adminProvider.accessToken;

    final response = await http.get(
      Uri.parse('$apiURL/api/admin/course/viewcourses'),
      headers: {
        "Authorization": "Bearer $accessToken", // เพิ่ม Token ใน Header
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('ไม่สามารถโหลดข้อมูลรายวิชาได้');
    }
  }

  Future<dynamic> getCourse(BuildContext context, String courseId) async {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    var accessToken = adminProvider.accessToken;

    final response = await http.get(
      Uri.parse('$apiURL/api/admin/course/viewcourse/$courseId'),
      headers: {
        "Authorization": "Bearer $accessToken", // เพิ่ม Token ใน Header
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('ไม่สามารถโหลดข้อมูลรายวิชาได้');
    }
  }

  Future<void> updateCourse(BuildContext context, String courseId,
      Map<String, dynamic> courseData) async {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    var accessToken = adminProvider.accessToken;

    final response = await http.put(
      Uri.parse('$apiURL/api/admin/upd/$courseId'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken", // เพิ่ม Token ใน Header
      },
      body: jsonEncode(courseData),
    );

    if (response.statusCode == 200) {
      // Handle successful update of course
      print('Course updated successfully');
    } else {
      throw Exception('ไม่สามารถอัปเดตรายวิชาได้');
    }
  }

  Future<void> deleteCourse(BuildContext context, String courseId) async {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    var accessToken = adminProvider.accessToken;

    final response = await http.delete(
      Uri.parse('$apiURL/api/admin/del/$courseId'),
      headers: {
        "Authorization": "Bearer $accessToken", // เพิ่ม Token ใน Header
      },
    );

    if (response.statusCode == 200) {
      // Handle successful deletion of course
      print('Course deleted successfully');
    } else {
      throw Exception('ไม่สามารถลบรายวิชาได้');
    }
  }
}
