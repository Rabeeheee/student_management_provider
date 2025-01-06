import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/model/model.dart';
import 'package:student_management_provider/provider/student_update_provider.dart';

class UpdateStudentScreen extends StatelessWidget {
  final StudentModel student;

  UpdateStudentScreen({required this.student});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentUpdateProvider>(context);
    studentProvider.initializeStudent(student);

    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController(text: student.name);
    final _gradeController = TextEditingController(text: student.grade);
    final _ageController = TextEditingController(text: student.age);
    final _guardianNameController = TextEditingController(text: student.guardianName);
    final _guardianPhoneController = TextEditingController(text: student.guardianPhone);

    final ImagePicker _imagePicker = ImagePicker();

    Future<void> _pickImageFromGallery() async {
      final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        studentProvider.updateProfileImage(File(pickedFile.path));
      }
    }

    void _updateStudent() async {
      if (_formKey.currentState!.validate()) {
        final name = _nameController.text.trim();
        final grade = _gradeController.text.trim();
        final age = _ageController.text.trim();
        final guardianName = _guardianNameController.text.trim();
        final guardianPhone = _guardianPhoneController.text.trim();

        await studentProvider.updateStudent(
          name,
          grade,
          age,
          guardianName,
          guardianPhone,
        );

        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Student'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImageFromGallery,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: studentProvider.profileImage != null
                        ? FileImage(studentProvider.profileImage!)
                        : AssetImage('assets/default_avatar.png') as ImageProvider,
                    child: studentProvider.profileImage == null
                        ? Icon(Icons.camera_alt, size: 30, color: Colors.white)
                        : null,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
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
                  controller: _gradeController,
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
                  controller: _ageController,
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
                  controller: _guardianNameController,
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
                  controller: _guardianPhoneController,
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
                  onPressed: _updateStudent,
                  child: Text('Update Student'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
