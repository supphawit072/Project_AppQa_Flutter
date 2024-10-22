import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:test/models/form_midel.dart';
import 'package:test/provider/admin_provider.dart';
import 'package:test/varbles.dart'; // เปลี่ยนเป็นไฟล์ที่ใช้งานจริง

class FormController {
  Future<void> createForm(
    BuildContext context, {
    required String curriculum,
    required String coursecodeFK,
    required String coursenameFK,
    required int creditsFK,
    required String groupsFK,
    required String instructorFK,
    required int A,
    required int BPlus,
    required int B,
    required int CPlus,
    required int C,
    required int DPlus,
    required int D,
    required int E,
    required int F,
    required int FPercent,
    required int I,
    required int W,
    required int VG,
    required int G,
    required int S,
    required int U,
    // required int Total,
  }) async {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    var accessToken = adminProvider.accessToken;

    final Map<String, dynamic> formData = {
      'curriculum': curriculum,
      'coursecode_FK': coursecodeFK,
      'coursename_FK': coursenameFK,
      'credits_FK': creditsFK,
      'groups_FK': groupsFK,
      'instructor_FK': instructorFK,
      'A': A,
      'B_plus': BPlus,
      'B': B,
      'C_plus': CPlus,
      'C': C,
      'D_plus': DPlus,
      'D': D,
      'E': E,
      'F': F,
      'F_percent': FPercent,
      'I': I,
      'W': W,
      'VG': VG,
      'G': G,
      'S': S,
      'U': U,
      'total': A +
          BPlus +
          B +
          CPlus +
          C +
          DPlus +
          D +
          E +
          F +
          FPercent +
          I +
          W +
          VG +
          G +
          S +
          U,
    };

    final response = await http.post(
      Uri.parse('$apiURL/api/admin/form/newform'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
      body: jsonEncode(formData),
    );
    print(response.statusCode);

    if (response.statusCode == 201) {
      print('Form created successfully');
    } else {
      throw Exception('ไม่สามารถสร้างข้อมูลแบบฟอร์มได้');
    }
  }

  // Other methods like `getForm`, `updateForm`, and `deleteForm` can be added similarly.

  Future<List<FormModel>> getForms(BuildContext context) async {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    var accessToken = adminProvider.accessToken;
    final response = await http.get(
      Uri.parse('$apiURL/api/admin/form/viewforms'),
      headers: {
        "Authorization": "Bearer $accessToken", // เพิ่ม Token ใน Header
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => FormModel.fromJson(item)).toList();
    } else {
      throw Exception('ไม่สามารถโหลดข้อมูลฟอร์มได้');
    }
  }

  Future<FormModel> getForm(BuildContext context, String formId) async {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    var accessToken = adminProvider.accessToken;
    final response = await http.get(
      Uri.parse('$apiURL/api/admin/form/viewform/$formId'),
      headers: {
        "Authorization": "Bearer $accessToken", // เพิ่ม Token ใน Header
      },
    );

    if (response.statusCode == 200) {
      return FormModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('ไม่สามารถโหลดข้อมูลฟอร์มได้');
    }
  }

  Future<dynamic> updateForm(BuildContext context, String formId,
      Map<String, dynamic> formData) async {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    var accessToken = adminProvider.accessToken;
    final response = await http.put(
      Uri.parse(
          '$apiURL/api/admin/form/up/$formId'), // เปลี่ยน URL ให้เป็นการอัปเดตฟอร์ม
      headers: {
        "Authorization": "Bearer $accessToken", // เพิ่ม Token ใน Header
        "Content-Type": "application/json",
      },
      body: jsonEncode(formData), // ส่งข้อมูลฟอร์มที่จะอัปเดต
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('ไม่สามารถอัปเดตข้อมูลฟอร์มได้');
    }
  }

  // Future<dynamic> deleteForm(BuildContext context, String formId) async {
  //   final adminProvider = Provider.of<AdminProvider>(context, listen: false);
  //   var accessToken = adminProvider.accessToken;
  //   final response = await http.delete(
  //     Uri.parse(
  //         '$apiURL/api/admin/form/deleteform/$formId'), // เปลี่ยน URL ให้เป็นการลบฟอร์ม
  //     headers: {
  //       "Authorization": "Bearer $accessToken", // เพิ่ม Token ใน Header
  //       "Content-Type": "application/json",
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('ไม่สามารถลบข้อมูลฟอร์มได้');
  //   }
  // }
  Future<void> deleteForm(BuildContext context, String formId) async {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    var accessToken = adminProvider.accessToken;
    final response = await http.delete(
      Uri.parse(
          '$apiURL/api/admin/form/$formId'), // เปลี่ยน URL ให้เป็นการลบฟอร์ม
      headers: {
        "Authorization": "Bearer $accessToken", // เพิ่ม Token ใน Header
      },
    );

    if (response.statusCode == 200) {
      // ถ้าลบสำเร็จ ให้แสดงข้อความแจ้งเตือน
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ลบแบบฟอร์มเรียบร้อยแล้ว')),
      );
    } else {
      // กรณีลบไม่สำเร็จ ให้แสดงสถานะและข้อความที่ได้จากเซิร์ฟเวอร์
      print('สถานะการตอบกลับจากเซิร์ฟเวอร์: ${response.statusCode}');
      print('รายละเอียดเพิ่มเติม: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'ไม่สามารถลบแบบฟอร์มได้: สถานะ ${response.statusCode} - ${response.body}',
          ),
        ),
      );
      throw Exception('ไม่สามารถลบแบบฟอร์มได้: สถานะ ${response.statusCode}');
    }
  }
}
