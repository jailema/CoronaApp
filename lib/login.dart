import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_corona/home.dart';
import 'package:toast/toast.dart';
import 'package:app_corona/widget/button.dart';
import 'package:app_corona/widget/first.dart';
import 'package:app_corona/widget/forgot.dart';
import 'package:app_corona/widget/inputEmail.dart';
import 'package:app_corona/widget/password.dart';
import 'package:app_corona/widget/textLogin.dart';
import 'package:app_corona/widget/verticalText.dart';

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else { Toast.show("Bad Credentials",
        context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM
    );
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      Toast.show("Bad Credentials",
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blueGrey, Colors.lightBlueAccent]),
            ),
           // padding: const EdgeInsets.all(20.0),
            child: ListView(
                    children: <Widget>[
                      Column(
                    children: <Widget>[
                      Row(children: <Widget>[
                        VerticalText(),
                        TextLogin(),
                      ]),
                      InputEmail(),
                      PasswordInput(),
                      ButtonLogin(),
                      FirstTime(),
                      // TextFormField(
                      //   decoration: InputDecoration(
                      //       labelText: 'Email*', hintText: "john.doe@gmail.com"),
                      //   controller: emailInputController,
                      //   keyboardType: TextInputType.emailAddress,
                      //   validator: emailValidator,
                      // ),
                      // TextFormField(
                      //   decoration: InputDecoration(
                      //       labelText: 'Password*', hintText: "********"),
                      //   controller: pwdInputController,
                      //   obscureText: true,
                      //   validator: pwdValidator,
                      // ),
                      // RaisedButton(
                      //   child: Text("Login"),
                      //   color: Theme.of(context).primaryColor,
                      //   textColor: Colors.white,
                      //   onPressed: () {
                      //     if (_loginFormKey.currentState.validate()) {
                      //       FirebaseAuth.instance
                      //           .signInWithEmailAndPassword(
                      //           email: emailInputController.text,
                      //           password: pwdInputController.text)
                      //           .then((currentUser) => Firestore.instance
                      //           .collection("users")
                      //           .document(currentUser.uid)
                      //           .get()
                      //           .then((DocumentSnapshot result) =>
                      //           Navigator.pushReplacement(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) => HomePage(
                      //                     title: result["fname"]
                      //                     ,
                      //                     uid: currentUser.uid,
                      //                   ))))
                      //           .catchError((err) => print(err)))
                      //           .catchError((err) => print(err));
                      //     }else {
                      //       Toast.show("Bad credentials",
                      //       context,
                      //       duration: Toast.LENGTH_SHORT,
                      //         gravity: Toast.BOTTOM
                      //       );
                      //     }
                      //   },
                      // ),
                      // Text("Don't have an account yet?"),
                      // FlatButton(
                      //   child: Text("Register here!"),
                      //   onPressed: () {
                      //     Navigator.pushNamed(context, "/register");
                      //   },
                      // )
                       ],
                      )],
                )));
  }
}