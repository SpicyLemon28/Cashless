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
            onPressed: () => navigatePreviousPage(context),
          )
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) => Column(
            children: <Widget>[
              listTile('Account Profile', () => navigatePage('/editProfile'), Icons.arrow_forward_ios),
              Divider(),

              listTile('Terms and Conditions', null, Icons.arrow_forward_ios),
              Divider(),

              listTile('About SmartPay', null , Icons.arrow_forward_ios),
              Divider(),
            ],
          )
          )
      ),
    );
  }
  
  Widget listTile(txt, goTo, suffixIcon) => ListTile(
    title: Text(txt),
    onTap: goTo,
    trailing: Icon(suffixIcon),
  );

  void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);

  void navigatePreviousPage(context) => Navigator.pushReplacementNamed(context, '/dashboard');
}