import 'package:flutter/material.dart';
import 'package:student_management_provider/db_functions.dart';
import 'package:student_management_provider/model/model.dart';

class ModelProvider with ChangeNotifier {
  List<StudentModel> _students = [];

  List<StudentModel> get students => _students;

  Future<void> fetchStudents() async {
    _students = await DatabaseHelper().fetchStudents();
    notifyListeners(); 
  }

  Future<void> addStudent(StudentModel student) async {
    await DatabaseHelper().insertStudent(student);
    await fetchStudents();  
  }

  Future<void> deleteStudent(int id) async {
    await DatabaseHelper().deleteStudent(id);
    await fetchStudents();  
  }
}
