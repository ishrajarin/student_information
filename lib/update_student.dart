import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'database/db_helper.dart';
import 'home.dart';
import 'model/student.dart';

class UpdateStudent extends StatefulWidget {
  final Student student;
  const UpdateStudent({super.key, required this.student});

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  late DatabaseHelper dbHelper;
  final nameController = TextEditingController();
  final studentidController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future updateStudent(int id) async {
    final updatedStudent = Student(
      name: nameController.text,
      studentid: studentidController.text,
      phone: phoneController.text,
      email: emailController.text,
      location: locationController.text,
    );

    int check = await dbHelper.updateData(updatedStudent.toMap(), id);
    if (check > 0) {
      Get.snackbar("Updated", "Student updated successfully", snackPosition: SnackPosition.BOTTOM);
      Get.offAll(Home());
    } else {
      Get.snackbar("Error", "Failed to update student", snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;
    nameController.text = widget.student.name!;
    studentidController.text = widget.student.studentid!;
    phoneController.text = widget.student.phone!;
    emailController.text = widget.student.email!;
    locationController.text = widget.student.location!;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Update Student", style: TextStyle(color: Colors.white)),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Student Name", prefixIcon: Icon(Icons.person)),
                validator: (value) => value!.isEmpty ? "Enter student name" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: studentidController,
                decoration: InputDecoration(labelText: "Student ID", prefixIcon: Icon(Icons.numbers)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter student ID";
                  } else if (value.length > 7) {
                    return "Student ID must be no more than 7 digits";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Phone Number", prefixIcon: Icon(Icons.phone)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter student phone number";
                  } else if (value.length < 11) {
                    return "Phone number must be at least 11 digits";
                  } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return "Phone number must contain only numbers";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email", prefixIcon: Icon(Icons.email)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter email";
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(labelText: "Student Location", prefixIcon: Icon(Icons.location_on)),
                validator: (value) => value!.isEmpty ? "Enter current location address" : null,
              ),
              SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    updateStudent(widget.student.id!);
                  }
                },
                child: Text("Update Student", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}