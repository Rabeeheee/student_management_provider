import 'package:flutter/material.dart';
import 'package:student_management_provider/db_functions.dart';
import 'package:student_management_provider/model/model.dart';

class StudentDetailsProvider with ChangeNotifier {
  List<StudentModel> _students = [];
  List<StudentModel> get students => _students;
  
  Future<void> fetchStudents() async {
    _students = await DatabaseHelper().fetchStudents();
    notifyListeners();
  }

  Future<void> deleteStudent(int id) async {
    await DatabaseHelper().deleteStudent(id);
    _students.removeWhere((student) => student.id == id);
    notifyListeners();
  }

  Future<void> updateStudent(StudentModel updatedStudent) async {
    final index = _students.indexWhere((student) => student.id == updatedStudent.id);
    if (index != -1) {
      _students[index] = updatedStudent;
      notifyListeners();
    }
  }

}
