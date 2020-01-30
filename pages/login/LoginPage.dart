import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:password/password.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../../services/response/login_response.dart';
import '../../utilities/registration_utilities.dart';
import '../../global.dart';

import '../../pages/dashboard/dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }
class _LoginPageState extends State<LoginPage> implements LoginCallBack {

	User user = User('', '', '', '', '', '', '', 0);

	LoginStatus _loginStatus = LoginStatus.notSignIn;
	RegistrationUtilities register = RegistrationUtilities();

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

	String _phone, _password;

  bool passwordVisible = true;
	bool _autoValidate = false;

	var signIn;

	LoginResponse _response;

  _LoginPageState() { _response = LoginResponse(this); }

  @override
  void initState() {
    super.initState();
    getPref();
  }

	@override
  void onLoginError(String error) {
    setState(() => _isLoading = false);
		register.snackBarShow(scaffoldKey, error);
  }

  @override
  void onLoginSuccess(User user) async {

    if (user != null) {
      register.savePref(1, user.phone, setState);
      _loginStatus = LoginStatus.signIn;
    } else {
      setState(() => _isLoading = false);
			register.snackBarShow(scaffoldKey, "Invalid credentials");
    }
  }

	@override
  Widget build(BuildContext context) {
	  switch (_loginStatus) {
			case LoginStatus.signIn:
				return Dashboard(signOut);
				break;
    	default:
				return Scaffold(
          //backgroundColor: Colors.green[900],
					key: scaffoldKey,
					body: Form(
						key: _formKey,
						autovalidate: _autoValidate,
						child: Stack(
							fit: StackFit.expand,
							children: <Widget>[
								ListView(
									children: <Widget>[
										SafeArea(
											child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
												child: Column(
													mainAxisAlignment: MainAxisAlignment.center,
													children: <Widget>[
														appName('SmartPay'),
														textFormField(Icons.person, 'Phone Number', TextInputType.number),
														textFormField(Icons.lock, 'Password', TextInputType.text),
														Row(
															mainAxisAlignment: MainAxisAlignment.spaceBetween,
															children: <Widget>[
																linkButton('Sign Up', () => navigatePage('/register')),
																linkButton('Forgot Password?', () => navigatePage('/forgetPassword')),
															],
														),
														loginButton('Sign In', TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
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
	}

	// Name of the App
  Widget appName(txtApp) => Padding(
    padding: const EdgeInsets.only(top: 200, bottom: 50),
    child: Text(txtApp, style: TextStyle(fontSize: 30),),
  );

  Widget linkButton(txtLink, onClick) => Padding(
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: FlatButton(
      onPressed: onClick,
      child: Text(txtLink, style: TextStyle(fontSize: 12, color: Colors.blue,)),
    )
  );


  Widget textFormField(icnText, hntText, keyType) => Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 20,),
    child: TextFormField(
      keyboardType: keyType,
			inputFormatters: keyType == TextInputType.number
				? <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly]
				: null,
      obscureText: hntText == 'Password' ? passwordVisible : false,
			onSaved: (value) => updateTextFormField(hntText, value),
      validator: (String value,) => textValidation(hntText, value),
      decoration: InputDecoration(
        hintText: hntText,
        prefixIcon: Icon(icnText, color: Colors.grey),
        suffixIcon: hntText == 'Password'
					? IconButton(
							icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility),
							onPressed: () => setState(() => passwordVisible = !passwordVisible)
						)
					: Icon(Icons.phone_android),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  );

  // Login Button
  Widget loginButton(buttonText, styleText) {
		return _isLoading
      ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)
        )
      : Padding(
<<<<<<< HEAD
					padding: const EdgeInsets.only(top: 15),
					child: RaisedButton(
						shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
						color: Colors.greenAccent,
						child: Text(txtLogin),
						onPressed: () {
							var form = _formKey.currentState;
							if (form.validate()) {
								setState(() => _isLoading = true);
								form.save();
								_signIn();
							} else {
								setState(() => _autoValidate = true);
							}
						}
					)
=======
					padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
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
>>>>>>> 13_ForgetPassword
				);
	}
  

	// Functions
<<<<<<< HEAD
=======
  void _submit() {
    var form = _formKey.currentState;
    if (form.validate()) {
      setState(() => _isLoading = true);
      form.save();
      _signIn();
    } else {
      setState(() => _autoValidate = true);
		}
  }

>>>>>>> 13_ForgetPassword
	void _signIn() async {
    var data = {
			"phone"    : _phone,
			"password" : Password.hash(_password, PBKDF2())
		};

    http.Response response = await http.post(USER_SIGNIN, body: data);
    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
			int result = responseData['result'];
			if (result == 1) {
				_response.doLogin(_phone, _password);
			} else if (result == 3) {
				setState(() => _isLoading = false);
				register.dialog(context, 'Account not yet confirmed', _phone,  _password, setState);
			}
		} else {
			setState(() => _isLoading = false);
    	register.snackBarShow(scaffoldKey, responseData['error']);
		}
  }

  textValidation(hntText, value) {
		if (value.isEmpty) {
			return '$hntText should not be empty';
		} else {
			switch (hntText) {
				case 'Phone Number':
					if (value.length < 11) return '$hntText should be 11 digits';
					break;
				case 'Password':
					if (value.length < 6) return '$hntText must be 6 characters or longer';
					break;
			}
		}
  }

  void updateTextFormField(lblText, txtValue) {
		lblText == 'Password' ? _password     = txtValue : _phone     = txtValue;
		lblText == 'Password' ? user.password = txtValue : user.phone = txtValue;
	}

	void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);

	getPref() async {
		SharedPreferences preferences = await SharedPreferences.getInstance();
		setState(() {
			signIn = preferences.getInt("signIn");
			_phone = preferences.getString("phone");
			_loginStatus = signIn == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
		});
	}

	signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
			_isLoading = false;
      preferences.setInt("signIn", null);
      _loginStatus = LoginStatus.notSignIn;
    });
  }

}
