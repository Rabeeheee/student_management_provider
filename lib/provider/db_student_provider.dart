import 'package:flutter/material.dart';
import 'package:student_management_provider/db_functions.dart';
import 'package:student_management_provider/model/model.dart';

class StudentProvider extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<StudentModel> _students = [];

  List<StudentModel> get students => _students;

  Future<void> fetchStudents() async {
    _students = await _databaseHelper.fetchStudents();
    notifyListeners();  
  }

  Future<void> insertStudent(StudentModel student) async {
    await _databaseHelper.insertStudent(student);
    await fetchStudents();
  }

  Future<void> deleteStudent(int id) async {
    await _databaseHelper.deleteStudent(id);
    await fetchStudents();  
  }
}
