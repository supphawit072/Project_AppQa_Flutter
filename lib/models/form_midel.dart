import 'dart:convert';

class FormModel {
  final String id; // Assuming this is a String based on the context
  final String curriculum;
  final String formId;
  final String coursecodeFk;
  final String coursenameFk;
  final String creditsFk; // If this is meant to be a string
  final String groupsFk;
  final String instructorFk;
  final int a;
  final int bPlus;
  final int b;
  final int cPlus;
  final int c;
  final int dPlus;
  final int d;
  final int e;
  final int f;
  final int fPercent;
  final int i;
  final int w;
  final int vg;
  final int g;
  final int s;
  final int u;
  final int total;

  FormModel({
    required this.id,
    required this.curriculum,
    required this.formId,
    required this.coursecodeFk,
    required this.coursenameFk,
    required this.creditsFk,
    required this.groupsFk,
    required this.instructorFk,
    required this.a,
    required this.bPlus,
    required this.b,
    required this.cPlus,
    required this.c,
    required this.dPlus,
    required this.d,
    required this.e,
    required this.f,
    required this.fPercent,
    required this.i,
    required this.w,
    required this.vg,
    required this.g,
    required this.s,
    required this.u,
    required this.total,
  });

  factory FormModel.fromJson(Map<String, dynamic> json) {
    return FormModel(
      id: json["_id"].toString(), // Ensure this is treated as a String
      curriculum: json["curriculum"],
      formId: json["form_id"],
      coursecodeFk: json["coursecode_FK"],
      coursenameFk: json["coursename_FK"],
      creditsFk: json["credits_FK"].toString(), // Convert if needed
      groupsFk: json["groups_FK"],
      instructorFk: json["instructor_FK"],
      a: json["A"],
      bPlus: json["B_plus"],
      b: json["B"],
      cPlus: json["C_plus"],
      c: json["C"],
      dPlus: json["D_plus"],
      d: json["D"],
      e: json["E"],
      f: json["F"],
      fPercent: json["F_percent"],
      i: json["I"],
      w: json["W"],
      vg: json["VG"],
      g: json["G"],
      s: json["S"],
      u: json["U"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "curriculum": curriculum,
        "form_id": formId,
        "coursecode_FK": coursecodeFk,
        "coursename_FK": coursenameFk,
        "credits_FK": creditsFk, // Output as string or int as needed
        "groups_FK": groupsFk,
        "instructor_FK": instructorFk,
        "A": a,
        "B_plus": bPlus,
        "B": b,
        "C_plus": cPlus,
        "C": c,
        "D_plus": dPlus,
        "D": d,
        "E": e,
        "F": f,
        "F_percent": fPercent,
        "I": i,
        "W": w,
        "VG": vg,
        "G": g,
        "S": s,
        "U": u,
        "total": total,
      };
}

// Functions to handle JSON
FormModel formModelFromJson(String str) => FormModel.fromJson(json.decode(str));
String formModelToJson(FormModel data) => json.encode(data.toJson());
