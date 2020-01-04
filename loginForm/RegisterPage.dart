import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../menuForm/NavBar.dart';
import '../database/userDatabase.dart';
import '../models/User.dart';

class Register extends StatefulWidget {
  final User user;

  Register(this.user);

  @override
  _RegisterState createState() => _RegisterState(this.user);
  //_RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _formKey = GlobalKey<FormState>();

  User user;

  _RegisterState(this.user);

  UserDatabase helper = UserDatabase();

   TextEditingController nameController = TextEditingController(),
                        emailController = TextEditingController(),
                        phoneController = TextEditingController(),
                        studIdController = TextEditingController(),
                        passwordController = TextEditingController(),
                        pinController = TextEditingController();
                        
    
  @override
  Widget build(BuildContext context) {

    nameController.text = user.name;
    emailController.text = user.email;
    phoneController.text = user.phone as String ;
    studIdController.text = user.studId as String;
    passwordController.text = user.password;
    pinController.text = user.pin as String;
    
    return Scaffold(
      appBar: AppBar(title: Text('SmartPay'), backgroundColor: Colors.green[900],),
       body: Form(
         key: _formKey,
         child: Stack(
           fit: StackFit.expand,
           children: <Widget>[
             ListView(
               children: <Widget>[
                 SafeArea(
									child: Padding(padding: const EdgeInsets.symmetric(horizontal: 30),
										child: Column(
											mainAxisAlignment: MainAxisAlignment.center,
											children: <Widget>[
												textPage('Create a New Profile'),
												textFormField(Icons.person, 'Name', 'Enter Full Name', nameController, TextInputType.text),
												textFormField(Icons.email, 'Email', 'Enter email address', emailController, TextInputType.emailAddress),
												textFormField(Icons. phone_android, 'Phone Number', 'Enter phone number', phoneController, TextInputType.number),
												textFormField(Icons.perm_identity, 'School ID', 'Enter School ID Number', studIdController, TextInputType.number),
												textFormField(Icons.lock, 'Password', 'Enter a Password', passwordController, TextInputType.text),
												textFormField(Icons.vpn_key, 'Pin', 'Enter a pin for payment', pinController, TextInputType.number),
												signupButton('Sign Up'),
											],
										),
									),
                 ),
               ],
             ),
           ],
         ),
       ),
    );
  }

  Widget textPage(lblText) => Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Text(lblText, style: TextStyle(fontSize: 18),)
  );

  Widget textFormField(icnText, lblText, hntText, txtController, keyType) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 8),
    child: TextFormField(
      controller: txtController,
      keyboardType: keyType,
      onSaved: (value) => updateTextFormField(lblText, txtController),
      validator: (String value) => textValidate(lblText, value),
      decoration: InputDecoration(
				labelText: lblText,
				hintText: hntText,
				prefixIcon: Icon(icnText, color: Colors.grey),
      ),
    ),
  );

  // Signup Button
  Widget signupButton(txtSignup) => Padding(
    padding: const EdgeInsets.only(top: 2, left: 220),
    child: RaisedButton(
      color: Colors.greenAccent,
      child: Text(txtSignup),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: () {
				//if (_formKey.currentState.validate()) dialog();
        if (_formKey.currentState.validate()) _save();
			}
    ),
  );

  // Functions
  textValidate(lblText, value) {
		var errorMessages;

		if (value.isEmpty) {
			errorMessages = '$lblText should not be empty';
		} else {
			switch (lblText){
				case 'Email':
					Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
					RegExp regex = RegExp(pattern);

					if (!regex.hasMatch(value)) errorMessages = 'Invalid Email';
					break;
				case 'Phone Number':
					if (value.length < 12) errorMessages = 'Phone Number must be 11 digits';
					break;
				case 'School ID':
					if (value.length < 6) errorMessages = 'School ID must be 6 digits';
					break;
				case 'Password':
					if (value.length < 6) errorMessages = 'Password must be 6 characters or longer';
					break;
				case 'Pin':
					if (value.length < 6) errorMessages = 'Pin must be 6 digits or longer';
					break;
			}
		}
		return errorMessages;
	}

  dialog() => showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.grey[100],
      title: Column(
        children: <Widget>[
          Text('We sent you a Confirmation Code',
						textAlign: TextAlign.center,
						style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text('Please Check your Inbox',
							textAlign: TextAlign.center,
							style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)
						),
          )
        ],
      ),
      content: TextField(
        decoration: InputDecoration(
          hintText: 'Enter Confirmation Code',
          hintStyle: TextStyle(fontSize: 12),
          prefixIcon: Icon(Icons.code),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12)
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Login'),
          onPressed: () {
            Navigator.of(context).push(
							CupertinoPageRoute<Null>(builder: (
							BuildContext context) => NavBar())
						);
          },
        ),
      ],
    ),
  );

  void updateTextFormField(lblText, txtController) {
    switch (lblText) {
      case 'Name': 
        user.name = nameController.text;
      break;

      case 'Email': 
        user.email = emailController.text;
      break;

      case 'Phone Number': 
        user.phone = phoneController.text as int;
      break;

      case 'School ID': 
        user.studId = studIdController.text as int;
      break;

      case 'Password': 
        user.password = passwordController.text;
      break;

      case 'Pin': 
        user.pin = pinController.text as int;
      break;

    }
  }

  void _save() async {
    user.date = DateFormat.yMMMd().format(DateTime.now());
    int result;

    result = (user.userId != null) ? await helper.updateUser(user):  await helper.insertUser(user);
			_showAlertDialog('Status', (result != 0)  ? 'Registered Successfully' : 'Register Issue');
  }

  void _showAlertDialog(title, message) {
    AlertDialog  alertDialog = AlertDialog(title: Text(title), content: Text(message));
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
