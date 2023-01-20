import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suitmedia_test/View-Model/first_screen.dart';
import 'package:suitmedia_test/View-Model/third_screen.dart';
import 'package:suitmedia_test/View/first_screen.dart';
import 'package:provider/provider.dart';

void main() {
  
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => FirstScreenProvider()),
    ChangeNotifierProvider(create: (_) => ThirdScreenProvider())
  ],
  child: const MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontWeight: FontWeight.w500))
              .fontFamily,
          useMaterial3: true),
      home: FirstScreen(),
    );
  }
}
