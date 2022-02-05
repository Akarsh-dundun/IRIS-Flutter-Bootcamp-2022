import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'event.g.dart';

@HiveType(typeId: 0)
class Event {
  @HiveField(0)
  String title;
  Event({required this.title});

  String toString() => this.title;
}
