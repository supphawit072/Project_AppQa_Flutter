import 'package:flutter/material.dart';
import 'package:test/controllers/CourseController.dart';
import 'package:test/course/index_course.dart';
import 'package:test/models/course_model.dart';

class EditCoursePage extends StatefulWidget {
  final CourseModel courseModel;

  const EditCoursePage({super.key, required this.courseModel});

  @override
  _EditCoursePageState createState() => _EditCoursePageState();
}

class _EditCoursePageState extends State<EditCoursePage> {
  final CourseController _courseController = CourseController();
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _creditsController = TextEditingController();
  final TextEditingController _instructorController = TextEditingController();
  final TextEditingController _groupsController = TextEditingController();
  final TextEditingController _acceptingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _courseCodeController.text = widget.courseModel.courseCode;
    _courseNameController.text = widget.courseModel.courseName;
    _creditsController.text = widget.courseModel.credits.toString();
    _instructorController.text = widget.courseModel.instructor;
    _groupsController.text = widget.courseModel.groups;
    // _acceptingController.text = widget.courseModel.accepting.toString();
    _acceptingController.text = widget.courseModel.accepting.toString();
  }

  Future<void> _updateCourse(BuildContext context) async {
    final updatedCourseData = {
      "course_code": _courseCodeController.text,
      "course_name": _courseNameController.text,
      "credits": int.parse(_creditsController.text),
      "instructor": _instructorController.text,
      "groups": _groupsController.text,
      "accepting": _acceptingController.text,
    };

    try {
      await _courseController.updateCourse(
          context, widget.courseModel.courseId, updatedCourseData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('อัปเดตรายวิชาเรียบร้อยแล้ว')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              IndexCourse(), // Ensure this points to your index page for courses
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาดในการอัปเดต: $e')),
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'แก้ไขวิชา',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: 400, // Set width for the container
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'แก้ไขข้อมูลวิชา',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Course ID: ${widget.courseModel.courseId}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _courseCodeController,
                    labelText: 'รหัสวิชา (Course Code)',
                    icon: Icons.code,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _courseNameController,
                    labelText: 'ชื่อวิชา (Course Name)',
                    icon: Icons.book,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _creditsController,
                    labelText: 'หน่วยกิต (Credits)',
                    icon: Icons.school,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _instructorController,
                    labelText: 'อาจารย์ (Instructor)',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _groupsController,
                    labelText: 'กลุ่ม (Groups)',
                    icon: Icons.group,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _acceptingController,
                    labelText: 'รับนักศึกษา (Accepting)',
                    icon: Icons.check_circle,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _updateCourse(context),
                      child: const Text(
                        'บันทึกการเปลี่ยนแปลง',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.deepPurple),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
      ),
    );
  }
}
