import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {navigatePreviousPage(context);},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green [900],
          title: Text('Profile'),
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () {navigatePreviousPage(context);},),
        ),
        body: Stack(
          fit:StackFit.expand,
          children: <Widget>[
            ListView(
              children: <Widget>[
                title('Name'),
                card('Myco Paul John Perez', Icon(Icons.edit), () => navigatePage('/changeName')),
                title('Phone Number'),
                card('09123456789', Icon(Icons.phone_android), null),
                title('Email'),
                card('example@email.com', Icon(Icons.email), null),
                title('Password'),
                card('123456', Icon(Icons.lock), null),
                title('Pin'),
                card('123456', Icon(Icons.vpn_key), null),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget title(txt) => Padding(
    padding:const EdgeInsets.only(top: 20, left: 10),
    child: Text(txt, style: TextStyle(color: Colors.grey [600], fontSize: 20, fontWeight: FontWeight.w500),),
  );

  Widget card(listTxt, suffixIcon, goTo) => Card(
    child: ListTile(
      trailing: suffixIcon,
      onTap: goTo,
      title: Text(listTxt, style: TextStyle(color: Colors.grey),),
    ),
  );
  

  void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);

  void navigatePreviousPage(context) => Navigator.pushReplacementNamed(context, '/settings');
}