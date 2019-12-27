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
                       appName('SmartPay'),
                       text('Create a New Profile'),
                       nameEmail('Name','Enter Full Name', Icons.person,),
                       nameEmail('Email', 'Enter email address', Icons.email),
                       phoneIdNum('Phone Number', 'Enter phone number', Icons. phone_android),
                       phoneIdNum('ID Number', 'Enter School ID Number', Icons.perm_identity),
                       pass('Password', 'At least 6-8 characters', Icons.lock),
                       signUp('Register'),
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

  Widget appName(txt) => Padding(
    padding: const EdgeInsets.only(top: 70,),
    child: Text(txt, style: TextStyle(fontSize: 25),),
  );

  Widget text(txt) => Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Text(txt, style: TextStyle(fontSize: 18),)
  );

//Name and Email
  Widget nameEmail(lblTxt,hntTxt, iconTxt) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return textValidate(lblTxt, value);
        }
      },
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

//Phone num and ID num
  Widget phoneIdNum(lblTxt, hntTxt, iconTxt) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child:TextFormField(
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return textValidate(lblTxt, value);
        }
      },
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


//Password
  Widget pass(lblTxt,hntTxt,iconTxt) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return textValidate(lblTxt, value);
        }
      },
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

//SignUp Button
  Widget signUp(txt) => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: RaisedButton(
      child: Text(txt),
      onPressed: (){
        setState(() {
          if(_formKey.currentState.validate()){
            dialog();
          }
        });
      },
    ),
  );
//Functions
  textValidate(lblTxt, value){
  switch (lblTxt){
    case 'Email':
      if(value != 1){
        return 'Invalid Email';
      }
    break;

    case 'Password':
       return 'Password should not be empty!';
    break;

    default: 
      return 'Field should not be empty!';
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