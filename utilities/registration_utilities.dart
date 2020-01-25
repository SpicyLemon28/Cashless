
import 'dart:math';
import 'package:password/password.dart';

class RegistrationUtilities {

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

}
