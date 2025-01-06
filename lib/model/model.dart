class StudentModel {
  final int? id;
  final String name;
  final String grade;
  final String age;
  final String guardianName;
  final String guardianPhone;
  final String profileImage;

  StudentModel({
    this.id,
    required this.name,
    required this.grade,
    required this.age,
    required this.guardianName,
    required this.guardianPhone,
    required this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'grade': grade,
      'age': age,
      'guardianName': guardianName,
      'guardianPhone': guardianPhone,
      'profileImage': profileImage,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'],
      name: map['name'],
      grade: map['grade'],
      age: map['age'],
      guardianName: map['guardianName'],
      guardianPhone: map['guardianPhone'],
      profileImage: map['profileImage'],
    );
  }
}
