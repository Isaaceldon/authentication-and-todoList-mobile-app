import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_app/edit_user.dart';

import 'my_drawer.dart';

class ShowUser extends StatefulWidget {
  const ShowUser({Key? key}) : super(key: key);

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {

  String? _pseudo;
  String? _lastname;
  String? _firstname;
  String? _phone;

  _getSharedPreferencesInstance() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      _pseudo = pref.getString("pseudo");
      _lastname = pref.getString("lastname");
      _firstname = pref.getString("firstname");
      _phone = pref.getString("phone");
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Details de l'utilisateur"),
      ),
      drawer: MyDrawer(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Text("Prénom", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Card(
                    margin: EdgeInsets.all(0),
                    child: Column(
                      children: [
                        ListTile(
                            title: Text(_firstname.toString(), style: TextStyle(fontSize: 18))
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nom", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Card(
                    margin: EdgeInsets.all(0),
                    child: Column(
                      children: [
                        ListTile(
                            title: Text(_lastname.toString(), style: TextStyle(fontSize: 18))
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Pseudo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Card(
                    margin: EdgeInsets.all(0),
                    child: Column(
                      children: [
                        ListTile(
                            title: Text(_pseudo.toString(), style: TextStyle(fontSize: 18))
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Phone", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Card(
                    margin: EdgeInsets.all(0),
                    child: Column(
                      children: [
                        ListTile(
                            title: Text(_phone.toString(), style: TextStyle(fontSize: 18))
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditUser()),
                    );
                  },
                  child: Text("Editer mon profil")
              ),
            )
          ],
        ),
      ),
    );
  }
}
