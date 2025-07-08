import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jezt_internship_app/presentation/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JEZT INTERN APP',
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      home: const ScreenLogin(),
    );
  }
}
