import 'package:flutter/material.dart';
import 'package:test/controllers/CourseController.dart';
import 'package:test/models/course_model.dart';
import 'package:provider/provider.dart';

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
        SnackBar(content: Text('ลบรายวิชาเรียบร้อยแล้ว')),
      );
      setState(() {
        _searchedCourse = null; // Reset search
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาดในการลบรายวิชา: $e')),
      );
    }
  }

  void _closeSearch() {
    setState(() {
      _searchedCourse = null; // Reset search to show all courses
      _searchController.clear(); // Clear the search input
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายวิชา'),
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
                      labelText: 'ค้นหาโดย Course ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _searchCourse(context),
                ),
              ],
            ),
          ),
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
                            onPressed: () {
                              // Add your edit functionality here
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
                    child: const Text('ปิด'),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: FutureBuilder<List<CourseModel>>(
                future:
                    _courseController.getCourses(context), // Get all courses
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
                                  onPressed: () {
                                    // Add your edit functionality here
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
    );
  }
}
