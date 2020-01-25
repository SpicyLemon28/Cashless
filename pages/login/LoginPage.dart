import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../../services/response/login_response.dart';

import '../../pages/dashboard/dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }
class _LoginPageState extends State<LoginPage> implements LoginCallBack {

	User user = User('', '', '', '', '', '', '', 0);

	LoginStatus _loginStatus = LoginStatus.notSignIn;

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
		_showSnackBar(error);

  }

  @override
  void onLoginSuccess(User user) async {

    if (user != null) {
      savePref(1, user.phone);
      _loginStatus = LoginStatus.signIn;
    } else {
      setState(() => _isLoading = false);
			_showSnackBar("Can't login invalid Phone or Password");

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
																linkButton('Forgot Password?', () => forgotPassDialog()),
															],
														),
														loginButton('Sign In'),
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
    padding: const EdgeInsets.only(left: 20, right: 20, top: 15,),
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
							icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
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
  Widget loginButton(txtLogin) {
		return _isLoading
      ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)
        )
      : Padding(
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
								_response.doLogin(_phone, _password);
							} else {
								setState(() => _autoValidate = true);
							}
						}
					)
				);
	}

	// Functions
  textValidation(hntText, value) {
		var errorMessages;
		if (value.isEmpty) {
			errorMessages = '$hntText should not be empty';
		} else {
			switch (hntText){
				case 'Phone Number':
					if (value.length < 11) errorMessages = 'Phone Number should be 11 digits';
					break;
				case 'Password':
					if (value.length < 6) errorMessages = 'Password must be 6 characters or longer';
					break;
			}
		}
		return errorMessages;
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
			_loginStatus = signIn == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
		});
	}

  savePref(int signIn,String phone) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("signIn", signIn);
      preferences.setString("phone", phone);
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

	void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  forgotPassDialog() => showDialog(
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
						)
					)
				]
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
					child: Text('OKAY'),
					onPressed: () => navigatePage('/forgetpassword')
				),
			],
		),
	);
}
