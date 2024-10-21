// To parse this JSON data, do
//
//     final formModel = formModelFromJson(jsonString);

import 'dart:convert';

FormModel formModelFromJson(String str) => FormModel.fromJson(json.decode(str));

String formModelToJson(FormModel data) => json.encode(data.toJson());

class FormModel {
  String id;
  String curriculum;
  String formId;
  String coursecodeFk;
  String coursenameFk;
  String creditsFk;
  String groupsFk;
  String instructorFk;
  int a;
  int bPlus;
  int b;
  int cPlus;
  int c;
  int dPlus;
  int d;
  int e;
  int f;
  int fPercent;
  int i;
  int w;
  int vg;
  int g;
  int s;
  int u;
  int total;

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

  factory FormModel.fromJson(Map<String, dynamic> json) => FormModel(
        id: json["_id"],
        curriculum: json["curriculum"],
        formId: json["form_id"],
        coursecodeFk: json["coursecode_FK"],
        coursenameFk: json["coursename_FK"],
        creditsFk: json["credits_FK"],
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

  Map<String, dynamic> toJson() => {
        "_id": id,
        "curriculum": curriculum,
        "form_id": formId,
        "coursecode_FK": coursecodeFk,
        "coursename_FK": coursenameFk,
        "credits_FK": creditsFk,
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
