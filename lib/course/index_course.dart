import 'package:flutter/material.dart';
import 'package:test/controllers/CourseController.dart';
import 'package:test/course/edit_course.dart';
import 'package:test/course/newcourse.dart';
import 'package:test/home/admin_home.dart';
import 'package:test/models/course_model.dart';

class IndexCourse extends StatefulWidget {
  const IndexCourse({super.key});

  @override
  State<IndexCourse> createState() => _IndexCourseState();
}

class _IndexCourseState extends State<IndexCourse> {
  final CourseController _courseController = CourseController();
  final TextEditingController _searchController = TextEditingController();
  CourseModel? _searchedCourse;

  Future<void> _searchCourse(BuildContext context) async {
    try {
      final course =
          await _courseController.getCourse(context, _searchController.text);
      setState(() {
        _searchedCourse = course;
      });
    } catch (e) {
      print(e);
      setState(() {
        _searchedCourse = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
      );
    }
  }

  Future<void> _deleteCourse(BuildContext context, String courseId) async {
    try {
      await _courseController.deleteCourse(context, courseId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ลบรายวิชาเรียบร้อยแล้ว')),
      );
      setState(() {
        _searchedCourse = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาดในการลบรายวิชา: $e')),
      );
    }
  }

  void _closeSearch() {
    setState(() {
      _searchedCourse = null;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        title: const Text('List Course', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomeScreen()), // Navigate to HomeScreen
              );
            },
          ),
        ],
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
                    decoration: InputDecoration(
                      labelText: 'ค้นหาโดย Course ID',
                      labelStyle: TextStyle(color: Colors.deepPurple[700]),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.deepPurple),
                  onPressed: () => _searchCourse(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          if (_searchedCourse != null)
            Expanded(
              child: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    elevation: 4.0,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        _searchedCourse!.courseName,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8.0),
                          Text('ID: ${_searchedCourse!.courseId}'),
                          Text('Code: ${_searchedCourse!.courseCode}'),
                          Text('Instructor: ${_searchedCourse!.instructor}'),
                          Text('Credits: ${_searchedCourse!.credits}'),
                          Text('Groups: ${_searchedCourse!.groups}'),
                          Text('Accepting: ${_searchedCourse!.accepting}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () async {
                              final updatedCourse = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditCoursePage(
                                      courseModel: _searchedCourse!),
                                ),
                              );

                              if (updatedCourse != null) {
                                setState(() {
                                  _searchedCourse = updatedCourse;
                                });
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deleteCourse(context, _searchedCourse!.courseId);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _closeSearch,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple[700],
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('ปิด',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: FutureBuilder<List<CourseModel>>(
                future: _courseController.getCourses(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('ไม่มีข้อมูลรายวิชา'));
                  } else {
                    final courses = snapshot.data!;
                    return ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          elevation: 4.0,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            title: Text(
                              course.courseName,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8.0),
                                Text('ID: ${course.courseId}'),
                                Text('Code: ${course.courseCode}'),
                                Text('Instructor: ${course.instructor}'),
                                Text('Credits: ${course.credits}'),
                                Text('Groups: ${course.groups}'),
                                Text('Accepting: ${course.accepting}'),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () async {
                                    final updatedCourse = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditCoursePage(courseModel: course),
                                      ),
                                    );

                                    if (updatedCourse != null) {
                                      setState(() {
                                        courses[index] = updatedCourse;
                                      });
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    _deleteCourse(context, course.courseId);
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple[700], // Button color
            minimumSize: const Size.fromHeight(50), // Full-width button
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text('เพิ่มรายวิชา',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CourseFormScreen()),
            );
          },
        ),
      ),
    );
  }
}
