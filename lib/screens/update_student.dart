import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/model/model.dart';
import 'package:student_management_provider/provider/student_update_provider.dart';

class UpdateStudentScreen extends StatelessWidget {
  final StudentModel student;

  const UpdateStudentScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentUpdateProvider>(context);
    studentProvider.initializeStudent(student);

    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: student.name);
    final gradeController = TextEditingController(text: student.grade);
    final ageController = TextEditingController(text: student.age);
    final guardianNameController = TextEditingController(text: student.guardianName);
    final guardianPhoneController = TextEditingController(text: student.guardianPhone);

    final ImagePicker imagePicker = ImagePicker();

    Future<void> pickImageFromGallery() async {
      final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        studentProvider.updateProfileImage(File(pickedFile.path));
      }
    }

    void updateStudent() async {
      if (formKey.currentState!.validate()) {
        final name = nameController.text.trim();
        final grade = gradeController.text.trim();
        final age = ageController.text.trim();
        final guardianName = guardianNameController.text.trim();
        final guardianPhone = guardianPhoneController.text.trim();

        await studentProvider.updateStudent(
          name,
          grade,
          age,
          guardianName,
          guardianPhone,
        );

        // ignore: use_build_context_synchronously
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
            key: formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: pickImageFromGallery,
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
                  controller: nameController,
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
                  controller: gradeController,
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
                  controller: ageController,
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
                  controller: guardianNameController,
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
                  controller: guardianPhoneController,
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
                  onPressed: updateStudent,
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
