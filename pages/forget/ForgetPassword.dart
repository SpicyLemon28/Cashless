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

  bool _autoValidate = false;

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
          autovalidate: _autoValidate,
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
                      textFormField('Enter the phone number you used to sign in', TextInputType.phone, TextStyle(fontSize: 12.5)),
                      continueButton('Continue', TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
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
      validator: (String value) => textValidation(lblText, value),
      decoration: InputDecoration(
        labelText: lblText, 
        labelStyle: styleText
      ),
    ),
  );

  Widget continueButton(buttonText, styleText) => Padding(
    padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
    child: Material(
      color: Colors.green,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: _submit,
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
      content: TextFormField(
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
              onPressed: () => navigatePage('/resetPinPass'),
            )
          ],
        ),
      ],
    )
  );

  textValidation(lblText, value) {
    if(value.isEmpty) {
      return 'Field should not be empty';
    } else {
      switch (lblText) {
        case 'Enter the phone number you used to sign in':
          return value.length < 11 ? 'Phone Number must be 11 digits' : null;
          break;
      }
    }
	}

  void _submit() {
		final form = _formKey.currentState;
		if (form.validate()) {
			form.save();
			_save();
		} else {
			setState(() => _autoValidate = true);
		}
	}

  void _save() async {
    setState(() => dialog());
  }

  void navigatePreviousPage() => Navigator.pushReplacementNamed(context, '/login');

  void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);
}


