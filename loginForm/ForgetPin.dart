import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

import 'LoginPage.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              text('Create a New Pin'),
              pin('New Pin', 'Enter new pin'),
              pin('Re-confirm Pin', 'Re-type new pin'),
              confirm('Confirm')
            ],
          ),
        ),
      ),
    );
  }

  Widget text(txt) => Padding(
    padding: const EdgeInsets.only(bottom: 50,),
    child: Text(txt, style: TextStyle(fontSize: 25)),
  );

  Widget pin(lblTxt, hntTxt) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: TextField(
      decoration: InputDecoration(
        labelText: lblTxt,
        hintText: hntTxt,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  );

  Widget confirm(txt) => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: RaisedButton(
      child: Text(txt),
      onPressed: () => Navigator.of(context).push(
          CupertinoPageRoute<Null>(builder: (
            BuildContext context) => LoginPage())),
    ),
  );

}