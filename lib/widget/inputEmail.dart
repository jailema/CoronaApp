import 'package:flutter/material.dart';
import 'package:app_corona/login.dart';
import 'package:app_corona/widget/button.dart';

class InputEmail extends StatefulWidget {
  @override
  _InputEmailState createState() => _InputEmailState();
}

class _InputEmailState extends State<InputEmail> {
  final test  = TextEditingController();
  getItemAndNavigate(BuildContext context){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ButtonLogin(
                  nameHolder: test.text,
                ))
    );
  }
  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: test,
          style: TextStyle(
            color: Colors.white,
          ),
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
}