import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'add_student.dart';
import 'update_student.dart';
import 'database/db_helper.dart';
import 'model/student.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //declared variables
  late DatabaseHelper dbHelper;
  List<Student> students = [];


  @override
  void initState() {
    super.initState();
    //initializing dbHelper
    dbHelper = DatabaseHelper.instance;

    //load notes on startup
    loadAllStudents();
  }


  //for loading data from db
  Future loadAllStudents() async {
    final data = await dbHelper.getAllData();
    setState(() {

      //This line converts a list of map entries (database records) into a list of Note objects using the Note.fromMap method, making it easier to work with custom objects in your app.
      //each element is a map, represented by e
      students = data.map((e) => Student.fromMap(e)).toList();


    });
  }



  //for deleting a note
  Future deleteStudent(int id) async {
    int check= await dbHelper.deleteData(id);
    if(check>0){
      Fluttertoast.showToast(msg:"Student deleted successfully");
      loadAllStudents();
    }
    else
    {
      //Fluttertoast.showToast(msg: "Failed to delete note");
      Fluttertoast.showToast(msg:"Failed to delete note");
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: const Text("Student List",style: TextStyle(
            color: Colors.white
        ),),
      ),
      body: students.isEmpty
          ? Center(child: Text("No students registered!"))
          : ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          Student student = students[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                    color: Colors.lightGreenAccent, width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              onTap: () {
                Get.to(UpdateStudent(student: student));
              },  // for clickable list item
              title: Text(student.name!, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("ID: "+student.studentid!),
              leading: const Icon(
                Icons.note_alt_outlined,
                size: 40,

              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete,color: Colors.redAccent,size: 40,),
                onPressed: () {


                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    headerAnimationLoop: false,
                    animType: AnimType.bottomSlide,
                    title: 'Delete',
                    desc: 'Are you sure you want to delete registered student?',
                    buttonsTextStyle:
                    const TextStyle(color: Colors.white),
                    showCloseIcon: true,
                    btnCancelOnPress: () {},
                    btnOkText: 'YES',
                    btnCancelText: 'NO',
                    btnOkOnPress: () {

                      deleteStudent(student.id!);
                      Get.back();

                    },
                  ).show();
                } ,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // shape: CircleBorder(
        //   side: BorderSide(color: Colors.blue),
        // ),  //for making circle shape
        backgroundColor: Colors.lightGreenAccent,
        tooltip: "Add Student",
        mini: false,
        onPressed: (){
          Get.to(const AddStudent());
        },
        child: const Icon(Icons.add,
          color: Colors.white,),
      ),
    );
  }
}