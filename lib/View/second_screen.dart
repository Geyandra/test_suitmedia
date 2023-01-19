import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/View-Model/first_screen.dart';
import 'package:suitmedia_test/View-Model/third_screen.dart';
import 'package:suitmedia_test/View/first_screen.dart';
import 'package:suitmedia_test/View/third_screen.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          color: const Color.fromRGBO(85, 74, 240, 1),
        ),
        title: const Text("Second Screen"),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Button(
          text: "Choose a User",
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ThirdScreen(),
            ));
          }),
      body: Stack(
        children: [
          Consumer<FirstScreenProvider>(
            builder: (context, value, child) => ListTile(
              title: const Text(
                "Welcome",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              subtitle: Text(
                value.nameuser,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
          ),
          Consumer<ThirdScreenProvider>(builder: (context, value, child) => Center(
            child: Text(
              value.getuser != null ? "${value.getuser!.firstName} ${value.getuser!.lastName}" : ("Selected User Name"),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),),
          
        ],
      ),
    );
  }
}
