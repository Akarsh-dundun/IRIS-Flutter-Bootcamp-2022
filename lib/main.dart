import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/calendar.dart';
import 'package:to_do_app/event.dart';

void main(box) async {
  await Hive.initFlutter();
  Hive.registerAdapter(EventAdapter());
  await Hive.openBox("Events");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "To-Do calendar",
      home: Calendar(),
    );
  }
}
