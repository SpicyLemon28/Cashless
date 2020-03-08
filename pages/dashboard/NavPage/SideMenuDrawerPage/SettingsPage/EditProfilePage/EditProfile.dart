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
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
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
                card('Myco Paul John Perez', Icon(Icons.edit, color: Colors.grey[800]), () => navigatePage('/changeName')),
                title('Phone Number'),
                card('09123456789', Icon(Icons.phone_android, color: Colors.grey[800]), null),
                title('Email'),
                card('example@email.com', Icon(Icons.email, color: Colors.grey[800]), null),
                title('Password'),
                card('123456', Icon(Icons.lock, color: Colors.grey[800]), null),
                title('Pin'),
                card('123456', Icon(Icons.vpn_key, color: Colors.grey[800]), null),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget title(txt) => Padding(
    padding:const EdgeInsets.only(top: 20, left: 10),
    child: Text(txt, style: TextStyle(color: Colors.grey[300], fontSize: 20, fontWeight: FontWeight.w500),),
  );

  Widget card(listTxt, suffixIcon, goTo) => Card(
    color: Colors.greenAccent,
    child: ListTile(
      trailing: suffixIcon,
      onTap: goTo,
      title: Text(listTxt, style: TextStyle(color: Colors.grey[800]),),
    ),
  );
  
  void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);

  void navigatePreviousPage(context) => Navigator.pushReplacementNamed(context, '/settings');

}