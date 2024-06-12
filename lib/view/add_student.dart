import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_manag_provider/common_widget/round_button.dart';
import 'package:student_manag_provider/constrains/color.dart';
import 'package:student_manag_provider/constrains/constant.dart';
import 'package:student_manag_provider/database/database_helper.dart';
import 'package:student_manag_provider/model/student_model.dart';
import 'package:student_manag_provider/provider/add_student_provider.dart';


class AddStudentScreen extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _schoolnameController = TextEditingController();
  final _fathernameController = TextEditingController();
  final DatabaseHelper databaseHelper = DatabaseHelper();

  AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Students", style: titletxt),
        backgroundColor:Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formkey,
          child: Consumer<AddStudentProvider>(
            builder: (context, addStudentProvider, _) {
              return ListView(
                children: [
                  GestureDetector(
                    onTap: () async {
                      XFile? img =
                          await ImagePicker().pickImage(source: ImageSource.gallery);
                      Provider.of<AddStudentProvider>(context, listen: false)
                          .setImage(img);
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor:Colors.grey,
                      backgroundImage: addStudentProvider.profilePicturePath != null
                          ? FileImage(File(addStudentProvider.profilePicturePath!))
                          : null,
                      child: addStudentProvider.profilePicturePath == null
                          ? const Icon(
                              Icons.add_a_photo,
                              size: 35,
                            )
                          : null,
                    ),
                  ),
                  kheight20,
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text('Student Name'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Student Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kheight17,
                  TextFormField(
                    controller: _schoolnameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text(' School Name'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter The school Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kheight17,
                  TextFormField(
                    controller: _fathernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text('Father Name'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Father Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kheight17,
                  TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text('Age'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Age';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  kheight40,
                  RoundButton(
                    title: 'Save',
                    buttonColor: Tcolo.primarycolor1,
                    textColor: Tcolo.secondarycolor1,
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        final student = Student(
                          id: 0,
                          name: _nameController.text,
                          schoolname: _schoolnameController.text,
                          fathername: _fathernameController.text,
                          age: int.parse(_ageController.text),
                          profilePicturePath: addStudentProvider.profilePicturePath ?? '',
                        );
                        databaseHelper.insertStudent(student).then((id) {
                          if (id > 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Student added successfully')),
                            );
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Failed to add student')),
                            );
                          }
                        });
                            Provider.of<AddStudentProvider>(context, listen: false).clearImage();
                      }
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
