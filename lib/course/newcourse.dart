import 'package:flutter/material.dart';
import 'package:test/controllers/CourseController.dart';
import 'package:test/models/course_model.dart'; // เปลี่ยนไปยัง model สำหรับหลักสูตร
// import 'package:test/menu.dart'; // นำเข้า MenuScreen

class CourseFormScreen extends StatefulWidget {
  @override
  _CourseFormScreenState createState() => _CourseFormScreenState();
}

class _CourseFormScreenState extends State<CourseFormScreen> {
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _creditsController = TextEditingController();
  final TextEditingController _instructorController = TextEditingController();
  final TextEditingController _groupsController = TextEditingController();
  final TextEditingController _acceptingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final CourseController _courseController =
      CourseController(); // ควบคุมหลักสูตร
  String _courseCode = '';
  String _courseName = '';
  int _credits = 0;
  String _instructor = '';
  String _groups = '';
  int _accepting = 0;

  void _submitForm() async {
    _courseCode = _courseCodeController.text;
    _courseName = _courseNameController.text;
    _credits = int.tryParse(_creditsController.text) ?? 0;
    _instructor = _instructorController.text;
    _groups = _groupsController.text;
    _accepting = int.tryParse(_acceptingController.text) ?? 0;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(
          "ข้อมูลที่ส่ง: รหัสวิชา: $_courseCode, ชื่อวิชา: $_courseName, หน่วยกิต: $_credits, ผู้สอน: $_instructor, กลุ่ม: $_groups, จำนวนรับ: $_accepting");

      try {
        await _courseController.createCourse(
          context,
          coursecode: _courseCode,
          coursename: _courseName,
          credits: _credits,
          instructor: _instructor,
          groups: _groups,
          accepting: _accepting,
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('วิชาใหม่ถูกสร้างสำเร็จ'),
          backgroundColor: Colors.green,
        ));
      } catch (e) {
        print('เกิดข้อผิดพลาด: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('เกิดข้อผิดพลาดในการสร้างวิชา'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สร้างรายวิชาใหม่'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      'สร้างรายวิชาใหม่',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _courseCodeController,
                      decoration: InputDecoration(
                        labelText: 'รหัสวิชา',
                        prefixIcon: Icon(Icons.code),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกรหัสวิชา';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _courseNameController,
                      decoration: InputDecoration(
                        labelText: 'ชื่อวิชา',
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกชื่อวิชา';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _creditsController,
                      decoration: InputDecoration(
                        labelText: 'หน่วยกิต',
                        prefixIcon: Icon(Icons.star),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกหน่วยกิต';
                        }
                        if (int.tryParse(value) == null) {
                          return 'กรุณากรอกตัวเลข';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _instructorController,
                      decoration: InputDecoration(
                        labelText: 'ผู้สอน',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกชื่อผู้สอน';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _groupsController,
                      decoration: InputDecoration(
                        labelText: 'กลุ่ม',
                        prefixIcon: Icon(Icons.group),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกกลุ่ม';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _acceptingController,
                      decoration: InputDecoration(
                        labelText: 'จำนวนรับ',
                        prefixIcon: Icon(Icons.group_add),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกจำนวนรับ';
                        }
                        if (int.tryParse(value) == null) {
                          return 'กรุณากรอกตัวเลข';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('สร้างรายวิชา'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
