import 'package:flutter/material.dart';

import './pages/login/LoginPage.dart';
import './pages/register/RegisterPage.dart';
import './pages/forget/ForgetPassword.dart';
import './pages/forget/ResetPassword.dart';

import './pages/list/user_list.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return 	MaterialApp(
			debugShowCheckedModeBanner: false,
			title: "Cashless",
			routes: {
				'/':               (BuildContext context) => LoginPage(),
				'/login':          (BuildContext context) => LoginPage(),
				'/register':       (BuildContext context) => Register(),
				'/forgetPassword': (BuildContext context) => ForgetPassword(),
				'/resetPassword':  (BuildContext context) => ResetPassword()
			},
			// home: UserList()
		);
	}
}
