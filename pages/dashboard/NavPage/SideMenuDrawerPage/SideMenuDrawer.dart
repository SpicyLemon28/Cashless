import 'package:flutter/material.dart';

class SideMenuDrawer extends StatefulWidget {
	final String fullname, phone;

  SideMenuDrawer(this.fullname, this.phone);

  @override
  _SideMenuDrawerState createState() => _SideMenuDrawerState(this.fullname, this.phone);
}

class _SideMenuDrawerState extends State<SideMenuDrawer> {
  String fullname, phone;

	_SideMenuDrawerState(this.fullname, this.phone);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 100),
         child: ListView(
           children: <Widget>[
             Container(
               constraints: BoxConstraints(maxHeight: 800),
               color: Color(0xFF2c3e50),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Icon(Icons.account_circle, size: 80,color: Colors.white,),
                  ),
                  text(fullname),
                  text(securePhone(phone)),
                  Padding(padding: const EdgeInsets.only(top: 30)),
                  listTile(Image.asset('assets/SmartPayIcons/Profile.png'), 'Profile', () => navigatePage('/editProfile')),
                  listTile(Image.asset('assets/SmartPayIcons/Terms-Conditions.png'), 'Terms & Conditions', null),
                  listTile(Image.asset('assets/SmartPayIcons/About.png'), 'About SmartPay', () => navigatePage('/about'))
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
      leading: IconButton(icon: iconText, onPressed: null),
      title: Text(txt, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400)),
      onTap: goTo
    );

 

  void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);

	securePhone(phone) {
		return phone == null ? "" : phone.replaceRange(4, 9, '*' * 5);
	}

	userAvatar(fullname) {
		return fullname == null ? "" : fullname[0];
	}

}
