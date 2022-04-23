import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_app/register.dart';
import 'package:to_do_list_app/task_list.dart';
import 'package:to_do_list_app/home.dart';
import 'package:restart_app/restart_app.dart';

import 'show_user.dart';


class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  String _pseudo = "Pseudo";

  _getSharedPreferencesInstance() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      _pseudo = pref.getString("pseudo")!;
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
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.teal
              ),
              child: Center(child: Text(_pseudo, style: TextStyle(color: Colors.white, fontSize: 20),))),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Accueil'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>const Home()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.task),
            title: Text('Liste des tâches'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>const TaskList()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Paramètre'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>const ShowUser()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Se déconnecter'),
            onTap: () async {
              final pref = await SharedPreferences.getInstance();
              pref.clear();
              Restart.restartApp(webOrigin: '/login');
            },
          ),
        ],
      ),
    );
  }
}
