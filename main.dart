
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './pages/login/LoginPage.dart';
import './pages/register/RegisterPage.dart';
import './pages/forget/ForgetPassword.dart';
import './pages/forget/ResetPassword.dart';
import './pages/dashboard/dashboard.dart';
import './pages/dashboard/NavPage/LoadWalletPage/LoadWallet.dart';
import './pages/dashboard/NavPage/LoadWalletPage/LoadWalletQR.dart';
import './pages/dashboard/NavPage/ScantoPayPage/ScantoPay.dart';
import './pages/dashboard/NavPage/TransferMoneyPage/TransferMoney.dart';
import './pages/dashboard/NavPage/TransferMoneyPage/TransferMoneyDetails.dart';
import './pages/dashboard/NavPage/ReceiveMoneyPage/ReceiveMoney.dart';
import './pages/dashboard/NavPage/SideMenuDrawerPage/SettingsPage/Settings.dart';
import './pages/dashboard/NavPage/SideMenuDrawerPage/SettingsPage/EditProfilePage/EditProfile.dart';

import './pages/dashboard/NavPage/SideMenuDrawerPage/SettingsPage/EditProfilePage/ChangePass.dart';

//import './pages/list/user_list.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
		return 	MaterialApp(
			debugShowCheckedModeBanner: false,
			title: "Cashless",
			routes: {
				'/':                      (BuildContext context) => LoginPage(),
				'/login':                 (BuildContext context) => LoginPage(),
				'/register':              (BuildContext context) => Register(),
				'/forgetPassword':        (BuildContext context) => ForgetPassword(),
				'/resetPassword':         (BuildContext context) => ResetPassword(),
        '/dashboard':             (BuildContext context) => Dashboard(null),
        '/loadWallet':            (BuildContext context) => LoadWallet(),
        '/loadWalletQR':          (BuildContext context) => LoadWalletQR(),
        '/scantoPay':             (BuildContext context) => ScantoPay(),
        '/transferMoney':         (BuildContext context) => TransferMoney(),
        '/transferMoneyDetails':  (BuildContext context) => TransferMoneyDetails(),
        '/receiveMoney':          (BuildContext context) => ReceiveMoney(),
        '/settings':              (BuildContext context) => Settings(),
        '/editProfile':           (BuildContext context) => EditProfile(),
        '/changePass':            (BuildContext context) => ChangePass()
			},
			// home: UserList()
		);
	}
}
