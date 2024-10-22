import 'package:flutter/material.dart';
import 'package:test/home/admin_home.dart';
import 'package:test/models/user_model.dart';
import 'package:test/controllers/user_controller.dart';
import 'package:test/pagenew_accont/create_accont.dart';
import 'package:test/pagenew_accont/edit_user.dart';

class Indexuser extends StatefulWidget {
  const Indexuser({super.key});

  @override
  State<Indexuser> createState() => _IndexuserState();
}

class _IndexuserState extends State<Indexuser> {
  final UserController _userController = UserController();
  final TextEditingController _searchController = TextEditingController();
  UserModel? _searchedUser;

  Future<void> _searchUser(BuildContext context) async {
    try {
      final user =
          await _userController.getUser(context, _searchController.text);
      setState(() {
        _searchedUser = user;
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
        const SnackBar(content: Text('ลบผู้ใช้เรียบร้อยแล้ว')),
      );
      _searchUser(context); // Refresh the user list after deletion
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาดในการลบผู้ใช้: $e')),
      );
    }
  }

  void _closeSearch() {
    setState(() {
      _searchedUser = null; // Reset search to show all users
      _searchController.clear(); // Clear the search input
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List User',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.deepPurple[50],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'ค้นหาโดย User ID',
                        labelStyle: const TextStyle(color: Colors.deepPurple),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.deepPurple),
                    onPressed: () => _searchUser(context),
                  ),
                ],
              ),
            ),
            const SizedBox(
                height: 16.0), // Space between search bar and the list
            if (_searchedUser != null)
              Expanded(
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        title: Text(
                          '${_searchedUser!.user.userPrefix} ${_searchedUser!.user.userFname} ${_searchedUser!.user.userLname}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditUserPage(
                                      userModel: _searchedUser!,
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _deleteUser(
                                    context, _searchedUser!.user.userId);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _closeSearch,
                      child: const Text(
                        'กลับ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16.0),
                              title: Text(
                                '${user.userPrefix} ${user.userFname} ${user.userLname}',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditUserPage(
                                            userModel: users[index],
                                          ),
                                        ),
                                      );
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity, // Make the button full width
          height: 50.0, // Set the button height
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      UserFormScreen(), // Navigate to UserFormScreen
                ),
              );
            },
            child: const Text(
              'เพิ่มผู้ใช้',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
