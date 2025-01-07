import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/model/model.dart';
import 'package:student_management_provider/provider/student_details_provider.dart';
import 'package:student_management_provider/screens/update_student.dart';

class StudentDetailsScreen extends StatelessWidget {
  final StudentModel student;

  const StudentDetailsScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentDetailsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final updatedStudent = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateStudentScreen(student: student),
                ),
              ) as StudentModel?;

              if (updatedStudent != null) {
                studentProvider.updateStudent(updatedStudent);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Delete Student'),
                    content: Text('Are you sure you want to delete ${student.name}?'),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Delete'),
                        onPressed: () {
                          studentProvider.deleteStudent(student.id!);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await studentProvider.fetchStudents();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Consumer<StudentDetailsProvider>(
            builder: (context, studentProvider, child) {
              final updatedStudent = studentProvider.students.firstWhere(
                (s) => s.id == student.id,
                orElse: () => student, 
              );
          
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(File(updatedStudent.profileImage)),
                      ),
                      SizedBox(height: 20),
                      Text('Name: ${updatedStudent.name}', style: TextStyle(fontSize: 20)),
                      SizedBox(height: 10),
                      Text('Grade: ${updatedStudent.grade}', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      Text('Age: ${updatedStudent.age}', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      Text('Guardian Name: ${updatedStudent.guardianName}', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      Text('Guardian Phone: ${updatedStudent.guardianPhone}', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
