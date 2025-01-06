import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubook/util/button.dart';

class DialogBox extends StatelessWidget {
  final textInfo;
  final markGrade;
  final markWeight;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.textInfo,
    required this.markGrade,
    required this.markWeight,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 234, 221, 221),
      content: SizedBox(
          height: 240,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: textInfo,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add a New Task",
                      hintStyle: GoogleFonts.poppins()),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: markGrade,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add a New Mark",
                      hintStyle: GoogleFonts.poppins()),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: markWeight,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add a New Weight",
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

class WhitelistingTextInputFormatter {}
