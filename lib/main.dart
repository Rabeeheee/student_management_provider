import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/provider/add_student_provider.dart';
import 'package:student_management_provider/provider/db_student_provider.dart';
import 'package:student_management_provider/provider/model_provider.dart';
import 'package:student_management_provider/provider/student_details_provider.dart';
import 'package:student_management_provider/provider/student_provider.dart';
import 'package:student_management_provider/provider/student_update_provider.dart';
import 'package:student_management_provider/screens/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentDetailsProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => AddStudentProvider()),
        ChangeNotifierProvider(create: (context) => StudentUpdateProvider()),
        ChangeNotifierProvider(create: (context) => StudentProvider()),
        ChangeNotifierProvider(create: (context) => ModelProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
