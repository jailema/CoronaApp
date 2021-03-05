import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_corona/home.dart';
import 'package:app_corona/widget/buttonNewUser.dart';
import 'package:app_corona/widget/newEmail.dart';
import 'package:app_corona/widget/newName.dart';
import 'package:app_corona/widget/singup.dart';
import 'package:app_corona/widget/textNew.dart';
import 'package:app_corona/widget/userOld.dart';
import 'package:toast/toast.dart';


class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;

  @override
  initState() {
    firstNameInputController = new TextEditingController();
    lastNameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }
  String NameValidator(String value) {
    if (value.length < 3) {
      Toast.show("Please enter a valid first name.",
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM
      );
    }
  }
  Widget FirstName() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          style: TextStyle(
            color: Colors.white,
          ),
          controller: firstNameInputController,
          validator: NameValidator,

          decoration: InputDecoration(

            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'Name',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  Widget LastName() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          style: TextStyle(
            color: Colors.white,
          ),
          controller: lastNameInputController,
          validator: NameValidator,

          decoration: InputDecoration(

            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'LastName',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  Widget Email() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          style: TextStyle(
            color: Colors.white,
          ),
          controller: emailInputController,
          validator: emailValidator,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(

            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'Email',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }


  Widget Passsword() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          style: TextStyle(
            color: Colors.white,
          ),
          controller: pwdInputController,
          validator: pwdValidator,
          obscureText: true,
          decoration: InputDecoration(

            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'Password',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }


  Widget ConfirmPasssword() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          style: TextStyle(
            color: Colors.white,
          ),
          controller: confirmPwdInputController,
          validator: pwdValidator,
          obscureText: true,
          decoration: InputDecoration(

            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'Confirm Password',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }


  Widget ButtonRegister() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, right: 50, left: 200),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blue[300],
                blurRadius: 10.0, // has the effect of softening the shadow
                spreadRadius: 1.0, // has the effect of extending the shadow
                offset: Offset(
                  5.0, // horizontal, move right 10
                  5.0, // vertical, move down 10
                ),
              ),
            ],
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: FlatButton(
          onPressed: (){
            if (_registerFormKey.currentState.validate()) {
              if (pwdInputController.text ==
                  confirmPwdInputController.text) {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                    email: emailInputController.text,
                    password: pwdInputController.text)
                    .then((currentUser) => Firestore.instance
                    .collection("users")
                    .document(currentUser.uid)
                    .setData({
                  "uid": currentUser.uid,
                  "fname": firstNameInputController.text,
                  "surname": lastNameInputController.text,
                  "email": emailInputController.text,
                })
                    .then((result) => {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                            title:
                            firstNameInputController
                                .text,
                            uid: currentUser.uid,
                          )),
                          (_) => false),
                  firstNameInputController.clear(),
                  lastNameInputController.clear(),
                  emailInputController.clear(),
                  pwdInputController.clear(),
                  confirmPwdInputController.clear()
                })
                    .catchError((err) => print(err)))
                    .catchError((err) => print(err));
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Error"),
                        content: Text("The passwords do not match"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
              }
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Register',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.lightBlueAccent,
              ),
            ],
          ),
        ),
      ),
    );
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

            child: ListView(
                children: [
                  Form(
                    key: _registerFormKey,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SingUp(),
                            TextNew(),
                          ],
                        ),
                        FirstName(),
                        LastName(),
                        Email(),
                        Passsword(),
                        ConfirmPasssword(),
                        ButtonRegister(),
                        UserOld(),
                      ],
                    ),
                  ),
                ])));
  }
}