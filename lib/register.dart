import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = new GlobalKey<FormState>();
  final _lastnameController = new TextEditingController();
  final _firstnameController = new TextEditingController();
  final _pseudoController = new TextEditingController();
  final _phoneController = new TextEditingController();
  final _passwordController = new TextEditingController();
  final _passwordConfirmController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Inscription"),
      ),
      body: Center(
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
                          labelText:"Mot de passe *",
                          hintText: "Votre mot de passe"
                      ),
                      validator: (String? value){
                        return (value == null || value == "")?
                        "Ce champ est Obligatoire !" : null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordConfirmController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                          icon: Icon(Icons.password),
                          labelText:"Confirmation Mot de passe *",
                          hintText: "Confirmez votre mot de passe"
                      ),
                      validator: (String? value){
                        return (value == null || value == "")?
                        "Ce champ est Obligatoire !" :
                        (_passwordController.text != value)? "Mot de passe non identique":null;

                      },
                    ),
                  ],
                ),
              ),

              Center(
                child: ElevatedButton(onPressed: () async {
                  if(_formKey.currentState! .validate()){
                    final pref = await SharedPreferences.getInstance();
                    pref.setString("lastname", _lastnameController.text);
                    pref.setString("firstname", _firstnameController.text);
                    pref.setString("pseudo", _pseudoController.text);
                    pref.setString("password", _passwordController.text);
                    pref.setString("phone", _phoneController.text);
                    pref.setBool("login", false);

                    Fluttertoast.showToast(
                        msg: "Les informations ont été enrégistrées avec succès !",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>const Login()),
                    );
                  }
                }, child: Text("S'inscrire")),
              ),
              /*Center(
                child: ElevatedButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>const InfoPage()),
                  );
                }, child: Text("Page Suivante")),

              ),*/
            ],
          ),
        ),
      ),

    );
  }
}
