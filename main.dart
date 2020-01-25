import 'package:flutter/material.dart';

import './pages/login/LoginPage.dart';
import './pages/register/RegisterPage.dart';
import './pages/forget/ForgetPassword.dart';

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
				'/forgetpassword': (BuildContext context) => ForgetPassword()
			},
      //home: UserList()
		);
	}
}
