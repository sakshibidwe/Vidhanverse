import 'package:flutter/material.dart';
import 'home_page.dart'; // Import the HomePage widget
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const VidhanVerseApp()); // Removed the extra "flu" and ensured a semicolon is present
}

class VidhanVerseApp extends StatelessWidget {
  const VidhanVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'VidhanVerse',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomePage(), // Set HomePage as the home screen
        debugShowCheckedModeBanner: false // Removed the extra "f"
    );
  }
}