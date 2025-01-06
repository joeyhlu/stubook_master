import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:stubook/database/data.dart';
import 'package:stubook/pages/mark_calc_hp.dart';
import 'package:stubook/pages/menu.dart';
import 'package:stubook/util/calc_tile.dart';
import 'package:stubook/util/confirmation.dart';
import 'package:stubook/util/popupCalc.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CalcPage4 extends StatefulWidget {
  const CalcPage4({super.key});

  @override
  State<CalcPage4> createState() => _CalcPageState();
}

class _CalcPageState extends State<CalcPage4> {
  final _myBox = Hive.box('mybox');
  MarkDataBase4 db = MarkDataBase4();
  CourseDataBase dbCourse = CourseDataBase();
  GradesDataBase dbGrade = GradesDataBase();
  @override
  void initState() {
    if (_myBox.get("MARKCALC4") == null) {
      db.initialData();
    } else {
      db.loadData();
    }
    db.updateDataBase();

    if (_myBox.get("COURSES") == null) {
      dbCourse.initialData();
    } else {
      dbCourse.loadData();
    }
    dbCourse.updateDataBase();

    if (_myBox.get("GRADES") == null) {
      dbGrade.initialData();
    } else {
      dbGrade.loadData();
    }
    dbGrade.updateDataBase();
  }

  final _textInfo = TextEditingController();
  final _markGrade = TextEditingController();
  final _markWeight = TextEditingController();

  void deleteTask(int index) {
    setState(() {
      db.markList.removeAt(index);
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    num markGradeValue = num.parse(_markGrade.text);
    num markWeightValue = num.parse(_markWeight.text);
    setState(() {
      db.markList.add([_textInfo.text, markGradeValue, markWeightValue]);
      _textInfo.clear();
      _markGrade.clear();
      _markWeight.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }
  //Creating new task LIKE THE GUY I AM

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          textInfo: _textInfo,
          markGrade: _markGrade,
          markWeight: _markWeight,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
    db.updateDataBase();
  }

  void step2DeleteTasks() {
    showDialog(
      context: context,
      builder: (context) {
        return confirmationBox(
          sure: deleteAllTasks,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );

    db.updateDataBase();
  }

  void deleteAllTasks() {
    setState(() {
      db.markList.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  num calcAverage() {
    num average = 0;
    num totalWeight = 0;
    num totalMark = 0;
    for (int i = 0; i < db.markList.length; i++) {
      totalWeight += db.markList[i][2];
      totalMark += db.markList[i][2] * db.markList[i][1];
    }
    average = totalMark / totalWeight;
    if (average < 0) {
      average = 0;
    } else if (average > 100) {
      average = 100;
    }
    dbGrade.grades[3] = average;
    dbGrade.updateDataBase();
    return average;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: const Color.fromARGB(255, 242, 242, 243),
          leading: Builder(builder: (BuildContext context) {
            return Row(children: [
              const SizedBox(width: 6, height: 6),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_outlined,
                      color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CalcHPage()));
                  },
                  iconSize: 35,
                  color: Colors.black,
                ),
              ),
            ]);
          }),
          title: Text(
            dbCourse.courses.length < 5 ? dbCourse.courses[3] : 'Course 4',
            style: GoogleFonts.poppins(
                fontSize: 35,
                color: const Color.fromARGB(255, 0, 0, 5),
                fontWeight: FontWeight.normal),
          ),
          elevation: 0,
        ),
        body: Column(children: [
          Align(
            alignment: Alignment.center,
            child: Column(children: [
              const SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: step2DeleteTasks,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 211, 211, 213),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    // <-- Splash color
                  ),
                  child:
                      const Icon(Icons.delete, color: Colors.black, size: 30),
                ),
                const SizedBox(width: 25),
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      border: Border.all(
                          width: 10,
                          color: const Color.fromARGB(255, 183, 181, 181)),
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        calcAverage().toStringAsFixed(1).toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 29,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '%',
                        style: GoogleFonts.poppins(
                          fontSize: 29,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )),
                ),
                const SizedBox(width: 25),
                ElevatedButton(
                  onPressed: createNewTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 211, 211, 213),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    // <-- Splash color
                  ),
                  child: const Icon(Icons.add, color: Colors.black, size: 30),
                ),
                const SizedBox(width: 10),
              ]),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: db.markList.length,
              itemBuilder: (context, index) {
                return CalcTile(
                  taskName: db.markList[index][0],
                  mark: db.markList[index][1],
                  weight: db.markList[index][2],
                  deleteFunction: (context) => deleteTask(index),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
