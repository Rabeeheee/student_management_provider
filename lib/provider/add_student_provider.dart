import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management_provider/db_functions.dart';
import 'package:student_management_provider/model/model.dart';

class AddStudentProvider with ChangeNotifier {
  final _imagePicker = ImagePicker();
  File? _profileImage;
  final _nameController = TextEditingController();
  final _gradeController = TextEditingController();
  final _ageController = TextEditingController();
  final _guardianNameController = TextEditingController();
  final _guardianPhoneController = TextEditingController();

  File? get profileImage => _profileImage;

  TextEditingController get nameController => _nameController;
  TextEditingController get gradeController => _gradeController;
  TextEditingController get ageController => _ageController;
  TextEditingController get guardianNameController => _guardianNameController;
  TextEditingController get guardianPhoneController => _guardianPhoneController;

  Future<void> pickImageFromGallery() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _profileImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> saveStudent(BuildContext context) async {
    if (_nameController.text.isEmpty || _gradeController.text.isEmpty || _ageController.text.isEmpty || _guardianNameController.text.isEmpty || _guardianPhoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (_profileImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a profile image')),
      );
      return;
    }

    final student = StudentModel(
      name: _nameController.text,
      grade: _gradeController.text,
      age: _ageController.text,
      guardianName: _guardianNameController.text,
      guardianPhone: _guardianPhoneController.text,
      profileImage: _profileImage!.path,
    );

    await DatabaseHelper().insertStudent(student);

    Navigator.of(context).pop();
  }
}
