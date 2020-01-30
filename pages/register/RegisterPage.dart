import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:password/password.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../models/user.dart';
import '../../controller/users_controller.dart';
import '../../utilities/registration_utilities.dart';

import '../../global.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _formKey = GlobalKey<FormState>();

	ProgressDialog prgrsDlg;

	User user = User('', '', '', '', '', '', '', 0);

	UsersController users = UsersController();
	RegistrationUtilities register = RegistrationUtilities();

	final _phone = TextEditingController();
	final _studentId = TextEditingController();
	final _name = TextEditingController();
	final _email = TextEditingController();
	final _password = TextEditingController();
	final _pin =  TextEditingController();

	bool passwordVisible, pinVisible, _isSubmitting;
	bool _autoValidate = false;

	@override
  void initState() {
    super.initState();
		passwordVisible = true;
		pinVisible = true;
    _isSubmitting = false;
	}

  void dispose() {
    super.dispose();
		_phone.dispose();
		_studentId.dispose();
		_name.dispose();
		_email.dispose();
		_password.dispose();
		_pin.dispose();
	}

  @override
  Widget build(BuildContext context) {

		prgrsDlg = ProgressDialog(context);
    prgrsDlg.style(
			message: 'Please Waiting...',
			borderRadius: 10.0,
			backgroundColor: Colors.white,
			progressWidget: CircularProgressIndicator(),
			elevation: 10.0,
			insetAnimCurve: Curves.easeInOut,
			progress: 0.0,
			maxProgress: 100.0,
			progressTextStyle: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
			messageTextStyle: TextStyle(color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
		);

		return WillPopScope(
			onWillPop: () { register.navigatePreviousPage(context); },
			child: Scaffold(
				appBar: AppBar(
					title: Text('SmartPay'),
					backgroundColor: Colors.green[900],
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () { register.navigatePreviousPage(context); }
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
													textPage('Registration'),
													textFormField(_phone, Icons. phone_android, 'Phone Number', 'Enter Phone Number', TextInputType.number, false),
													textFormField(_studentId, Icons.perm_identity, 'School ID', 'Enter School ID Number', TextInputType.number, false),
													textFormField(_name, Icons.person, 'Name', 'Enter Full Name', TextInputType.text, false),
													textFormField(_email, Icons.email, 'Email', 'Enter Email Address', TextInputType.emailAddress, false),
													textFormField(_password, Icons.lock, 'Password', 'Enter a Password', TextInputType.text, passwordVisible),
													textFormField(_pin, Icons.vpn_key, 'Pin', 'Enter a Pin for payment', TextInputType.number, pinVisible),
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

  Widget textFormField(txtController, icnText, lblText, hntText, keyType, blnObscure) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 8),
    child: TextFormField(
			autofocus: lblText == 'Phone Number' ? true : false,
			controller: txtController,
      keyboardType: keyType,
			inputFormatters: keyType == TextInputType.number
				? <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly]
				: null,
			obscureText: blnObscure,
      validator: (value) => textValidation(lblText, value),
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
		? Container()
		: Padding(
			padding: const EdgeInsets.only(top: 2, left: 220),
			child: RaisedButton(
				color: Colors.greenAccent,
				child: Text(txtSignup),
				shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
				onPressed: () { setState(() { _submit(); }); }
			)
		);
  }

  // Functions
	void _submit() {
		final form = _formKey.currentState;
		if (form.validate()) {
			_registerUser();
		} else {
			setState(() => _autoValidate = true);
		}
	}

	_suffixIcon(lblText, blnObscure) {
		if (lblText == 'Password' || lblText == 'Pin') {
			return IconButton(
				icon: Icon(blnObscure ? Icons.visibility_off : Icons.visibility),
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
				case 'School ID':
					return value.length < 6 ? 'School ID must be 6 digits' : null;
				case 'Name':
					return !value.contains(' ') ? 'Invalid Full Name' : null;
				case 'Email':
					Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
					RegExp regex = RegExp(pattern);
					return !regex.hasMatch(value) ? 'Invalid Email' : null;
				case 'Password':
					return value.length < 6 ? 'Password must be 6 characters or longer' : null;
				case 'Pin':
					return value.length < 6 ? 'Pin must be 6 digits or longer' : null;
			}
		}
	}

  void _registerUser() async {
		setState(() => _isSubmitting = true);
		prgrsDlg.show();

    var data = {
				"phone"			: _phone.text,
				"studentId"	: _studentId.text,
				"name"			: _name.text,
				"email"			: _email.text,
				"password"	: Password.hash(_password.text, PBKDF2()),
				"pin"				: Password.hash(_pin.text, PBKDF2())
		};

  	http.Response response = await http.post(USER_SIGNUP, body: data);
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
			var result = responseData['result'];
			if (result == 1) {
				progressIndicatorComplete(result, 'Account already exist');
			} else {
				_saveLocalDB();
			}
		} else {
			progressIndicatorComplete(0, responseData['error']);
		}
  }

	void _saveLocalDB() async {
		user.date = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
  	user.phone     = _phone.text;
		user.studentId = _studentId.text;
		user.name      = _name.text;
		user.email     = _email.text;
		user.password  = _password.text;
		user.pin       = _pin.text;
		int result = await users.saveAccout(user);
		if (result == 1) {
			progressIndicatorComplete(result, 'Account already exist');
		} else {
			progressIndicatorComplete(result, 'Problem saving user');
		}
	}

	void progressIndicatorComplete(result, message) {
		Future.delayed(Duration(seconds: 2)).then((value) {
			prgrsDlg.hide().whenComplete(() {
				setState(() => _isSubmitting = false);
				(result > 1)
				? register.dialog(context, 'Thank you for signing up', _phone.text,  _password.text, setState)
				: register.showAlertDialog(context, (result > 0) ? 'Warning' : 'Error',  message);
			});
		});
	}

}
