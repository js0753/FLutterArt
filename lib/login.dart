import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email, pass;
  bool reg = false;
  bool s = false;
  String btnText = "Login";
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: s,
      child: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              email = value;
            },
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Enter your Email',
            ),
          ),
          TextField(
            obscureText: true,
            onChanged: (value) {
              pass = value;
            },
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Enter your Password',
            ),
          ),
          if (reg)
            TextField(
              obscureText: true,
              onChanged: (value) {
                if (value != pass) print("Password Not Matching");
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Re-enter your Password',
              ),
            ),
          ElevatedButton(
              onPressed: () async {
                setState(() {
                  s = true;
                });
                try {
                  if (reg == true) {
                    await _auth.createUserWithEmailAndPassword(
                        email: email, password: pass);
                  }
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: pass);
                  if (user != null) {
                    Navigator.pushNamed(context, Home.id);
                  }
                  setState(() {
                    s = false;
                  });
                } catch (e) {
                  print(e);
                }
              },
              child: Text(btnText)),
          TextButton(
              onPressed: () {
                setState(() {
                  reg = true;
                  btnText = "Register";
                });
              },
              child: Text("New ? Register Here!"))
        ],
      ),
    ));
  }
}
