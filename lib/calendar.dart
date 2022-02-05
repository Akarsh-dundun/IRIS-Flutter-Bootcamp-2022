import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_app/main.dart';

import 'event.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.week;
  late Map<DateTime, List<Event>> selectedEvents;

  final TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = Hive.box("Events")
        .get("to-do", defaultValue: <DateTime, List<Event>>{}).cast(
            <DateTime, List<Event>>{});
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  void edit() {
    /*
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Edit"),
          );
        });
    */
  }

  void actionPopUpItemSelected(String value, Event event) {
    if (value == "edit") {
      print("You selected edit");
      edit();
    } else {
      List<Event>? list_selected = selectedEvents[_selectedDay];
      list_selected!.remove(event);
      selectedEvents[_selectedDay] = list_selected;

      setState(() {
        selectedEvents[_selectedDay] = list_selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-do App"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _selectedDay,
            firstDay: DateTime.utc(2010, 1, 1),
            lastDay: DateTime.utc(2030, 1, 1),
            calendarFormat: format,

            /*
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            */
            startingDayOfWeek: StartingDayOfWeek.monday,
            daysOfWeekVisible: true,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },

            //day changed
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },

            eventLoader: _getEventsfromDay,

            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },

            //Styling the day selected
            calendarStyle: const CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.deepOrange,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.circular(15.0),
              ),
              formatButtonTextStyle: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          ..._getEventsfromDay(_selectedDay).map((Event event) => Card(
              child: ListTile(
                  title: Text(event.title),
                  leading: const FlutterLogo(),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          child: Text('Edit'),
                          value: 'edit',
                        ),
                        const PopupMenuItem(
                          child: Text("Delete"),
                          value: 'delete',
                        ),
                      ];
                    },
                    onSelected: (String value) {
                      actionPopUpItemSelected(value, event);
                    },
                  ))))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Add Event"),
                  content: TextFormField(
                    controller: _eventController,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel")),
                    TextButton(
                      child: const Text("Ok"),
                      onPressed: () {
                        if (_eventController.text.isEmpty) {
                        } else {
                          if (selectedEvents[_selectedDay] != null) {
                            selectedEvents[_selectedDay]
                                ?.add(Event(title: _eventController.text));
                          } else {
                            selectedEvents[_selectedDay] = [
                              Event(title: _eventController.text)
                            ];
                          }
                        }
                        Navigator.pop(context);
                        _eventController.clear();
                        setState(() {
                          var box = Hive.box("Events");
                          box.put("to-do", selectedEvents);
                        });
                        return;
                      },
                    )
                  ],
                )),
        label: const Text("Add Event"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
