import 'package:flutter/material.dart';
import 'package:stubook/util/button.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class confirmationBox extends StatelessWidget {
  VoidCallback sure;
  VoidCallback onCancel;

  confirmationBox({
    super.key,
    required this.sure,
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
                Text(
                  style: GoogleFonts.poppins(),
                  textAlign: TextAlign.center,
                  'Are you sure you want to delete all assignments?',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(text: "Yes", onPressed: sure),
                    const SizedBox(width: 12),
                    MyButton(text: "Cancel", onPressed: onCancel),
                  ],
                ),
              ])),
    );
  }
}
