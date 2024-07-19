import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stubook/pages/home_page.dart';
import 'package:stubook/pages/information.dart';
import 'package:stubook/pages/mark_calc_hp.dart';
import 'package:stubook/pages/mark_calculator2.dart';
import 'package:stubook/pages/calendar.dart';

class menuPage extends StatelessWidget {
  const menuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/menu_background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 150, width: 14),
              Text('STUBOOK',
                  style:
                      GoogleFonts.poppins(fontSize: 60, color: Colors.black)),
              const SizedBox(height: 35, width: 14),
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => calendarPage()));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 234, 221, 221))),
                  child: Text('Calendar',
                      style: GoogleFonts.poppins(
                          fontSize: 22, color: Colors.black)),
                ),
              ),
              const SizedBox(height: 35, width: 14),
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CalcHPage()));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 234, 221, 221))),
                  child: Text('Mark Calculator',
                      style: GoogleFonts.poppins(
                          fontSize: 22, color: Colors.black)),
                ),
              ),
              const SizedBox(height: 35, width: 14),
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 234, 221, 221))),
                  child: Text('To-Do-List',
                      style: GoogleFonts.poppins(
                          fontSize: 22, color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 234, 221, 221),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const informationPage()));
          },
          child: const Icon(Icons.info_outlined, color: Colors.black),
        ),
      ),
    );
  }
}
