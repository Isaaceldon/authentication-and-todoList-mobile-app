import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'login.dart';
import 'register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new Login(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String? _pseudo;
  bool _login = false;

  _getSharedPreferencesInstance() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      _pseudo = pref.getString("pseudo");
      _login = pref.getBool("login")!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSharedPreferencesInstance();
  }


  @override
  Widget build(BuildContext context) {
    return _login ? Home() : Login();
  }
}
