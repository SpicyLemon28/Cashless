import 'package:flutter/material.dart';

class ForgetPin extends StatefulWidget {
  ForgetPin({Key key}) : super(key: key);

  @override
  _ForgetPinState createState() => _ForgetPinState();
}

class _ForgetPinState extends State<ForgetPin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
       child: Center(
         child: Text('Forgot Pin'),
        ),
     ),
    );
  }
}