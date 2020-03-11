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
                  card('Myco Paul John Perez', Icon(Icons.edit, color: Colors.grey), () => navigatePage('/changeName')),
                  title('Phone Number'),
                  card('09123456789', Icon(Icons.phone_android, color: Colors.grey), null),
                  title('Email'),
                  card('example@email.com', Icon(Icons.email, color: Colors.grey), null),
                  title('Password'),
                  card('123456', Icon(Icons.lock, color: Colors.grey), null),
                  title('Pin'),
                  card('123456', Icon(Icons.vpn_key, color: Colors.grey), null),
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

  void navigatePreviousPage(context) => Navigator.pushReplacementNamed(context, '/dashboard');

}