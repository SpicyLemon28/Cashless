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
         child: ListView(
           children: <Widget>[
             Container(
               constraints: BoxConstraints(maxHeight: 800),
               decoration: BoxDecoration(
                 gradient: LinearGradient(
                   begin: Alignment.topLeft,
                   end: Alignment.bottomRight,
                   colors: [Colors.greenAccent, Colors.green[900] ]
                 ) 
                 ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Icon(Icons.account_circle, size: 80,color: Colors.white,),
                  ),
                  text('Myco Paul John Perez'),
                  text('09191234567'),
                  Padding(padding: const EdgeInsets.only(top: 30)),
                  listTile(Icons.settings, 'Settings', () => navigatePage('/settings')),
                  listTile(Icons.help, 'Help', null),
                ],
              ),
             )
           ],
         ),
      );
  }

  Widget text(txt) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Text(txt, style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),),
  );

 Widget listTile(iconText, txt, goTo) => ListTile(
      leading: Icon(iconText, color: Colors.white),
      title: Text(txt, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
      onTap: goTo
    );

 

  void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);

}