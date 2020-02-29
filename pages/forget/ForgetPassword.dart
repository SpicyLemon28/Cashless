import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilities/registration_utilities.dart';
import '../../global.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

	RegistrationUtilities register = RegistrationUtilities();

  final _formKey = GlobalKey<FormState>();
	final scaffoldKey = GlobalKey<ScaffoldState>();

	String _phone;
	String _confirmationCode;

	bool _isLoading = false;
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () { register.navigatePreviousPage(context); },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Forget Password'),
          backgroundColor: Colors.green[900],
          leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () { register.navigatePreviousPage(context); },)
        ),
				key: scaffoldKey,
        body: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.green] 
              )
            ),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
									Column(
										children: <Widget>[
											Padding(padding: const EdgeInsets.only(top: 200)),
											textFormField('Phone Number','Enter phone number you used to sign in', TextInputType.number, TextStyle(color: Colors.grey [900], fontWeight: FontWeight.w500)),
											continueButton('Continue', TextStyle(color: Colors. white, fontSize: 18, fontWeight: FontWeight.w400)),
										],
									),
                	]
            ),
          ),
        ),
      ),
    );
  }

  Widget text(lblText, styleText) => Padding(
    padding: const EdgeInsets.only(),
    child: Text(lblText, style: styleText,),
  );

  Widget textFormField(lblText, hntText, keyType, styleText) => Padding(
    padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
    child: TextFormField(
      keyboardType: keyType,
			autofocus: true,
			onSaved: (value) => _phone = value,
      validator: (String value) => textValidation(value),
      decoration: InputDecoration(
        labelText: lblText, labelStyle: styleText,
        hintText: hntText, hintStyle: TextStyle(fontSize: 12)
      ),
    ),
  );

  Widget continueButton(buttonText, styleText) {
		return _isLoading
      ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)
        )
    	: Padding(
					padding: const EdgeInsets.only(top: 50),
					child: ButtonTheme(
            minWidth: 300,
            height: 50,
            child: RaisedButton(
              color: Colors.green [900],
              child: Text(buttonText, style: styleText),
              onPressed: () => _submit(),
            ),
          ),
				);
	}

  textValidation(value) {
    return (value.isEmpty)
			? 'Phone Number  should not be empty'
			: (value.length < 11) ? 'Phone Number must be 11 digits' : null;
	}

	void updateTextFormField(lblText, txtValue) {
		if (lblText == 'Phone')  _phone = txtValue;
	}

  void navigatePage(navTo){
    Navigator.pushReplacementNamed(context, navTo);
  }

  void _submit() {
		final form = _formKey.currentState;
		if (form.validate()) {
			setState(() => _isLoading = true);
			form.save();
			_verifyForgetPassword();
		} else {
			setState(() => _autoValidate = true);
		}
	}

	void _verifyForgetPassword() async {
  	var data = { "phone" : _phone };

    http.Response response = await http.post(REQUEST_RESET_PASSWORD, body: data);
    final responseData = json.decode(response.body);

		setState(() => _isLoading = false);
    if (response.statusCode == 200) {
			int result = responseData['result'];
			if (result == 1) dialog();
		} else {
    	register.snackBarShow(scaffoldKey, responseData['error']);
		}
  }

	void _verifyConfirmationCode() async {
  	var data = { "confirmationCode" : _confirmationCode };

    http.Response response = await http.post(CONFIRMED_REQUEST_RESET_PASSWORD, body: data);
    final responseData = json.decode(response.body);

		setState(() => _isLoading = false);
    if (response.statusCode == 200) {
			int result = responseData['result'];
			if (result == 2) {
				savePref(_phone, responseData['token']);
        Navigator.pushReplacementNamed(context, '/resetPassword');
			}
		} else {
			register.showAlertDialog(context, 'Error', responseData['error']);
		}
  }

  savePref(String phone, String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
			preferences.setString("phone", phone);
      preferences.setString("token", token);
    });
  }

	dialog() => showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      title: Column(
        children: <Widget>[
          Text('RESET PASSWORD', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Padding(padding: const EdgeInsets.only(top: 10)),
          Text(
            'To proceed with your request, please enter your confirmation code sent to your email:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)
					),
        ],
      ),
			content: TextField(
				autofocus: true,
				onChanged: (value) { _confirmationCode = value; },
				decoration: InputDecoration(
					hintText: 'Enter Confirmation Code',
					hintStyle: TextStyle(fontSize: 12),
					prefixIcon: Icon(Icons.code),
					enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
				),
			),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              child: Text('Submit'),
              onPressed: () => _verifyConfirmationCode(),
            )
          ],
        ),
      ],
    )
  );
}
