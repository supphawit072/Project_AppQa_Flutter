// index_user.dart
import 'package:flutter/material.dart';
import 'package:test/models/user_model.dart';
import 'package:test/controllers/user_controller.dart';

class Indexuser extends StatefulWidget {
  const Indexuser({super.key});

  @override
  State<Indexuser> createState() => _IndexuserState();
}

class _IndexuserState extends State<Indexuser> {
  final UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายชื่อผู้ใช้'),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: _userController.getUsers(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('ไม่มีข้อมูลผู้ใช้'));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index].user;
                return ListTile(
                  title: Text(
                      '${user.userPrefix} ${user.userFname} ${user.userLname}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Username: ${user.userName}'),
                      Text('Role: ${user.role}'),
                      Text('Phone: ${user.userPhone}'),
                      Text('Email: ${user.userEmail}'),
                    ],
                  ),
                  trailing: Text('ID: ${user.id}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
