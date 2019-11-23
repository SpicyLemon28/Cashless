import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(
         fit: StackFit.expand,
         children: <Widget>[
           ListView(
             children: <Widget>[
               SafeArea(
                 child: Padding(padding: const EdgeInsets.symmetric(horizontal: 30),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     appName('AppName & Logo'),
                     text('Create a New Profile'),
                     name('Name','Enter Full Name', Icons.person,),
                     email('Email', 'Enter email address', Icons.email),
                     phoneNum('Phone Number', 'Enter phone number', Icons. phone_android),
                     idNum('ID Number', 'Enter School ID Number', Icons.perm_identity),
                     pin('Pin', 'At least 6-8 characters'),
                     pin('Confirm Pin', 'Re-enter Pin'),
                     signUp('Register'),
                   ],
                 ),
                 ),
               ),
             ],
           ),
         ],
       ),
    );
  }

  Widget appName(txt) => Padding(
    padding: const EdgeInsets.only(top: 70,),
    child: Text(txt, style: TextStyle(fontSize: 25),),
  );

  Widget text(txt) => Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Text(txt, style: TextStyle(fontSize: 18),)
  );

  Widget name(lblTxt, hntTxt, iconTxt) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 10),
    child: TextField(
      decoration: InputDecoration(
        labelText: lblTxt,
        hintText: hntTxt,
        prefixIcon: Icon(iconTxt, color: Colors.grey,),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15)
        ),
      ),
    ),
  );

  Widget email(lblTxt, hntTxt, iconTxt) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextField(
      decoration: InputDecoration(
        labelText: lblTxt,
        hintText: hntTxt,
        prefixIcon: Icon(iconTxt, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15)
        ),
      ),
    ),
  );

  Widget phoneNum(lblTxt, hntTxt, iconTxt) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child:TextField(
      decoration: InputDecoration(
        labelText: lblTxt,
        hintText: hntTxt,
        prefixIcon: Icon(iconTxt, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15)
        ),
      ),
      ),
  );

  Widget idNum(lblTxt, hntTxt, iconTxt) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child:TextField(
      decoration: InputDecoration(
        labelText: lblTxt,
        hintText: hntTxt,
        prefixIcon: Icon(iconTxt, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15)
        ),
      ),
      ),
  );

  Widget pin(lblTxt, hntTxt) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextField(
      decoration: InputDecoration(
        labelText: lblTxt,
        hintText: hntTxt,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15)
        ),
      ),
    ),
  );

  Widget signUp(txt) => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: RaisedButton(
      child: Text(txt),
      onPressed: () {

      },
    ),
  );
}