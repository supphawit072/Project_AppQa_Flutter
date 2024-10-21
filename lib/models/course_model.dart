// ignore: unused_import
import 'dart:convert';

// Define the CourseModel class
class CourseModel {
  final String courseId; // course_id
  final String courseCode; // coursecode
  final String courseName; // coursename
  final int credits; // credits
  final String instructor; // instructor
  final String groups; // groups
  final int accepting; // accepting

  CourseModel({
    required this.courseId,
    required this.courseCode,
    required this.courseName,
    required this.credits,
    required this.instructor,
    required this.groups,
    required this.accepting,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        courseId: json["course_id"] ?? '',
        courseCode: json["coursecode"] ?? '',
        courseName: json["coursename"] ?? '',
        credits: json["credits"] ?? 0,
        instructor: json["instructor"] ?? '',
        groups: json["groups"] ?? '',
        accepting: json["accepting"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "course_id": courseId,
        "coursecode": courseCode,
        "coursename": courseName,
        "credits": credits,
        "instructor": instructor,
        "groups": groups,
        "accepting": accepting,
      };
}
