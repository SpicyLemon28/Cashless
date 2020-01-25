import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password/password.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';

import '../../models/user.dart';
import '../../controller/users_controller.dart';
import '../../utilities/registration_utilities.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _formKey = GlobalKey<FormState>();

	User user = User('', '', '', '', '', '', '', 0);


	UsersController users = UsersController();
	RegistrationUtilities register = RegistrationUtilities();

	String _phone, _studentId, _name, _email, _password, _pin, _confirmationCode;

	bool passwordVisible, pinVisible, _isSubmitting;
	bool _autoValidate = false;

	@override
  void initState() {
    super.initState();
		passwordVisible = true;
		pinVisible = true;
    _isSubmitting = false;
	}

  @override
  Widget build(BuildContext context) {

		return WillPopScope(
			onWillPop: () { navigatePreviousPage(); },
			child: Scaffold(
				appBar: AppBar(
					title: Text('SmartPay'),
					backgroundColor: Colors.green[900],
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () { navigatePreviousPage(); }
          )
				),
				body: Form(
					key: _formKey,
					autovalidate: _autoValidate,
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
													textFormField(Icons. phone_android, 'Phone Number', 'Enter Phone Number', TextInputType.number, false),
													textFormField(Icons.perm_identity, 'School ID', 'Enter School ID Number', TextInputType.number, false),
													textFormField(Icons.person, 'Name', 'Enter Full Name', TextInputType.text, false),
													textFormField(Icons.email, 'Email', 'Enter Email Address', TextInputType.emailAddress, false),
													textFormField(Icons.lock, 'Password', 'Enter a Password', TextInputType.text, passwordVisible),
													textFormField(Icons.vpn_key, 'Pin', 'Enter a Pin for payment', TextInputType.number, pinVisible),
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
			)
		);
  }

  Widget textPage(lblText) => Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Text(lblText, style: TextStyle(fontSize: 18),)
  );

  Widget textFormField(icnText, lblText, hntText, keyType, blnObscure) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 8),
    child: TextFormField(
      keyboardType: keyType,
			inputFormatters: keyType == TextInputType.number
				? <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly]
				: null,
			obscureText: blnObscure,
      onSaved: (value) => updateTextFormField(lblText, value),
      validator: (String value) => textValidation(lblText, value),
      decoration: InputDecoration(
				labelText: lblText,
				hintText: hntText,
				prefixIcon: Icon(icnText, color: Colors.grey),
				suffixIcon: _suffixIcon(lblText, blnObscure),
      ),
    ),
  );

  Widget signupButton(txtSignup) {
    return _isSubmitting
      ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)
        )
      : Padding(
          padding: const EdgeInsets.only(top: 2, left: 220),
          child: RaisedButton(
            color: Colors.greenAccent,
            child: Text(txtSignup),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: _submit
          )
        );
  }

  // Functions
	void _submit() {
		final form = _formKey.currentState;
		if (form.validate()) {
			form.save();
			_save();
		} else {
			setState(() => _autoValidate = true);
		}
	}

	_suffixIcon(lblText, blnObscure) {
		if (lblText == 'Password' || lblText == 'Pin') {
			return IconButton(
				icon: Icon(blnObscure ? Icons.visibility : Icons.visibility_off),
				onPressed: () {
					lblText == 'Password'
						? setState(() => passwordVisible = !passwordVisible)
						: setState(() => pinVisible = !pinVisible);
				}
			);
		}
		return Icon(Icons.visibility_off, color: Colors.white);
	}

  textValidation(lblText, value) {
		if (value.isEmpty) {
			return '$lblText should not be empty';
		} else {
			switch (lblText) {
				case 'Phone Number':
					return value.length < 11 ? 'Phone Number must be 11 digits' : null;
					break;
				case 'School ID':
					return value.length < 6 ? 'School ID must be 6 digits' : null;
					break;
				case 'Name':
					return !value.contains(' ') ? 'Invalid Full Name' : null;
					break;
				case 'Email':
					Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
					RegExp regex = RegExp(pattern);
					return !regex.hasMatch(value) ? 'Invalid Email' : null;
					break;
				case 'Password':
					return value.length < 6 ? 'Password must be 6 characters or longer' : null;
					break;
				case 'Pin':
					return value.length < 6 ? 'Pin must be 6 digits or longer' : null;
					break;
			}
		}
	}

  void updateTextFormField(lblText, txtValue) {
    switch (lblText) {
      case 'Phone Number':
				_phone = txtValue;
				user.phone = txtValue;
				break;
      case 'School ID':
				_studentId = txtValue;
				user.studentId = txtValue;
				break;
      case 'Name':
				_name = txtValue;
        user.name = txtValue;
				break;
      case 'Email':
				_email = txtValue;
        user.email = txtValue;
				break;
      case 'Password':
				_password = txtValue;
        user.password = Password.hash(_password, PBKDF2());
				break;
      case 'Pin':
				_pin = txtValue;
				user.pin = Password.hash(_pin, PBKDF2());
				break;
    }
  }

  void _save() async {
		int result;
		setState(() => _isSubmitting = true);
		result = await users.accountExist(user);
		if (result > 0) {
			setState(() => _isSubmitting = false);
			_showAlertDialog('Warning', 'Account already exist');
		} else {
			user.date = DateFormat.yMMMd().format(DateTime.now());
			result = await users.saveAccout(user);
			if (result > 0) {
				setState(() => _isSubmitting = false);
				dialog();
			} else  {
				setState(() => _isSubmitting = false);
				_showAlertDialog('Warning', 'Problem saving user');
			}
		}
  }

	void _showAlertDialog(title, message) {
    AlertDialog alertDialog = AlertDialog(title: Text(title), content: Text(message));
    showDialog(context: context, builder: (_) => alertDialog);
  }

  dialog() {
		String genCode = register.generateConfirmationCode(_phone, _password);
		return showDialog(
			context: context,
			builder: (BuildContext context) => AlertDialog(
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.circular(20),
				),
				backgroundColor: Colors.grey[100],
				title: Column(
					children: <Widget>[
						Text('Thank you for signing up', textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
						Padding(
							padding: const EdgeInsets.only(top: 5.0),
							child: Text('To complete the process please enter confirmation code: $genCode',
								textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.red)
							),
						)
					],
				),
				content: TextField(
					onChanged: (value) { _confirmationCode = value; },
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
						child: Text('Submit'),
						onPressed: () =>
							(_confirmationCode == genCode) ? _confirmAccount() : _showAlertDialog('Warning', 'Invalid Confirmation Code'),
					),
				],
			),
		);
	}

	void _confirmAccount() async {
		int result = await users.confirmAccount(user);
		if (result > 0) {
			_formKey.currentState.reset();
			 _redirectLogin();
		 } else {
			 _showAlertDialog('Warning', 'Problem Confirming Account');
		 }
  }

	void navigatePreviousPage() => Navigator.pushReplacementNamed(context, '/login');

	void _redirectLogin() => Future.delayed(Duration(seconds: 2), () => navigatePreviousPage());

}
