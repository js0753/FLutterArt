import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool reg = false;
  String btnText = "Login";
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter a valid Username';
              }
              return null;
            },
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter a valid Password';
              }
              return null;
            },
          ),
          if (reg)
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Re-enter a valid Password';
                }
                return null;
              },
            ),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {}
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
    );
  }
}
