import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_manag_provider/common_widget/delete_dialog.dart';
import 'package:student_manag_provider/constrains/color.dart';
import 'package:student_manag_provider/constrains/constant.dart';
import 'package:student_manag_provider/model/student_model.dart';
import 'package:student_manag_provider/provider/student_detail_provider.dart';
import 'package:student_manag_provider/view/edit_student.dart';

class StudentDetailspage extends StatelessWidget {
   final Student student;
   StudentDetailspage({ required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile', style: titletxt),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteDialog(context);

            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditStudentScreen(student: student),
                ),
              ).then((_) => Navigator.pop(context));
            },
          ),
        ],
        backgroundColor:Tcolo.primarycolor1,
      ),
      body: Column(
        children: [
          kheight,
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(File(student.profilePicturePath)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kheight,
                  kheight,
                  Text(
                    'Name : ${student.name}',
                    style: contenttxt,
                  ),
                  kheight,
                  Text(
                    'Schoolname : ${student.schoolname}',
                    style: contenttxt,
                  ),
                  kheight,
                  Text(
                    'Fathername : ${student.fathername}',
                    style: contenttxt,
                  ),
                  kheight,
                  Text(
                    'Age : ${student.age}',
                    style: contenttxt,
                  ),
                  kheight,
                  const SizedBox(
                    width: 63,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _deleteDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        onCancel: () {
          Navigator.pop(context);
        },
        onDelete: () {
          Provider.of<StudentDetailProvider>(context, listen: false)
              .deleteStudent(student.id);
          void popUntilHomeScreen(BuildContext context) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
          popUntilHomeScreen(context);
        },
      ),
    );
  }
}