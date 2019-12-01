import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './ForgetPin.dart';
import '../menuForm/NavBar.dart';
import './RegisterPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ListView(
            children: <Widget>[
              SafeArea(
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      appName('AppName'),
                      register('Sign Up'),
                      phoneNumber('Phone Number', Icons.phone_android),
                      pin('Pin', Icons.lock),
                      forgotPin('Forgot Pin?'),
                      login('Sign In'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget appName(txt) => Padding(
    padding: const EdgeInsets.only(top: 200, bottom: 50),
    child: Text('AppName', style: TextStyle(fontSize: 30),),
  );

  Widget register(txt) => Padding(
    padding: const EdgeInsets.only(top:20, left:200),
    child: FlatButton(
      child: Text(txt, style: TextStyle(fontSize: 12, color: Colors.blue,),),
      onPressed: () {
        Navigator.of(context).push(
          CupertinoPageRoute<Null>(builder: (
            BuildContext context) => Register()));
      },
    ),
  );

  Widget phoneNumber(hntTxt, iconTxt) => Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10,),
    child: TextField(
      decoration: InputDecoration(
        hintText: hntTxt,
        prefixIcon: Icon(iconTxt, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  );

  Widget pin(hntTxt,preIconTxt,) => Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 10,),
    child: TextField(
      decoration: InputDecoration(
        hintText: hntTxt,
        prefixIcon: Icon(preIconTxt, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      ),
  );

  Widget forgotPin(txt) => Padding(
    padding: const EdgeInsets.only(left: 200),
    child: FlatButton(
     child: Text(txt, style: TextStyle(fontSize: 12, color: Colors.blue),),
      onPressed:() {
        Navigator.of(context).push(
          CupertinoPageRoute<Null>(builder: (
            BuildContext context) => ForgetPin()));
      }
    ),
  );
  
  Widget login(txt) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: RaisedButton(
      child: Text(txt),
      onPressed: () {
        Navigator.of(context).push(
          CupertinoPageRoute<Null>(builder: (
            BuildContext context) => NavBar()));
      },
    ),
  );
}