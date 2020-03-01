import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () { navigatePreviousPage(context);},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green [900],
          title: Text('Settings'),
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () => navigatePreviousPage('/dashboard'),
          )
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) => Column(
            children: <Widget>[
              listTile('Edit Profile', () => navigatePage('/editProfile')),
              Divider(),

              listTile('Terms and Conditions', null),
              Divider(),

              listTile('About SmartPay', null),
              Divider(),
            ],
          )
          )
      ),
    );
  }
  
  Widget listTile(txt, goTo) => ListTile(
    title: Text(txt),
    onTap: goTo,
  );

  void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);

  void navigatePreviousPage(navTo){
    Navigator.popAndPushNamed(context, navTo);
  }
}