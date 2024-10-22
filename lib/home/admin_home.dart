import 'package:flutter/material.dart';
import 'package:test/course/newcourse.dart'; // ตรวจสอบว่าเส้นทางถูกต้อง
import 'package:test/form/newform.dart'; // ตรวจสอบว่าเส้นทางถูกต้อง
import 'package:test/pagenew_accont/create_accont.dart'; // ตรวจสอบว่าเส้นทางถูกต้อง

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color _userButtonColor = Colors.yellow;
  Color _courseButtonColor = Colors.pink;
  Color _formButtonColor = Colors.deepPurpleAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Welcome to Home Page',
          style: TextStyle(color: Colors.white),
        ),
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
                color: Colors.orange,
              ),
            ),
            Container(
              // padding: EdgeInsets.all(40),
              margin: EdgeInsets.all(10), // เพิ่มระยะห่างจากขอบ
              child: ClipRRect(
                // เพิ่มระยะห่างจากขอบ
                borderRadius: BorderRadius.circular(
                    20), // ปรับค่าความโค้งของขอบตามต้องการ
                child: Image.network(
                  'https://i.pinimg.com/control/236x/b4/ab/72/b4ab7222da63b12c06c8e3ba9290bd0b.jpg',
                  height: 200,
                  width: 350,
                  fit: BoxFit.cover, // ให้ภาพเต็มขนาดของกรอบที่กำหนด
                ),
              ),
            ),
            Container(
              width: 350,
              height: 400,
              padding: EdgeInsets.all(40),
              margin: EdgeInsets.all(20), // เพิ่มระยะห่างจากขอบ
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
                    UserFormScreen(),
                    onHover: (isHovered) {
                      setState(() {
                        _userButtonColor = isHovered
                            ? Colors.yellow.withOpacity(0.7)
                            : Colors.yellow;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  _buildMenuButton(
                    context,
                    'เพิ่มรายวิชา',
                    _courseButtonColor,
                    CourseFormScreen(),
                    onHover: (isHovered) {
                      setState(() {
                        _courseButtonColor = isHovered
                            ? Colors.pink.withOpacity(0.7)
                            : Colors.pink;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  _buildMenuButton(
                    context,
                    'เพิ่มแบบฟอร์ม',
                    _formButtonColor,
                    FormFormScreen(),
                    onHover: (isHovered) {
                      setState(() {
                        _formButtonColor = isHovered
                            ? Colors.deepPurpleAccent.withOpacity(0.7)
                            : Colors.deepPurpleAccent;
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
        width: 200,
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
