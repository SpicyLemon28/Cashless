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

  var _formKey = GlobalKey<FormState>();

  TextEditingController _newPass = TextEditingController(),
                        _confirmPass = TextEditingController();

  bool passwordVisible;

  @override
  void initState() {
		super.initState();
    passwordVisible = false;
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                text('Create a New Pin'),
                pass('New Password', 'Enter new password', _newPass),
                pass('Re-confirm Password', 'Re-type new password', _confirmPass),
                confirm('Confirm')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget text(txt) => Padding(
    padding: const EdgeInsets.only(bottom: 50,),
    child: Text(txt, style: TextStyle(fontSize: 25)),
  );

  Widget pass(lblTxt, hntTxt, txtController) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: TextFormField(
      controller: txtController,
      obscureText: !passwordVisible,
      validator: (String value,) => textValidation(lblTxt, value),
      decoration: InputDecoration(
        labelText: lblTxt,
        hintText: hntTxt,
        suffixIcon: IconButton(
            icon: Icon(
               passwordVisible
               ? Icons.visibility
               : Icons.visibility_off,
              ),
            onPressed: () => setState(() {
              passwordVisible = !passwordVisible;
              })
            ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  );

  Widget confirm(txt) => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: RaisedButton(
      color: Colors.greenAccent,
      child: Text(txt),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: (){
        if (_formKey.currentState.validate()) navigatePage(LoginPage());
      }
    ),
  );

  textValidation(lblText, value) {
		var errorMessages;

		if (value.isEmpty) {
			errorMessages = '$lblText should not be empty';
		} else {
			switch (lblText){
				case 'New Password':
					if (value.length < 6) errorMessages = 'Password should be 6 characters or longer';
					break;
				case 'Re-confirm Password':
					if (value != _newPass.text) errorMessages = 'Password do not match';
					break;
			}
		}
		return errorMessages;
  }

  void navigatePage(navTo) => Navigator.of(context).push(
        CupertinoPageRoute<Null>(
          builder: (BuildContext context) => navTo
		)
	);
}