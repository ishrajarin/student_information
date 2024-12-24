import 'package:flutter/material.dart';
import '/home.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
//import 'package:image_picker/image_picker.dart';
import 'database/db_helper.dart';
import 'model/student.dart';
//import 'dart:io';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {

  late DatabaseHelper dbHelper;

  final nameController = TextEditingController();
  final studentidController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();
  //File? _image; // Variable to store the selected image


  /*Future<void> pickImage() async {
    //final picker = ImagePicker();
    //final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    /if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }*/
  //add notes to database
  Future addStudent() async
  {
    final newStudent = Student(
      name: nameController.text,
      studentid: studentidController.text,
      phone: phoneController.text,
      email: emailController.text,
      location: locationController.text,
    );

    //if data insert successfully, its return row number which is greater that 1 always
    int check= await dbHelper.insertData(newStudent.toMap());
    print("Check=$check");
    if(check>0)
    {


      Get.snackbar("Success", "Student registered successfully",snackPosition: SnackPosition.BOTTOM);
      Get.offAll(const Home());
    }
    else
    {
      Get.snackbar("Error", "Failed to register student",snackPosition: SnackPosition.BOTTOM);
    }


  }


  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Register Student",style: TextStyle(
            color: Colors.white
        ),),


      ),
      body: Form(
        key: formKey,
        child:SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              /*if (_image != null) Image.file(_image!, height: 200, width: 200), // Display selected image
              ElevatedButton(
                onPressed: pickImage,
                child: Text("Pick Image"),
              ),*/
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Student Name",
                  hintText: "Student Name",
                  hintStyle: TextStyle(color: const Color.fromARGB(255, 181, 181, 181)),
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter student name";
                  }

                  return null;
                },
              ),

              SizedBox(height: 10,),
              TextFormField(
                controller: studentidController,
                //maxLines: 3,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Student ID",
                  hintText: "Student ID",
                  hintStyle: TextStyle(color: const Color.fromARGB(255, 181, 181, 181)),
                  prefixIcon: const Icon(Icons.numbers),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter student ID";
                  }else if (value.length > 7) {
                    return "Student ID must be no more than 7 characters";
                  }

                  return null;
                },
              ),

              SizedBox(height: 10,),
              TextFormField(
                controller: phoneController,
                //maxLines: 3,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  hintText: "Student Phone Number",
                  hintStyle: TextStyle(color: const Color.fromARGB(255, 181, 181, 181)),
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter phone number";
                  }else if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                    return "Phone number must be exactly 11 digits.";
                  }

                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: emailController,
                //maxLines: 3,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Student Email",
                  hintText: "example@email.com",
                  hintStyle: TextStyle(color: const Color.fromARGB(255, 181, 181, 181)),
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "example@email.com";
                  }
                  else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
                    return "Enter a valid email address";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: locationController,
                maxLines: 2,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Current Location",
                  hintText: "Road No, Building No, Area Name, City",
                  hintStyle: TextStyle(color: const Color.fromARGB(255, 181, 181, 181)),
                  prefixIcon: const Icon(Icons.location_on),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter location address";
                  }

                  return null;
                },
              ),

              SizedBox(height: 50,),

              ElevatedButton(
                style: ElevatedButton.styleFrom(

                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                onPressed: () async {
                  if(formKey.currentState!.validate())
                  {
                    formKey.currentState!.save();



                    addStudent();



                  }

                },
                child:  Text(
                  "Register Student",
                  style: const TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold),

                ),
              ),

            ],
          ),

        ) ,
      ),
    );
  }
}