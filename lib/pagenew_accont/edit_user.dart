import 'package:flutter/material.dart';
import 'package:test/models/user_model.dart';
import 'package:test/controllers/user_controller.dart';
import 'package:test/pagenew_accont/index_user.dart';

class EditUserPage extends StatefulWidget {
  final UserModel userModel;

  const EditUserPage({super.key, required this.userModel});

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final UserController _userController = UserController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fnameController.text = widget.userModel.user.userFname;
    _lnameController.text = widget.userModel.user.userLname;
    _phoneController.text = widget.userModel.user.userPhone;
    _emailController.text = widget.userModel.user.userEmail;
  }

  Future<void> _updateUser(BuildContext context) async {
    final updatedUserData = {
      "user_Fname": _fnameController.text,
      "user_Lname": _lnameController.text,
      "user_Phone": _phoneController.text,
      "user_Email": _emailController.text,
    };

    try {
      await _userController.updateUser(
          context, widget.userModel.user.userId, updatedUserData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('อัปเดตรายผู้ใช้เรียบร้อยแล้ว')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Indexuser(),
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
          'Welcom To Edit User',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: 400, // กำหนดขนาดความกว้างของคอนเทนเนอร์
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
                      'แก้ไขข้อมูลผู้ใช้',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'User ID: ${widget.userModel.user.userId}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _fnameController,
                    labelText: 'ชื่อ',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _lnameController,
                    labelText: 'นามสกุล',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _phoneController,
                    labelText: 'เบอร์โทรศัพท์',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _emailController,
                    labelText: 'อีเมล',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
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
                      onPressed: () => _updateUser(context),
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
