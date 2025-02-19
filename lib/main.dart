import 'package:flutter/material.dart';
import 'package:youtube/ui/screens/home_screen.dart';

void main() {
  runApp(const Youtube());
}

class Youtube extends StatelessWidget {
  const Youtube({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: Colors.red,
            titleTextStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 24),
            iconTheme: IconThemeData(color: Colors.white)
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)
      ),
      home: HomeScreen(),
    );
  }
}