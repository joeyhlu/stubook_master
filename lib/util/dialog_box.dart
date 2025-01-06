import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubook/util/button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  //
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 234, 221, 221),
      content: SizedBox(
          height: 120,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add a New Task",
                      hintStyle: GoogleFonts.poppins()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(text: "Save", onPressed: onSave),
                    const SizedBox(width: 12),
                    MyButton(text: "Cancel", onPressed: onCancel),
                  ],
                ),
              ])),
    );
  }
}
