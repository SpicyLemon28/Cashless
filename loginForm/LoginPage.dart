import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './ForgetPassword.dart';
import '../menuForm/NavBar.dart';
import './RegisterPage.dart';

import '../models/user.dart';


class LoginPage extends StatefulWidget {

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var _formKey = GlobalKey<FormState>();

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
                            linkButton('Sign Up', () => navigatePage(Register(User('', '', '', '', '', '', '')))),
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
      obscureText: hntText == 'Password' ? !passwordVisible : false,
      validator: (String value,) => textValidation(hntText, value),
      decoration: InputDecoration(
        hintText: hntText,
        prefixIcon: Icon(icnText, color: Colors.grey),
        suffixIcon: hntText == 'Password'
					? IconButton(
						icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
						onPressed: () => setState(() { passwordVisible = !passwordVisible; })
					)
					: IconButton(
						icon: Icon(Icons.phone_android),
						onPressed: () {}
          ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  );

  // Login Button
  Widget loginButton(txtLogin) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: RaisedButton(
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.greenAccent,
      child: Text(txtLogin),
      onPressed: () {
				if (_formKey.currentState.validate()) navigatePage(NavBar());
			}
    )
  );

	// Functions
  textValidation(hntText, value) {
    var userInput = '123456';
		var errorMessages;

		if (value.isEmpty) {
			errorMessages = '$hntText should not be empty';
		} else {
			switch (hntText){
				case 'Phone Number':
					if (value.length < 11) errorMessages = 'Phone Number should be 11 digits';
					break;
				case 'Password':
					if (value != userInput) errorMessages = 'Incorrect Password';
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
					onPressed: () => navigatePage(ForgetPin())
				),
			],
		),
	);
}
