import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/model/model.dart';
import 'package:student_management_provider/provider/student_provider.dart';
import 'package:student_management_provider/screens/add_student_screen.dart';
import 'package:student_management_provider/screens/student_details_screen.dart';
import 'package:student_management_provider/screens/student_search_delegate.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: StudentSearchDelegate(
                    Provider.of<HomeProvider>(context, listen: false).students),
              );
            },
          ),
          ToggleButtons(
            // ignore: sort_child_properties_last
            children: [
              Icon(Icons.list),
              Icon(Icons.grid_view),
            ],
            isSelected: [
              !Provider.of<HomeProvider>(context).isGridView,
              Provider.of<HomeProvider>(context).isGridView,
            ],
            onPressed: (index) {
              Provider.of<HomeProvider>(context, listen: false).toggleView(); 
            },
          ),
        ],
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          return RefreshIndicator(
            onRefresh: provider.fetchStudents,
            child: provider.isGridView
                ? _buildGridView(provider)
                : _buildListView(provider),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newStudent = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddStudentScreen()),
          ) as StudentModel?;

          if (newStudent != null) {
            // ignore: use_build_context_synchronously
            Provider.of<HomeProvider>(context, listen: false)
                .addStudent(newStudent); 
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }


void _showDeleteConfirmationDialog(BuildContext context, StudentModel student, HomeProvider provider) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete Student'),
        content: Text('Are you sure you want to delete this student?'),
        actions: [
          TextButton(
            onPressed: () {
              // Close the dialog without doing anything
              Navigator.of(context).pop();
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              // Close the dialog and delete the student
              provider.deleteStudent(student);
              Navigator.of(context).pop();
            },
            child: Text('Yes'),
          ),
        ],
      );
    },
  );
}

// Inside _buildListView

Widget _buildListView(HomeProvider provider) {
  return ListView.builder(
    itemCount: provider.students.length,
    itemBuilder: (context, index) {
      final student = provider.students[index];
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: FileImage(File(student.profileImage)),
        ),
        title: Text(student.name),
        subtitle: Text('Grade: ${student.grade}, Age: ${student.age}'),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            _showDeleteConfirmationDialog(context, student, provider); // Show the confirmation dialog
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => StudentDetailsScreen(student: student)),
          );
        },
      );
    },
  );
}

// Inside _buildGridView

Widget _buildGridView(HomeProvider provider) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 3 / 2,
    ),
    itemCount: provider.students.length,
    itemBuilder: (context, index) {
      final student = provider.students[index];
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => StudentDetailsScreen(student: student)),
          );
        },
        child: Card(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.file(
                      File(student.profileImage),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      student.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Grade: ${student.grade}, Age: ${student.age}'),
                  ),
                ],
              ),
              Positioned(
                right: 4,
                top: 70,
                child: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, student, provider); // Show the confirmation dialog
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


}
