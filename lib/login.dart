import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_app/register.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = new GlobalKey<FormState>();
  final _pseudoController = new TextEditingController();
  final _passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Connexion"),
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
                      //sizedBox(height:10.0),
                      TextFormField(
                        controller: _pseudoController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            icon: Icon(Icons.work),
                            labelText:"Pseudo",
                            hintText: "Entrez votre pseudo"
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
                            labelText:"Mot de passe",
                            hintText: "Votre mot de passe"
                        ),
                        validator: (String? value){
                          return (value == null || value == "")?
                          "Ce champ est Obligatoire !" : null;
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

                      if(pref.getString('pseudo')==_pseudoController.text && pref.getString('password')==_passwordController.text){
                        pref.setBool('login', true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>const Home()),
                        );
                      }else{
                        Fluttertoast.showToast(
                          msg: "Pseudo ou mot de passe incorrect",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM);
                        }
                      }
                  }, child: Text("Se conecter")),
                ),
                Center(
                  child: TextButton(onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>const Register()),
                    );
                  }, child: Text("J'ai pas un compte")),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
