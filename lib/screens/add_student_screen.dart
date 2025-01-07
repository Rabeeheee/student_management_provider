import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/provider/add_student_provider.dart';

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddStudentProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Student'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<AddStudentProvider>(
              builder: (context, studentProvider, child) {
                return Form(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: studentProvider.pickImageFromGallery,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: studentProvider.profileImage != null
                              ? FileImage(studentProvider.profileImage!)
                              : AssetImage('assets/image.jg') as ImageProvider,
                          child: studentProvider.profileImage == null
                              ? Icon(Icons.camera_alt, size: 30, color: Colors.white)
                              : null,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: studentProvider.nameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the full name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: studentProvider.gradeController,
                        decoration: InputDecoration(
                          labelText: 'Grade',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the grade';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: studentProvider.ageController,
                        decoration: InputDecoration(
                          labelText: 'Age',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the age';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: studentProvider.guardianNameController,
                        decoration: InputDecoration(
                          labelText: 'Guardian Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the guardian name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: studentProvider.guardianPhoneController,
                        decoration: InputDecoration(
                          labelText: 'Guardian Phone',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the guardian phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => studentProvider.saveStudent(context),
                        child: Text('Save Student'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
