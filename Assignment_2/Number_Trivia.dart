import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _info = 'No info as of Now';

  final myController = TextEditingController();

  get horizontal => null;

  void gettingInfo() async {
    String information = (myController.text);
    var str = '';
    if (information == '') {
      str = "http://numbersapi.com/random/trivia";
    } else {
      str = "http://numbersapi.com/" + information + "/trivia";
    }
    var url = Uri.parse(str);

    final response = await http.get(url);

    setState(() {
      _info = response.body;
    });
  }

  void clearBox() {
    myController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                "Enter the Number \nfor which you wanna get some trivia!!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Leave the field blank for random Trivia!!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: myController,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: gettingInfo, child: const Text("Get info")),
                  const SizedBox(
                    width: 15,
                  ),
                  OutlinedButton(
                      onPressed: clearBox, child: const Text("Clear")),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Here is the info:\n',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontFamily: 'Mochi'),
              ),
              Text(
                _info,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
