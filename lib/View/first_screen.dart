import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/View-Model/first_screen.dart';
import 'package:suitmedia_test/View/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

final palindromecontrol = TextEditingController();
final namecontrol = TextEditingController();

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              maxRadius: 50,
              backgroundColor: Colors.white54,
              child: Icon(
                Icons.person_add_alt_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(
              height: 52,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextFormField(
                controller: namecontrol,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Name",
                  hintStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(104, 103, 119, 0.36))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextFormField(
                controller: palindromecontrol,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Palindrome",
                  hintStyle:
                      const TextStyle(color: Color.fromRGBO(104, 103, 119, 0.36)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            Button(
              onPressed: () {
                if (palindromecontrol.text.isNotEmpty) {
                  context.read<FirstScreenProvider>().palindrome(
                      text: palindromecontrol.text, context: context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text("text empty"),
                    duration: const Duration(seconds: 5),
                    action: SnackBarAction(
                        label: "Dismiss",
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        }),
                  ));
                }
              },
              text: "CHECK",
            ),
            const SizedBox(
              height: 15,
            ),
            Button(
                text: "NEXT",
                onPressed: () {
                  if (namecontrol.text.isNotEmpty) {
                    context
                        .read<FirstScreenProvider>()
                        .name(name: namecontrol.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SecondScreen(),
                        ));
                    palindromecontrol.clear();
                    namecontrol.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text("name can't be empty"),
                      duration: const Duration(seconds: 5),
                      action: SnackBarAction(
                          label: "Dismiss",
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          }),
                    ));
                  }
                })
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const Button({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              backgroundColor: const Color.fromRGBO(43, 99, 123, 1),
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            )));
  }
}
