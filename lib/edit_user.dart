import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_app/main.dart';
import 'package:to_do_list_app/show_user.dart';

import 'login.dart';

class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final _formKey = new GlobalKey<FormState>();
  final _lastnameController = new TextEditingController();
  final _firstnameController = new TextEditingController();
  final _pseudoController = new TextEditingController();
  final _phoneController = new TextEditingController();
  final _passwordController = new TextEditingController();
  final _newPasswordController = new TextEditingController();
  final _passwordConfirmController = new TextEditingController();
  String? _password;

  _getSharedPreferencesInstance() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      _pseudoController.text = pref.getString("pseudo")!;
      _lastnameController.text = pref.getString("lastname")!;
      _firstnameController.text = pref.getString("firstname")!;
      _phoneController.text = pref.getString("phone")!;
      _password = pref.getString("password");
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
        title: Text("Mise à jour de profil"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _lastnameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText:"Nom *",
                            hintText: "Entrez votre nom"
                        ),
                        validator: (String? value){
                          return (value == null || value == "")?
                          "Ce champ est Obligatoire !" : null;
                        },
                      ),
                      //sizedBox(height:10.0),
                      TextFormField(
                        controller: _firstnameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText:"Prénoms *",
                            hintText: "Entrez votre prénom"
                        ),
                        validator: (String? value){
                          return (value == null || value == "")?
                          "Ce champ est Obligatoire !" : null;
                        },
                      ),
                      TextFormField(
                        controller: _pseudoController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            icon: Icon(Icons.work),
                            labelText:"Pseudo *",
                            hintText: "Entrez votre pseudo"
                        ),
                        validator: (String? value){
                          return (value == null || value == "")?
                          "Ce champ est Obligatoire !" : null;
                        },
                      ),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            icon: Icon(Icons.phone),
                            labelText:"Telephone *",
                            hintText: "Numéro de telephone"
                        ),
                        validator: (String? value){
                          return (value == null || value == "")?
                          "Ce champ est Obligatoire !" : null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(Icons.password),
                            labelText:"Mot de passe actuel *",
                            hintText: "Votre mot de passe actuel"
                        ),
                        validator: (String? value){
                          return (value == null || value == "")?
                          "Ce champ est Obligatoire !" : (_password!=value)? "Mot de passe incorrect" : null;
                        },
                      ),
                      TextFormField(
                        controller: _newPasswordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(Icons.password),
                            labelText:"Nouveau mot de passe",
                            hintText: "Votre mot de passe"
                        ),
                      ),
                      TextFormField(
                        controller: _passwordConfirmController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(Icons.password),
                            labelText:"Confirmation Mot de passe",
                            hintText: "Confirmez votre mot de passe"
                        ),
                        validator: (String? value){
                          if((value != null && value != "") || (_newPasswordController.text != null && _newPasswordController.text != "")){
                            return (_newPasswordController.text != value)? "Mot de passe non identique":null;
                          }else{
                            return null;
                          }

                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: ElevatedButton(onPressed: () async {
                    if(_formKey.currentState! .validate()){
                      final pref = await SharedPreferences.getInstance();
                      pref.setString("lastname", _lastnameController.text);
                      pref.setString("firstname", _firstnameController.text);
                      pref.setString("pseudo", _pseudoController.text);
                      pref.setString("phone", _phoneController.text);
                      pref.setBool("login", true);
                      if((_passwordConfirmController.text != null && _passwordConfirmController.text != "") || (_newPasswordController.text != null && _newPasswordController.text != "")) {
                        pref.setString("password", _newPasswordController.text);
                      }

                      Fluttertoast.showToast(
                          msg: "Les informations ont été modifiées avec succès !",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>const ShowUser()),
                      );
                    }
                  }, child: Text("Mettre à jour")),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
