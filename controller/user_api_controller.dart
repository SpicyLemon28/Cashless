import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:password/password.dart';

import './users_controller.dart';
import '../global.dart';

class UserAPIController {

	Future<Map<String, dynamic>> confirmAccount(String phone) async {
    final users = UsersController();
		final response = await http.post(SIGNUP_CONFIRMED, body: {"phone" : phone});
		final statusCode = response.statusCode;

		return returnResult(statusCode, await users.confirmAccount(phone), json.decode(response.body));
	}

	Future<dynamic> registerUser(user) async {
    var data = {
				"phone"			: user.phone,
				"studentId"	: user.studentId,
				"name"			: user.name,
				"email"			: user.email,
				"password"	: Password.hash(user.password, PBKDF2()),
				"pin"				: Password.hash(user.pin, PBKDF2())
		};
  	final response = await http.post(USER_SIGNUP, body: data);
    final responseData = json.decode(response.body);
		final statusCode = response.statusCode;

		return returnResult(statusCode, responseData['result'], responseData['error']);
  }

	Future<dynamic> signIn(String phone, String password) async {
    var data = {
			"phone"    : phone,
			"password" : Password.hash(password, PBKDF2())
		};

    final response = await http.post(USER_SIGNIN, body: data);
    final responseData = json.decode(response.body);
		final statusCode = response.statusCode;

		return returnResult(statusCode, responseData['result'], responseData['error']);
  }

	Future<dynamic> resetPassword(String token, String newPassword, String cfmPassword) async {
		var data = {
			"token"       : token,
			"newPassword" : Password.hash(newPassword, PBKDF2()),
			"cfmPassword" : Password.hash(cfmPassword, PBKDF2())
		};
    final response = await http.post(RESET_PASSWORD, body: data);
    final responseData = json.decode(response.body);
		final statusCode = response.statusCode;

		return returnResult(statusCode, responseData['result'], responseData['error']);
  }

  //
  Future<dynamic> resetPin(String token, String newPassword, String cfmPassword) async {
		var data = {
			"token"       : token,
			"newPin" : Password.hash(newPassword, PBKDF2()),
			"cfmPin" : Password.hash(cfmPassword, PBKDF2())
		};
    final response = await http.post(RESET_PASSWORD, body: data);
    final responseData = json.decode(response.body);
		final statusCode = response.statusCode;

		return returnResult(statusCode, responseData['result'], responseData['error']);
  }

	Future<dynamic> verifyConfirmationCode(String confirmationCode) async {
    final response = await http.post(
			CONFIRMED_REQUEST_RESET_PASSWORD,
			body: {"confirmationCode" : confirmationCode}
		);
    final responseData = json.decode(response.body);
		final statusCode = response.statusCode;

		return returnResult(statusCode, responseData['result'], responseData['error']);
  }

	Future<dynamic> verifyForgetPassword(String phone) async {
    final response = await http.post(REQUEST_RESET_PASSWORD, body: {"phone" : phone});
    final responseData = json.decode(response.body);
		final statusCode = response.statusCode;

		return returnResult(statusCode, responseData['result'], responseData['error']);
  }

	Future<dynamic> updateFullname(String phone, String newname) async {
    final response = await http.post(
			UPDATE_FULLNAME,
			body: {"phone" : phone, "name" : newname}
		);
    final responseData = json.decode(response.body);
		final statusCode = response.statusCode;

		return returnResult(statusCode, responseData['result'], responseData['error']);
  }

	returnResult(status, success, error) {
		var response = (status == 200)
			? {"statusCode" : status, "result" : success}
			: {"statusCode" : status, "result" : error};

		return json.encode(response);
	}

}
