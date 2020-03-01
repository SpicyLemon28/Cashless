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
      padding: const EdgeInsets.only(right: 100),
      child: Container(
         decoration: BoxDecoration(
           gradient: LinearGradient(
             begin: Alignment.topRight,
             end: Alignment.bottomLeft,
             colors: [Colors.white, Colors.green]
           )
         ),
         child: ListView(
           children: <Widget>[
             UserAccountsDrawerHeader(
               accountName: Text('Myco Perez', style: TextStyle(color: Colors.black)),
               accountEmail: Text('mycoperez@email.com', style: TextStyle(color: Colors.black)),
               decoration: BoxDecoration(
                 color: Colors.green [100]
               ),
               currentAccountPicture: CircleAvatar(
                 backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                 ? Colors.blue
                 : Colors.white,
                 child: Text("M", style: TextStyle(fontSize: 40))
               ),
             ),
             listTile(Icons.settings, 'Settings', () => navigatePage('/settings')),
             listTile(Icons.help, 'Help', null),
           ],
         ),
      )
      );
  }

  Widget listTile(iconText, txt, goTo) => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: ListTile(
      leading: Icon(iconText),
      title: Text(txt),
      onTap: goTo
    )
  );

 

  void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);

}