import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:stubook/database/data.dart';
import 'package:stubook/pages/home_page.dart';
import 'package:stubook/pages/mark_calculator1.dart';
import 'package:stubook/pages/mark_calculator2.dart';
import 'package:stubook/pages/mark_calculator3.dart';
import 'package:stubook/pages/mark_calculator4.dart';
import 'package:stubook/pages/menu.dart';

class CalcHPage extends StatefulWidget {
  const CalcHPage({super.key});

  @override
  State<CalcHPage> createState() => _CalcPageState();
}

class _CalcPageState extends State<CalcHPage> {
  final _myBox = Hive.box('mybox');
  late TextEditingController controller;
  CourseDataBase db = CourseDataBase();
  GradesDataBase dbGrade = GradesDataBase();
  @override
  void initState() {
    super.initState();
    if (_myBox.get("COURSES") == null) {
      db.initialData();
    } else {
      db.loadData();
    }
    db.updateDataBase();

    if (_myBox.get("GRADES") == null) {
      dbGrade.initialData();
    } else {
      dbGrade.loadData();
    }
    dbGrade.updateDataBase();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    db.updateDataBase();
  }

  String calcAverage() {
    String average = '';

    num cnt = 0;
    num avg = 0;
    if (!dbGrade.grades[0].isNaN) {
      cnt++;
      avg += dbGrade.grades[0];
      print("1");
    }
    if (!dbGrade.grades[1].isNaN) {
      cnt++;
      avg += dbGrade.grades[1];
      print("2");
    }

    if (!dbGrade.grades[2].isNaN) {
      cnt++;
      avg += dbGrade.grades[2];
      print("3");
    }

    if (!dbGrade.grades[3].isNaN) {
      cnt++;
      avg += dbGrade.grades[3];
      print("4");
    }
    avg = avg / cnt;

    average = avg.toStringAsFixed(1).toString();
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
                            builder: (context) => const menuPage()));
                  },
                  iconSize: 35,
                  color: Colors.black,
                ),
              ),
            ]);
          }),
          title: Text(
            'Courses',
            style: GoogleFonts.poppins(
                fontSize: 35,
                color: const Color.fromARGB(255, 0, 0, 5),
                fontWeight: FontWeight.normal),
          ),
          elevation: 0,
        ),
        body: Center(
          child: Column(children: [
            Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {},
                  child: Container(
                      color: Color.fromARGB(255, 232, 230, 230),
                      height: 35,
                      child: Center(
                        child: Text(
                          'Overall',
                          style: GoogleFonts.poppins(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                )),
                Container(
                    color: Color.fromARGB(255, 234, 221, 221),
                    width: 150,
                    height: 35,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            calcAverage(),
                            style: GoogleFonts.poppins(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.w300),
                          ),
                          Text(
                            '%',
                            style: GoogleFonts.poppins(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 248, 151, 144),
                    ),
                    child: const SizedBox(
                      width: 3,
                      height: 70,
                    )),
                SizedBox(
                  width: 245,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CalcPage1()));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 232, 230, 230))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              db.courses.length > 0
                                  ? db.courses[0]
                                  : 'Course 1',
                              style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                          IconButton(
                              icon: Icon(Icons.create_rounded),
                              onPressed: () async {
                                final name = await openDialog();

                                if (name == null) return;
                                db.updateDataBase();
                                setState(() => db.courses[0] = name as String);
                                db.updateDataBase();
                              })
                        ]),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 234, 221, 221),
                        borderRadius: BorderRadius.circular(5)),
                    child: SizedBox(
                        width: 70,
                        height: 70,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                dbGrade.grades.length > 0
                                    ? dbGrade.grades[0]
                                        .toStringAsFixed(0)
                                        .toString()
                                    : '100',
                                style: GoogleFonts.poppins(
                                    fontSize: 22, color: Colors.black)),
                            Text('%',
                                style: GoogleFonts.poppins(
                                    fontSize: 22, color: Colors.black)),
                          ],
                        )))),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 157, 136, 250),
                    ),
                    child: const SizedBox(
                      width: 3,
                      height: 70,
                    )),
                SizedBox(
                  width: 245,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CalcPage2()));
                    },
                    style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 232, 230, 230))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              db.courses.length > 1
                                  ? db.courses[1]
                                  : 'Course 2',
                              style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                          IconButton(
                              icon: Icon(Icons.create_rounded),
                              onPressed: () async {
                                final name = await openDialog();
                                if (name == null) return;

                                setState(() => db.courses[1] = name as String);
                                db.updateDataBase();
                              })
                        ]),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 234, 221, 221),
                        borderRadius: BorderRadius.circular(5)),
                    child: SizedBox(
                        width: 70,
                        height: 70,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                dbGrade.grades.length > 0
                                    ? dbGrade.grades[1]
                                        .toStringAsFixed(0)
                                        .toString()
                                    : '100',
                                style: GoogleFonts.poppins(
                                    fontSize: 22, color: Colors.black)),
                            Text('%',
                                style: GoogleFonts.poppins(
                                    fontSize: 22, color: Colors.black)),
                          ],
                        )))),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 143, 241, 147),
                    ),
                    child: const SizedBox(
                      width: 3,
                      height: 71,
                    )),
                SizedBox(
                  width: 245,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CalcPage3()));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 232, 230, 230))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              db.courses.length > 2
                                  ? db.courses[2]
                                  : 'Course 3',
                              style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                          IconButton(
                              icon: Icon(Icons.create_rounded),
                              onPressed: () async {
                                final name = await openDialog();
                                if (name == null) return;

                                setState(() => db.courses[2] = name as String);
                                db.updateDataBase();
                              })
                        ]),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 234, 221, 221),
                        borderRadius: BorderRadius.circular(5)),
                    child: SizedBox(
                        width: 70,
                        height: 70,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                dbGrade.grades.length > 0
                                    ? dbGrade.grades[2]
                                        .toStringAsFixed(0)
                                        .toString()
                                    : '100',
                                style: GoogleFonts.poppins(
                                    fontSize: 22, color: Colors.black)),
                            Text('%',
                                style: GoogleFonts.poppins(
                                    fontSize: 22, color: Colors.black)),
                          ],
                        )))),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 239, 96)),
                    child: SizedBox(
                      width: 3,
                      height: 70,
                    )),
                SizedBox(
                  width: 245,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CalcPage4()));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 232, 230, 230))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              db.courses.length > 3
                                  ? db.courses[3]
                                  : 'Course 4',
                              style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                          IconButton(
                              icon: Icon(Icons.create_rounded),
                              onPressed: () async {
                                final name = await openDialog();
                                if (name == null) return;

                                setState(() => db.courses[3] = name as String);
                                db.updateDataBase();
                              })
                        ]),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 234, 221, 221),
                        borderRadius: BorderRadius.circular(5)),
                    child: SizedBox(
                        width: 70,
                        height: 70,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                dbGrade.grades.length > 0
                                    ? dbGrade.grades[3]
                                        .toStringAsFixed(0)
                                        .toString()
                                    : '100',
                                style: GoogleFonts.poppins(
                                    fontSize: 22, color: Colors.black)),
                            Text('%',
                                style: GoogleFonts.poppins(
                                    fontSize: 22, color: Colors.black)),
                          ],
                        )))),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Future<String?> openDialog() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Course Name'),
            content: TextField(
              maxLength: 12,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Enter Course Name',
              ),
              controller: controller,
            ),
            actions: [
              TextButton(
                  onPressed: submit,
                  child: Text('SUBMIT',
                      style: GoogleFonts.poppins(
                          fontSize: 13, color: Colors.black)))
            ],
          ));

  void submit() {
    db.updateDataBase();
    Navigator.of(context).pop(controller.text);
  }
}
