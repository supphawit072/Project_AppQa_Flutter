import 'package:flutter/material.dart';
import 'package:test/controllers/user_controller.dart';
import 'package:test/models/user_model.dart';
import 'package:test/pagenew_accont/index_user.dart';

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
      _formKey.currentState!.save();
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

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Indexuser()),
        );
      } catch (e) {
        print('เกิดข้อผิดพลาด: $e');
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
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: Text(
          'Welcome to account creation',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
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
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      'สร้างบัญชีใหม่',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple[800],
                      ),
                    ),
                    SizedBox(height: 24),
                    _buildTextField(
                      controller: _userPrefixController,
                      labelText: 'คำนำหน้า',
                      icon: Icons.person,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _userFnameController,
                      labelText: 'ชื่อ',
                      icon: Icons.person,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _userLnameController,
                      labelText: 'นามสกุล',
                      icon: Icons.person,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _userNameController,
                      labelText: 'ชื่อผู้ใช้',
                      icon: Icons.account_circle,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _passwordController,
                      labelText: 'รหัสผ่าน',
                      icon: Icons.lock,
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _userPhoneController,
                      labelText: 'เบอร์โทร',
                      icon: Icons.phone,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _userEmailController,
                      labelText: 'อีเมล',
                      icon: Icons.email,
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(
                        'สร้างผู้ใช้',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.deepPurpleAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: obscureText,
    );
  }
}
