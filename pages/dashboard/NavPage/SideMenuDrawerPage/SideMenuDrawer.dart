import 'package:flutter/material.dart';

class SideMenuDrawer extends StatefulWidget {
  SideMenuDrawer({Key key}) : super(key: key);

  @override
  _SideMenuDrawerState createState() => _SideMenuDrawerState();
}

class _SideMenuDrawerState extends State<SideMenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 120),
      child: Container(
         decoration: BoxDecoration(
           color: Colors.white
         ),
         child: ListView(
           children: <Widget>[
             UserAccountsDrawerHeader(
               accountName: Text('Myco Perez'),
               accountEmail: Text('mycoperez@email.com'),
               decoration: BoxDecoration(
                 color: Colors.green[900]
               ),
               currentAccountPicture: CircleAvatar(
                 backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                 ? Colors.blue
                 : Colors.white,
                 child: Text("M", style: TextStyle(fontSize: 40))
               ),
             ),
             listTile(Icons.settings, 'Settings'),
             listTile(Icons.help, 'Help'),
           ],
         ),
      ),
    );
  }

  Widget listTile(iconText, txt) => ListTile(
    title: Text(txt),
    leading: Icon(iconText),
    onTap: () {setState(() => print('RUNNING!!'));},
  );

  void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);

}