import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';
import 'package:app_corona/home.dart';
import 'package:app_corona/login.dart';
class ButtonLogin extends StatefulWidget {
  final nameHolder;
  ButtonLogin({Key key, @required this.nameHolder}) : super(key: key);
  @override
  _ButtonLoginState createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin> {
  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 50, left: 200),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FlatButton(
          onPressed: () {

              var nameHolder;
              var pwdInputController;
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                  email: nameHolder.text,
                  password: pwdInputController.text)
                  .then((currentUser) => Firestore.instance
                  .collection("users")
                  .document(currentUser.uid)
                  .get()
                  .then((DocumentSnapshot result) =>
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                            title: result["fname"]
                            ,
                            uid: currentUser.uid,
                          ))))
                  .catchError((err) => print(err)))
                  .catchError((err) => print(err));

          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Login',
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
}
