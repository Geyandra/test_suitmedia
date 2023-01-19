import 'package:flutter/material.dart';

class FirstScreenProvider with ChangeNotifier {
  String nameuser = '';

  Future<void> palindrome(
      {required String text, required BuildContext context}) async {
    String lower = text.toLowerCase();
    String reverse = lower.split("").reversed.join("");
    if (lower == reverse) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("isPalindrome"),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
            label: "Dismiss",
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("notPalindrome"),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
            label: "Dismiss",
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }),
      ));
    }
    notifyListeners();
  }

  Future<void> name({required String name})async{
    nameuser = name;
    notifyListeners();
  }
}
