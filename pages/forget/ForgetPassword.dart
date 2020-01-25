import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../login/LoginPage.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

	var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              textPage('Create a New Pin'),
              textFormField('New Password', 'Enter new password'),
              textFormField('Re-confirm Password', 'Re-type new password'),
              confirmButton('Confirm')
            ],
          ),
        ),
      ),
    );
  }

  Widget textPage(lblText) => Padding(
    padding: const EdgeInsets.only(bottom: 50,),
    child: Text(lblText, style: TextStyle(fontSize: 25)),
  );

  Widget textFormField(lblText, hntText) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: TextFormField(
			obscureText: true,
			validator: (String value,) => textValidation(lblText, value),
      decoration: InputDecoration(
        labelText: lblText,
        hintText: hntText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  );

  Widget confirmButton(lblText) => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: RaisedButton(
      child: Text(lblText),
      onPressed: () {
				if (_formKey.currentState.validate()) {
					Navigator.of(context).push(
						CupertinoPageRoute<Null>(builder: (
						BuildContext context) => LoginPage())
					);
				}
			}
    ),
  );

  textValidation(lblText, value) {
		var errorMessages;

		if (value.isEmpty) {
			errorMessages = '$lblText should not be empty';
		} else {
			if (value.length < 16) errorMessages = '$lblText should be 16 digits';
		}

		return errorMessages;
  }

}
