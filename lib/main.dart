import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_manag_provider/provider/add_student_provider.dart';
import 'package:student_manag_provider/provider/edit_provider.dart';
import 'package:student_manag_provider/provider/home_provider.dart';

import 'package:student_manag_provider/provider/student_detail_provider.dart';
import 'package:student_manag_provider/view/screen_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => AddStudentProvider()),
        ChangeNotifierProvider(create: (_) => StudentDetailProvider()),
        ChangeNotifierProvider(create: (_) => EditStudentProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Students',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
      ),
    );
  }
}
