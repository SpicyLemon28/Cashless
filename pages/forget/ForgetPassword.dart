import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {navigatePreviousPage();},
      child: Scaffold(
        appBar: AppBar(
          title: Text('SmartPay'),
          centerTitle: true,
          backgroundColor: Colors.green[900],
          leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () {navigatePreviousPage();},)
        ),
        body: Form(
          key: _formKey,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ListView(
                children: <Widget>[
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 200),
                      ),
                      text('Which one did you forgot?', TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          radioSelection('Pin'),
                          radioSelection('Password'),
                        ],
                      ),
                      textFormField('Enter the phone number you used to sign in', TextInputType.phone, TextStyle(fontSize: 12)),
                      continueButton('Continue', TextStyle(fontSize: 30, fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
                ]
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget text(txt, styleText) => Padding(
    padding: const EdgeInsets.only(),
    child: Text(txt, style: styleText,),
  );

  Widget radioSelection(radioButton) => Padding(
    padding: const EdgeInsets.only(),
    child: Row(
      children: <Widget>[
        Radio(
          value: null,
          groupValue: null,
          onChanged: null,
        ),
        Text(radioButton)
      ],
    ),
  );

  Widget textFormField(lblText, keyType, styleText) => Padding(
    padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
    child: TextFormField(
      keyboardType: keyType,
      decoration: InputDecoration(
        labelText: lblText, 
        labelStyle: styleText
      ),
    ),
  );

  Widget continueButton(buttonText, styleText) => Padding(
    padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
    child: Material(
      color: Colors.green,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () => dialog(),
        child: Center(
          child: Text(buttonText, style: styleText),
        ),
      ),
    ),
  );

  dialog() => showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      title: Column(
        children: <Widget>[
          Text(
            'THANK YOU!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.only(top: 10),
          ),
          Text(
            'We sent you a temporary pin/password to your registered email address. Kindly check your email and follow the instructions.',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
          Padding(
            padding: const EdgeInsets.only(top: 20),
          ),
          Text(
            'To proceed please enter the temporary pin/password',
            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
          )
        ],
      ),
      content: TextField(
        decoration: InputDecoration(
          hintText: 'Enter temporary pin/password',
          hintStyle: TextStyle(fontSize: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18)
          )
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              child: Text('Resend Email'),
              onPressed: (){setState(() => print('RESEND!'));},
            ),
            FlatButton(
              child: Text('Submit'),
              onPressed: () {setState(() => print('SUBMIT!'));},
            )
          ],
        ),
      ],
    )
  );

  

  void navigatePreviousPage() => Navigator.pushReplacementNamed(context, '/login');
}


