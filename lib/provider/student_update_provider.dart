import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_management_provider/db_functions.dart';
import 'package:student_management_provider/model/model.dart';

class StudentUpdateProvider with ChangeNotifier {
  late StudentModel student;
  File? profileImage;

  void initializeStudent(StudentModel initialStudent) {
    student = initialStudent;
    profileImage = File(initialStudent.profileImage);
    notifyListeners();
  }

  void updateProfileImage(File newImage) {
    profileImage = newImage;
    notifyListeners();
  }

  Future<void> updateStudent(
    String name,
    String grade,
    String age,
    String guardianName,
    String guardianPhone,
  ) async {
    final updatedStudent = StudentModel(
      id: student.id,
      name: name,
      grade: grade,
      age: age,
      guardianName: guardianName,
      guardianPhone: guardianPhone,
      profileImage: profileImage!.path,
    );

    await DatabaseHelper().insertStudent(updatedStudent);
    student = updatedStudent;
    notifyListeners();
  }

 
}
