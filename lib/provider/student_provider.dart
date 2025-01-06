import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:student_management_provider/db_functions.dart';
import 'package:student_management_provider/model/model.dart';

class HomeProvider extends ChangeNotifier {
  List<StudentModel> students = [];  
  bool isGridView = true;  

  HomeProvider() {
    fetchStudents();  
  }

 Future<void> fetchStudents() async {
  try {
    final studentList = await DatabaseHelper().fetchStudents();
    students = studentList;
    notifyListeners();
    log("Students fetched: ${students.length}"); 
  } catch (e) {
    log('Error fetching students: $e');
  }
}


  void addStudent(StudentModel student) {
    students.add(student);  
    notifyListeners();  
  }


void deleteStudent(StudentModel student) {
  students.remove(student); 
  DatabaseHelper().deleteStudent(student.id!); 
  fetchStudents();
  notifyListeners();
}



  void toggleView() {
    isGridView = !isGridView; 
    notifyListeners();  
  }
}
