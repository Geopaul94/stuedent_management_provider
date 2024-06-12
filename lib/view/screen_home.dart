import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_manag_provider/constrains/color.dart';
import 'package:student_manag_provider/constrains/constant.dart';
import 'package:student_manag_provider/provider/home_provider.dart';
import 'package:student_manag_provider/view/add_student.dart';
import 'package:student_manag_provider/view/student_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Tcolo.primarycolor1,
        title: !homeProvider.isSearching
            ? const Text('Student List', style: titletxt)
            : TextField(
                style: const TextStyle(color: Colors.white),
                onChanged: (query) {
                  homeProvider.filterStudents(query);
                },
                decoration: const InputDecoration(
                  hintText: 'Search student here',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              homeProvider.toggleSearch();
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: homeProvider.filteredStudents.isEmpty
          ? const Center(
              child: SizedBox(
                width: 100,
                child: Text(
                  'No data available ',
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: homeProvider.filteredStudents.length,
              itemBuilder: (context, index) {
                final student = homeProvider.filteredStudents[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentDetailspage(
                          student: student,
                        ),
                      ),
                    ).then((value) => homeProvider.refreshStudentList());
                  },
                  child: Card(
                    color: index.isEven ? Colors.white : Colors.green[200],
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                            FileImage(File(student.profilePicturePath)),
                      ),
                      title: Text(
                        student.name,
                        style: const TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(student.schoolname),
                      trailing: Text('age:${student.age.toString()}'),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddStudentScreen()))
              .then((value) => homeProvider.refreshStudentList());
        },
        backgroundColor: Color.fromARGB(255, 165, 199, 166),
        child: const Icon(Icons.add),
      ),
    );
  }
}
