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
  final TextEditingController _searchController = TextEditingController();
  UserModel? _searchedUser; // เปลี่ยนเป็น UserModel? สำหรับเก็บผู้ใช้คนเดียว

  Future<void> _searchUser(BuildContext context) async {
    try {
      final user =
          await _userController.getUser(context, _searchController.text);
      setState(() {
        _searchedUser = user; // เก็บข้อมูลผู้ใช้คนเดียว
      });
    } catch (e) {
      print(e);
      setState(() {
        _searchedUser = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
      );
    }
  }

  Future<void> _deleteUser(BuildContext context, String userId) async {
    try {
      await _userController.deleteUser(context, userId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ลบผู้ใช้เรียบร้อยแล้ว')),
      );
      _searchUser(context); // เรียกใช้งาน getUsers ใหม่เพื่ออัปเดต UI
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาดในการลบผู้ใช้: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายชื่อผู้ใช้'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'ค้นหาโดย User ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _searchUser(context),
                ),
              ],
            ),
          ),
          if (_searchedUser != null)
            Expanded(
              child: Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 4.0,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(
                    '${_searchedUser!.user.userPrefix} ${_searchedUser!.user.userFname} ${_searchedUser!.user.userLname}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8.0),
                      Text('ID: ${_searchedUser!.user.userId}'),
                      Text('Username: ${_searchedUser!.user.userName}'),
                      Text('Role: ${_searchedUser!.user.role}'),
                      Text('Phone: ${_searchedUser!.user.userPhone}'),
                      Text('Email: ${_searchedUser!.user.userEmail}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // Add your edit functionality here
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteUser(context, _searchedUser!.user.userId);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: FutureBuilder<List<UserModel>>(
                future: _userController.getUsers(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('ไม่มีข้อมูลผู้ใช้'));
                  } else {
                    final users = snapshot.data!;
                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index].user;
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          elevation: 4.0,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            title: Text(
                              '${user.userPrefix} ${user.userFname} ${user.userLname}',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8.0),
                                Text('ID: ${user.userId}'),
                                Text('Username: ${user.userName}'),
                                Text('Role: ${user.role}'),
                                Text('Phone: ${user.userPhone}'),
                                Text('Email: ${user.userEmail}'),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () {
                                    // Add your edit functionality here
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    _deleteUser(context, user.userId);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
