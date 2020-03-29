import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  var _phone, _fullname, _email;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userInfo = json.decode(preferences.getString("user"));
		setState(() {
      _phone = userInfo["phone"];
			_fullname =  userInfo["name"];
      _email =  userInfo["email"];
		});
  }

  @override
	void initState() {
		super.initState();
		getPref();
	}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () { navigatePreviousPage(context); },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF2c3e50),
          title: Text('Profile'),
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () => navigatePreviousPage(context),
          ),
        ),
        body: Stack(
            fit:StackFit.expand,
            children: <Widget>[
              ListView(
                children: <Widget>[
                  title('Name'),
                  card(_fullname, Icon(Icons.edit, color: Colors.grey), () => navigatePage('/changeName')),
                  title('Phone Number'),
                  card(securePhone(_phone), Icon(Icons.phone_android, color: Colors.grey), null),
                  title('Email'),
                  card(_email, Icon(Icons.email, color: Colors.grey), null),
                  title('Password'),
                  card('********', Icon(Icons.edit, color: Colors.grey), () => navigatePage('/changePass')),
                  title('Pin'),
                  card('********', Icon(Icons.vpn_key, color: Colors.grey), null),
                ],
              )
            ],
          ),
        ),
    );
  }

  Widget title(txt) => Padding(
    padding:const EdgeInsets.only(top: 20, left: 10),
    child: Text(txt, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
  );

  Widget card(listTxt, suffixIcon, goTo) => Card(
    elevation: 5,
    color: Colors.white,
    child: ListTile(
      trailing: suffixIcon,
      onTap: goTo,
      title: Text(listTxt, style: TextStyle(color: Colors.grey),),
    ),
  );

  void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);

  void navigatePreviousPage(context) => Navigator.pushReplacementNamed(context, '/');

	securePhone(phone) {
		return phone == null ? "" : phone.replaceRange(4, 9, '*' * 5);
	}

}
