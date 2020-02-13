import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:password/password.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/users_controller.dart';
import '../global.dart';

class RegistrationUtilities {

	String _confirmationCode;
	UsersController users = UsersController();

	List shuffle(List items) {
		var random = Random();
		for (var i = items.length - 1; i > 0; i--) {
			var n = random.nextInt(i + 1);
			var temp = items[i];
			items[i] = items[n];
			items[n] = temp;
		}
		return items;
	}

	String generateConfirmationCode(String username, String password) {
		var confirmationCode = shuffle((username+password).split('')).join();
		confirmationCode = Password.hash(confirmationCode, PBKDF2());
		return confirmationCode.substring(confirmationCode.length-8);
	}

 dialog(context, textCaption, setState, phone,  password) {
		String genCode = generateConfirmationCode(phone, password);
		return showDialog(
			context: context,
			builder: (BuildContext context) => AlertDialog(
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.circular(20),
				),
				backgroundColor: Colors.grey[100],
				title: Column(
					children: <Widget>[
						Text(textCaption, textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
						Padding(
							padding: const EdgeInsets.only(top: 5.0),
							child: Text('To complete the process please enter confirmation code: $genCode',
								textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.red)
							),
						)
					],
				),
				content: TextField(
					autofocus: true,
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
							(_confirmationCode == genCode)
							? confirmAccount(context, setState, phone)
							: showAlertDialog(context, 'Warning', 'Invalid Confirmation Code'),
					),
				],
			),
		);
	}

	void confirmAccount(context, setState, phone) async {
    var data = { "phone" : phone };

    http.Response response = await http.post(SIGNUP_CONFIRMED, body: data);
    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
			int result = await users.confirmAccount(phone);
			if (result > 0) {
				savePref(setState, 1, phone);
				redirectLogin(context);
			} else {
				showAlertDialog(context, 'Warning', 'Problem confirming account');
			}
		} else {
      showAlertDialog(context, 'Error', responseData['error']);
		}
  }

	void showAlertDialog(context, title, message) {
    AlertDialog alertDialog = AlertDialog(title: Text(title), content: Text(message));
    showDialog(context: context, builder: (_) => alertDialog);
  }

	void snackBarShow(scaffoldKey, String text) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  savePref(setState, int signIn,String phone) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("signIn", signIn);
      preferences.setString("phone", phone);
    });
  }

	void navigatePreviousPage(context) => Navigator.pushReplacementNamed(context, '/login');

	void redirectLogin(context) => Future.delayed(Duration(seconds: 2), () => navigatePreviousPage(context));

}
