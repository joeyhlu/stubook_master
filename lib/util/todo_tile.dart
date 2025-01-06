// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              label: 'Delete',
              backgroundColor: const Color.fromARGB(255, 234, 41, 27),
              borderRadius: BorderRadius.circular(2),
            )
          ],
        ),
        child: SizedBox(
          height: 28,
          //padding: EdgeInsets.all(24),
          //decoration: BoxDecoration(
          //color: Color.fromARGB(0, 200, 88, 88),
          //borderRadius: BorderRadius.circular(12),
          //),
          child: Row(
            children: [
              Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: const Color.fromARGB(255, 4, 8, 4)),
              Text(
                taskName,
                style: GoogleFonts.poppins(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
