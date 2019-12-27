import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../menuForm/NavBar.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SmartPay'), backgroundColor: Colors.green[900],),
       body: Form(
         key: _formKey,
         child: Stack(
           fit: StackFit.expand,
           children: <Widget>[
             ListView(
               children: <Widget>[
                 SafeArea(
                   child: Padding(padding: const EdgeInsets.symmetric(horizontal: 30),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       text('Create a New Profile'),
                       nameEmail('Name','Enter Full Name', Icons.person,),
                       nameEmail('Email', 'Enter email address', Icons.email),
                       phoneIdNum('Phone Number', 'Enter phone number', Icons. phone_android),
                       phoneIdNum('School ID', 'Enter School ID Number', Icons.perm_identity),
                       pass('Password', 'Enter a Password', Icons.lock),
                       signUp('Sign Up'),
                     ],
                   ),
                   ),
                 ),
               ],
             ),
           ],
         ),
       ),
    );
  }

  /*Widget appName(txt) => Padding(
    padding: const EdgeInsets.only(top: 70,),
    child: Text(txt, style: TextStyle(fontSize: 25),),
  ); */

  Widget text(txt) => Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Text(txt, style: TextStyle(fontSize: 18),)
  );

//Name and Email
  Widget nameEmail(lblTxt,hntTxt, iconTxt) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: TextFormField(
      validator: (String value) => textValidate(lblTxt, value),
      decoration: InputDecoration(
        labelText: lblTxt,
        hintText: hntTxt,
        prefixIcon: Icon(iconTxt, color: Colors.grey,),
      ),
    ),
  );

//Phone num and ID num
  Widget phoneIdNum(lblTxt, hntTxt, iconTxt) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child:TextFormField(
      keyboardType: TextInputType.number,
      validator: (String value) => textValidate(lblTxt, value),
      decoration: InputDecoration(
        labelText: lblTxt,
        hintText: hntTxt,
        prefixIcon: Icon(iconTxt, color: Colors.grey),
      ),
      ),
  );


//Password
  Widget pass(lblTxt,hntTxt,iconTxt) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: TextFormField(
      validator: (String value) => textValidate(lblTxt, value),
      decoration: InputDecoration(
        labelText: lblTxt,
        hintText: hntTxt,
        prefixIcon: Icon(iconTxt, color: Colors.grey),
      ),
    ),
  );

//SignUp Button
  Widget signUp(txt) => Padding(
    padding: const EdgeInsets.only(top: 2, left: 220),
    child: RaisedButton(
      color: Colors.greenAccent,
      child: Text(txt),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: () => textValidated()
    ),
  );
  
//Functions
  textValidate(lblTxt, value){
  switch (lblTxt){
    case 'Name':
      if(value.isEmpty){
        return 'Name should not be empty';
      }
    break;

    case 'Email':
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);

      if(value.isEmpty){
        return 'Email should not be empty';
      }

      if(!regex.hasMatch(value)){
        return ('Enter a valid email address');
      }
    break;

    case 'Phone Number':
      if(value.isEmpty){
        return 'Phone Number should not be empty';
      }

      if(value.length < 11){
        return 'Phone Number must be 11 digits';
      }
    break;

    case 'School ID':
      if(value.isEmpty){
        return 'School ID should not be empty';
      }

      if(value.length < 11){
        return 'School ID must be 11 digits';
      }
    break;

    case 'Password':
        if(value.isEmpty){
          return 'Password should not be empty';
        }

       if(value.length > 6){
         return 'Password must be 6 to 8 characters long';
       }
    break;
  }
}

  textValidated() {
    if(_formKey.currentState.validate()){
      dialog();
    }
  }

  dialog() => showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.grey[100],
      title: Column(
        children: <Widget>[
          Text('We sent you a Confirmation Code',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text('Please Check your Inbox',
            textAlign: TextAlign.center, 
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),),
          )
        ],
      ),
      content: TextField(
        decoration: InputDecoration(
          hintText: 'Enter Confirmation Code',
          hintStyle: TextStyle(fontSize: 12),
          prefixIcon: Icon(Icons.code),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12)
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Login'),
          onPressed: (){
            Navigator.of(context).push(
          CupertinoPageRoute<Null>(builder: (
            BuildContext context) => NavBar()));
          },
        ),
      ],
    ),

  );
}