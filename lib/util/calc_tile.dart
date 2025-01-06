// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CalcTile extends StatelessWidget {
  final String taskName;
  final num mark;
  final num weight;
  Function(BuildContext)? deleteFunction;
  CalcTile({
    super.key,
    required this.taskName,
    required this.mark,
    required this.weight,
    required this.deleteFunction,
  });

  double percentBarCalc() {
    if (mark > 100) {
      return 100;
    } else if (mark < 0) {
      return 0;
    } else {
      return mark.toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(25),
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
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 206, 186, 184),
                  ),
                  width: 400,
                  child: Center(
                    child: SizedBox(
                      height: 30,
                      child: Text(
                        taskName,
                        style: GoogleFonts.poppins(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 206, 186, 184),
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 134,
                            height: 35,
                            child: Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Weight: ',
                                      style: GoogleFonts.poppins(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      weight.toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 206, 186, 184),
                        ),
                        width: 134,
                        child: Center(
                          child: SizedBox(
                            height: 35,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Grade: ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    mark.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '% ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                LinearPercentIndicator(
                  alignment: MainAxisAlignment.center,
                  animation: true,
                  animateFromLastPercent: true,
                  width: 300,
                  lineHeight: 16,
                  percent: percentBarCalc() / 100,
                  backgroundColor: Color.fromARGB(255, 151, 149, 149),
                  progressColor: Color.fromARGB(255, 206, 186, 184),
                )
              ],
            )));
  }
}
