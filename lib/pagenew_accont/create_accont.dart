import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/controllers/user_controller.dart';
import 'package:test/models/user_model.dart';
import '../../provider/user_provider.dart';

class UserFormScreen extends StatefulWidget {
  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final TextEditingController _userPrefixController = TextEditingController();
  final TextEditingController _userFnameController = TextEditingController();
  final TextEditingController _userLnameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userPhoneController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final UserController _userController = UserController();
  String _userName = '';
  String _password = '';
  String _userFname = '';
  String _userLname = '';
  String _userPrefix = '';
  String _userPhone = '';
  String _userEmail = '';
  String _role = 'User';

  void _submitForm() async {
    _userPrefix = _userPrefixController.text;
    _userFname = _userFnameController.text;
    _userLname = _userLnameController.text;
    _userName = _userNameController.text;
    _password = _passwordController.text;
    _userPhone = _userPhoneController.text;
    _userEmail = _userEmailController.text;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // เรียก save() เพื่อบันทึกค่าที่กรอกไว้
      print(
          "ข้อมูลที่ส่ง: คำนำหน้า: $_userPrefix, ชื่อ: $_userFname, นามสกุล: $_userLname, ชื่อผู้ใช้: $_userName, รหัสผ่าน: $_password, เบอร์โทร: $_userPhone, อีเมล: $_userEmail, บทบาท: $_role");

      try {
        await _userController.createUser(
          context,
          userPrefix: _userPrefix,
          userFname: _userFname,
          userLname: _userLname,
          userName: _userName,
          password: _password,
          role: _role,
          userPhone: _userPhone,
          userEmail: _userEmail,
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('ผู้ใช้ถูกสร้างสำเร็จ'),
          backgroundColor: Colors.green,
        ));
      } catch (e) {
        print(
            'เกิดข้อผิดพลาด: $e'); // แสดงรายละเอียดของข้อผิดพลาดใน debug console
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('เกิดข้อผิดพลาดในการสร้างผู้ใช้'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สร้างผู้ใช้ใหม่'),
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
                      'สร้างบัญชีใหม่',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _userPrefixController,
                      decoration: InputDecoration(
                        labelText: 'คำนำหน้า',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _userFnameController,
                      decoration: InputDecoration(
                        labelText: 'ชื่อ',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _userLnameController,
                      decoration: InputDecoration(
                        labelText: 'นามสกุล',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                        labelText: 'ชื่อผู้ใช้',
                        prefixIcon: Icon(Icons.account_circle),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'รหัสผ่าน',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _userPhoneController,
                      decoration: InputDecoration(
                        labelText: 'เบอร์โทร',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _userEmailController,
                      decoration: InputDecoration(
                        labelText: 'อีเมล',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('สร้างผู้ใช้'),
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
