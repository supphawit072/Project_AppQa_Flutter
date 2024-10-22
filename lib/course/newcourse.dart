import 'package:flutter/material.dart';
import 'package:test/controllers/CourseController.dart';
import 'package:test/course/index_course.dart';

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
  final CourseController _courseController = CourseController();
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

        // Navigate back to IndexCourse screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => IndexCourse()),
        ); // Or use Navigator.pushReplacement to go to IndexCourse directly
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
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: Text(
          'Create New Course',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.deepPurple[100],
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
                        color: Colors.deepPurple[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    buildTextFormField(
                      controller: _courseCodeController,
                      label: 'รหัสวิชา',
                      icon: Icons.code,
                    ),
                    SizedBox(height: 16),
                    buildTextFormField(
                      controller: _courseNameController,
                      label: 'ชื่อวิชา',
                      icon: Icons.book,
                    ),
                    SizedBox(height: 16),
                    buildTextFormField(
                      controller: _creditsController,
                      label: 'หน่วยกิต',
                      icon: Icons.star,
                      isNumber: true,
                    ),
                    SizedBox(height: 16),
                    buildTextFormField(
                      controller: _instructorController,
                      label: 'ผู้สอน',
                      icon: Icons.person,
                    ),
                    SizedBox(height: 16),
                    buildTextFormField(
                      controller: _groupsController,
                      label: 'กลุ่ม',
                      icon: Icons.group,
                    ),
                    SizedBox(height: 16),
                    buildTextFormField(
                      controller: _acceptingController,
                      label: 'จำนวนรับ',
                      icon: Icons.group_add,
                      isNumber: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(
                        'สร้างรายวิชา',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple[700],
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        textStyle: TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
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

  TextFormField buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple[700]),
        filled: true,
        fillColor: Colors.deepPurple[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'กรุณากรอก$label';
        }
        if (isNumber && int.tryParse(value) == null) {
          return 'กรุณากรอกตัวเลข';
        }
        return null;
      },
    );
  }
}
