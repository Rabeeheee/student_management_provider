import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/model/model.dart';
import 'package:student_management_provider/provider/student_provider.dart';
import 'package:student_management_provider/screens/student_details_screen.dart';

class StudentSearchDelegate extends SearchDelegate<String> {
  final List<StudentModel> students;

  StudentSearchDelegate(this.students);

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = students.where((student) {
      return student.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return _buildSearchListView(context, suggestions);
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = students.where((student) {
      return student.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return _buildSearchListView(context, results);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  // Reusable list view builder for search results
  Widget _buildSearchListView(BuildContext context, List<StudentModel> filteredStudents) {
    if (filteredStudents.isEmpty) {
      return Center(
        child: Text('No students found'),
      );
    }

    return ListView.builder(
      itemCount: filteredStudents.length,
      itemBuilder: (context, index) {
        final student = filteredStudents[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: FileImage(File(student.profileImage)),
          ),
          title: Text(student.name),
          subtitle: Text('Grade: ${student.grade}, Age: ${student.age}'),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              // Delete student using Provider
              final homeProvider = Provider.of<HomeProvider>(context, listen: false);
              homeProvider.deleteStudent(student);
            },
          ),
          onTap: () {
            // Navigate to student details screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => StudentDetailsScreen(student: student),
              ),
            );
          },
        );
      },
    );
  }
}
