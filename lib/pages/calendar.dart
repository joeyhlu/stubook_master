import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:stubook/pages/menu.dart';
import 'package:stubook/util/event.dart';

class calendarPage extends StatefulWidget {
  const calendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<calendarPage> {
  final DateTime now = DateTime.now();
  final int numericDayOfWeek = DateTime.now().weekday;

  Map<DateTime, List<Event>> events = {};
  TextEditingController _eventController = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final ValueNotifier<List<Event>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(selectedDay);
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  String getMotivationalMessage(int numericDayOfWeek) {
    switch (numericDayOfWeek) {
      case 1: // Monday
        return 'Monday is the day that opens up the week for many opportunities.';
      case 2: // Tuesday
        return 'Tuesday is the day to turn your goals into actions. Stay focused and make progress!';
      case 3: // Wednesday
        return 'Wednesday is a reminder that the week is halfway through. Stay positive and keep moving forward.';
      case 4: // Thursday
        return 'Thursday is the day to challenge yourself and grow. Push beyond your limits.';
      case 5: // Friday
        return 'Friday is a reminder that even your toughest weeks have a happy ending.';
      case 6: // Saturday
        return 'Saturdays are a gift. Use them to rest, recharge, and do what makes you happy.';
      case 7: // Sunday
        return 'A well-spent Sunday can set a positive tone for the week ahead. Make it meaningful.';
      default:
        return 'Invalid day';
    }
  }

  @override
  Widget build(BuildContext context) {
    String message = getMotivationalMessage(numericDayOfWeek);
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
            'Calendar',
            style: GoogleFonts.poppins(
                fontSize: 35,
                color: const Color.fromARGB(255, 0, 0, 5),
                fontWeight: FontWeight.normal),
          ),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.format_quote,
                  color: Color.fromARGB(255, 235, 207, 207)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          scrollable: true,
                          content: Padding(
                            padding: const EdgeInsets.all(17.0),
                            child: SizedBox(
                              child: Text(
                                message,
                                style: GoogleFonts.comfortaa(
                                    fontSize: 22,
                                    color: Color.fromARGB(255, 173, 158, 158),
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Close"))
                          ]);
                    });
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text("Add Event"),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _eventController,
                      decoration: InputDecoration(
                        labelText: "Event Title",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        // Ensure _selectedDay is not null
                        if (_selectedDay != null &&
                            _eventController.text.isNotEmpty) {
                          setState(() {
                            // Check if the selected day already has events
                            if (events[_selectedDay!] != null) {
                              events[_selectedDay!]!
                                  .add(Event(_eventController.text));
                            } else {
                              events[_selectedDay!] = [
                                Event(_eventController.text)
                              ];
                            }
                            _selectedEvents.value =
                                _getEventsForDay(_selectedDay!);
                          });
                          _eventController.clear();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text("Add"),
                    ),
                    TextButton(
                      onPressed: () {
                        _eventController.clear();
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel"),
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            TableCalendar(
              locale: "en_US",
              rowHeight: 45,
              headerStyle:
                  HeaderStyle(formatButtonVisible: false, titleCentered: true),
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: _calendarFormat,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2010, 1, 1),
              lastDay: DateTime.utc(2030, 1, 1),
              onDaySelected: _onDaySelected,
              eventLoader: _getEventsForDay,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            SizedBox(height: 6.0),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              onTap: () => print(""),
                              title: Text('${value[index].title}'),
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
