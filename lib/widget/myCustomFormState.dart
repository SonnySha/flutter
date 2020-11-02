import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../films.dart';

class MyCustomFormState extends StatefulWidget {
  MyCustomFormState({Key key}) : super(key: key);

  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomFormState> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = "";
    var mdp = "";
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              focusColor: Colors.white,
              hoverColor: Colors.white,
              contentPadding: const EdgeInsets.all(20.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white30,
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              disabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white30,
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              focusedErrorBorder: InputBorder.none,
              filled: false,
              hintText: 'Entrez votre login',
              fillColor: Colors.white,
              // fillColor: Color(0xff3d3e40),

              // fillColor: Colors.grey[200],
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Entrer votre login';
              }

              final String email = value;
              final bool isValid = EmailValidator.validate(email);

              if (isValid == false) {
                return 'Entrer un email valide';
              }
              user = value;
              return null;
            },
            obscureText: false ? true : false,
            onSaved: (String value) => value.trim(),
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
          ),
          Container(height: 20),
          TextFormField(
            decoration: InputDecoration(
                focusColor: Colors.white,
                hoverColor: Colors.white,
                contentPadding: const EdgeInsets.all(20.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white30,
                  ),
                  borderRadius: BorderRadius.circular(0),
                ),
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white30,
                  ),
                  borderRadius: BorderRadius.circular(0),
                ),
                focusedErrorBorder: InputBorder.none,
                filled: true,
                fillColor: Colors.white24,
                hintText: 'Entrez votre Mot de passe',
                suffixIcon:
                    true ? Icon(Icons.remove_red_eye_sharp) : Container()),
            obscureText: true ? true : false,
            validator: (value) {
              if (value.length < 3) {
                return 'Entrer un mdp valide';
              }
              mdp = value;
              return null;
            },
            onSaved: (String value) => value.trim(),
            // keyboardType:
            //     isEmail ? TextInputType.emailAddress : TextInputType.text,
            cursorColor: Colors.white,
            // onEditingComplete: focusNode.nextFocus,
            style: TextStyle(color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  //Fonction pour connecter l'utilisateur
                  checkCo(emailController.text, mdp, context);
                }
              },
              child: Text('Connection'),
            ),
          ),
        ]));
  }

  static Future checkCo(String user, String mdp, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user, password: mdp);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FilmArchive()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("user invalide");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
