import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:password/password.dart';

import '../../controller/users_controller.dart';
import '../../utilities/registration_utilities.dart';
import '../../global.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

	UsersController users = UsersController();
	RegistrationUtilities register = RegistrationUtilities();

  final _formKey = GlobalKey<FormState>();
	final scaffoldKey = GlobalKey<ScaffoldState>();

  bool newPasswordVisible, cfmPasswordVisible;

	bool _isLoading = false;
  bool _autoValidate = false;

	String _phone, _token;

	final _newPassword = TextEditingController();
	final _cfmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
		newPasswordVisible = true;
		cfmPasswordVisible = true;
  }

	void dispose() {
    super.dispose();
		_newPassword.dispose();
		_cfmPassword.dispose();
	}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        centerTitle: true,
        backgroundColor: Colors.green[900],
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
              ListView(
                children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(padding: const EdgeInsets.only(top: 200)),
                        textFormField(_newPassword, 'New Password', 'Enter New Password', newPasswordVisible),
                        textFormField(_cfmPassword, 'Confirm Password', 'Re-type Password', cfmPasswordVisible),
                        submitButton('Submit', TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400))
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFormField(txtController, lblText, hntText, blnObscure) => Padding(
    padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
    child: TextFormField(
			controller: txtController,
      validator: (value) => textValidation(lblText, value),
      obscureText: blnObscure,
      decoration: InputDecoration(
        labelText: lblText,
        labelStyle: TextStyle(fontWeight: FontWeight.w500),
        hintText: hntText,
        hintStyle: TextStyle(fontSize: 15),
        suffixIcon: _suffixIcon(lblText, blnObscure),
      ),
    ),
  );

  Widget submitButton(buttonText, styleText) {
		return _isLoading
      ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)
        )
    	: Padding(
					padding: const EdgeInsets.only(top: 80),
					child: Material(
						color: Colors.green,
						borderRadius: BorderRadius.circular(10),
            child: ButtonTheme(
              minWidth: 300,
              height: 50,
              child: RaisedButton(
                color: Colors.green [900],
                child: Text(buttonText, style: styleText,),
                onPressed: () => _submit()
              ),
            ),
				),
      );
	}

  _suffixIcon(lblText, blnObscure) {
    if (lblText == 'New Password' || lblText == 'Confirm Password') {
      return IconButton(
        icon: Icon(blnObscure ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          lblText == 'New Password'
            ? setState(() => newPasswordVisible = !newPasswordVisible)
            : setState(() => cfmPasswordVisible = !cfmPasswordVisible);
        },
      );
    }
  }

  textValidation(lblText, value) {
    if (value.isEmpty) {
      return '$lblText should not be empty';
    } else {
      switch (lblText) {
        case 'New Password':
          return value.length < 6 ? 'Password must be 6 characters or longer' : null;
				case 'Confirm Password':
					return _newPassword.text != value ? 'Password does not match' : null;
      }
    }
  }

  void _submit() {
		final form = _formKey.currentState;
		if (form.validate()) {
			setState(() => _isLoading = true);
			_resetPassword();
		} else {
			setState(() => _autoValidate = true);
		}
	}

	void _resetPassword() async {
		SharedPreferences preferences = await SharedPreferences.getInstance();
		setState(() {
			_phone = preferences.getString("phone");
			_token = preferences.getString("token");
		});

		var data = {
			"token"       : _token,
			"newPassword" : Password.hash(_newPassword.text, PBKDF2()),
			"cfmPassword" : Password.hash(_cfmPassword.text, PBKDF2())
		};

    http.Response response = await http.post(RESET_PASSWORD, body: data);
    final responseData = json.decode(response.body);

		setState(() => _isLoading = false);
    if (response.statusCode == 200) {
			int result = responseData['result'];
			if (result == 3) {
				result = await users.resetPassword(_phone, _newPassword.text);
				if (result == 1) {
					_formKey.currentState.reset();
					Navigator.pushReplacementNamed(context, '/login');
				} else {
					register.snackBarShow(scaffoldKey, 'Problem reseting password');
				}
			}
		} else {
  		register.snackBarShow(scaffoldKey, responseData['error']);
		}
  }

}