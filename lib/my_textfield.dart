import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hinText;
  final bool obscureText;

  const MyTextField(this.controller, this.hinText, this.obscureText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder:const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black54
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey.shade400
              )
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hinText,
          hintStyle: TextStyle(color: Colors.grey[800])
        ),
      ),
    );
  }
}
