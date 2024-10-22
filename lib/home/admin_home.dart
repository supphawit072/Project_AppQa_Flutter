import 'package:flutter/material.dart';
import 'package:test/course/index_course.dart';
import 'package:test/form/index_form.dart';
import 'package:test/login/Login_Page.dart';
import 'package:test/pagenew_accont/index_user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color _userButtonColor = Colors.purpleAccent; // เปลี่ยนสีเริ่มต้น
  Color _courseButtonColor = Colors.deepPurple; // เปลี่ยนสีเริ่มต้น
  Color _formButtonColor = Colors.purple; // เปลี่ยนสีเริ่มต้น

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50, // เปลี่ยนพื้นหลังเป็นสีม่วงอ่อน
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Welcome to Home Page',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'App Qa',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple, // เปลี่ยนสีข้อความ
              ),
            ),
            SizedBox(height: 20), // ระยะห่างระหว่างข้อความและภาพ
            Container(
              margin: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://i.pinimg.com/control/236x/b4/ab/72/b4ab7222da63b12c06c8e3ba9290bd0b.jpg',
                  height: 200,
                  width: 350,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20), // ระยะห่างระหว่างภาพและปุ่ม
            Container(
              width: 350,
              padding: EdgeInsets.all(20), // ปรับ padding
              decoration: BoxDecoration(
                color: Colors.deepPurple[100],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildMenuButton(
                    context,
                    'เพิ่มบัญชีผู้ใช้',
                    _userButtonColor,
                    Indexuser(),
                    onHover: (isHovered) {
                      setState(() {
                        _userButtonColor = isHovered
                            ? Colors.purpleAccent.withOpacity(0.7)
                            : Colors.purpleAccent;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  _buildMenuButton(
                    context,
                    'เพิ่มรายวิชา',
                    _courseButtonColor,
                    IndexCourse(),
                    onHover: (isHovered) {
                      setState(() {
                        _courseButtonColor = isHovered
                            ? Colors.deepPurple.withOpacity(0.7)
                            : Colors.deepPurple;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  _buildMenuButton(
                    context,
                    'เพิ่มแบบฟอร์ม',
                    _formButtonColor,
                    IndexForm(),
                    onHover: (isHovered) {
                      setState(() {
                        _formButtonColor = isHovered
                            ? Colors.purple.withOpacity(0.7)
                            : Colors.purple;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String title,
    Color buttonColor,
    Widget screen, {
    required Function(bool) onHover,
  }) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: SizedBox(
        width: double.infinity, // ปรับให้เต็มความกว้าง
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
