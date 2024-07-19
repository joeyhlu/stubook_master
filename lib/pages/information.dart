import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubook/pages/menu.dart';

class informationPage extends StatelessWidget {
  const informationPage({super.key});

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
            'Information',
            style: GoogleFonts.poppins(
                fontSize: 35,
                color: const Color.fromARGB(255, 0, 0, 5),
                fontWeight: FontWeight.normal),
          ),
          elevation: 0,
        ),
        body: Center(
          child: Column(children: [
            const SizedBox(height: 25),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 244, 242, 242),
                ),
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                    height: 35,
                    width: 295,
                    child: Text(
                      'How to use',
                      style: GoogleFonts.poppins(
                          fontSize: 25, color: Colors.black),
                      textAlign: TextAlign.center,
                    ))),
            const SizedBox(height: 35),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 252, 247, 247),
                ),
                padding: const EdgeInsets.all(25),
                child: SizedBox(
                    height: 60,
                    width: 275,
                    child: Text(
                      '+ button | to add tasks/marks \nslide | to delete  tasks/marks',
                      style: GoogleFonts.poppins(
                          fontSize: 17, color: Colors.black),
                      textAlign: TextAlign.center,
                    ))),
            const SizedBox(height: 25),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 244, 242, 242),
                ),
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                    height: 35,
                    width: 295,
                    child: Text(
                      'About Us',
                      style: GoogleFonts.poppins(
                          fontSize: 25, color: Colors.black),
                      textAlign: TextAlign.center,
                    ))),
            const SizedBox(height: 35),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 252, 247, 247),
                ),
                padding: const EdgeInsets.all(25),
                child: SizedBox(
                    height: 210,
                    width: 275,
                    child: Text(
                      'Stubook is an innovative application created by a group of students, with the primary aim of simplifying the daily study and learning experience. This app features the essential tools to ensure a stress free learning routine.',
                      style: GoogleFonts.poppins(
                          fontSize: 17, color: Colors.black),
                      textAlign: TextAlign.center,
                    ))),
          ]),
        ),
      ),
    );
  }
}
