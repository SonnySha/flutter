import 'package:flutter/material.dart';

import 'widget/myCustomFormState.dart';

//user: sonny@gmail.com
//mdp: azertyuiop

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<Login> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Center(
          child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/enola.jpg', fit: BoxFit.cover),
          Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [
                      0.88,
                      1
                    ],
                        colors: [
                      const Color.fromARGB(255, 46, 42, 44),
                      const Color.fromARGB(40, 46, 42, 44)
                    ])),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: const EdgeInsets.only(top: 1),
                  child: Column(
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(height: 20),
                      //Affiche le formulaire qui verifie si le user et le mdp sont bien correct
                      MyCustomFormState()
                    ],
                  ),
                ),
              ))
        ],
      )),
    );
  }
}
