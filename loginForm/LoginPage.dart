import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'ForgetPin.dart';
import '../menuForm/NavBar.dart';
import 'RegisterPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var _formKey = GlobalKey<FormState>();

  bool passwordVisible;

  @override
  void initState() {
    passwordVisible = false;
    super.initState();
}

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
                        passNreg('Sign Up', () => registerPage()),
                        txtFormField(Icons.phone_android, 'Phone Number', TextInputType.number),
                        txtFormField(Icons.lock, 'Password', TextInputType.text),
                        passNreg('Forgot Password?', () => forgotPassDialog()),
                        login('Sign In'),
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

//Name of the App
  Widget appName(txt) => Padding(
    padding: const EdgeInsets.only(top: 200, bottom: 50),
    child: Text(txt, style: TextStyle(fontSize: 30),),
    
  );

  //Forgot Password and Sign Up Button
  Widget passNreg(txt, onClick) => Padding(
    padding: const EdgeInsets.only(left: 150),
    child: FlatButton(
      child: Text(txt, style: TextStyle(fontSize: 12, color: Colors.blue)),
      onPressed: onClick
    ),
  );

  Widget txtFormField(icnTxt, hntTxt, keyType) => Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 10,),
    child: TextFormField(
      keyboardType: keyType,
      obscureText: hntTxt == 'Password' ? !passwordVisible : false,
      validator: (String value,) => textValidate(hntTxt, value),
      decoration: InputDecoration(
        hintText: hntTxt,
        prefixIcon: Icon(icnTxt, color: Colors.grey),
        suffixIcon: hntTxt == 'Password' ? IconButton(
          icon: Icon(
            passwordVisible 
            ? Icons.visibility
            : Icons.visibility_off
            ),
          onPressed: () {
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
        ):IconButton(
          icon: Icon(
            Icons.check_box_outline_blank),
            onPressed: (){},
            color: Colors.white
            ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  );

 //Login Button 
  Widget login(txt) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: RaisedButton(
      color: Colors.greenAccent,
      child: Text(txt),
      onPressed: () => textValidated(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );

//Functions


  textValidate(hntTxt, value){
    var userInput = '123456';

    switch (hntTxt){
      case 'Phone Number':
        if(value.isEmpty){
          return 'Phone Number should not be empty';
        }

        if(value.length < 11){
          return 'Phone Number should be 11 digits';
        }
      break;

      case 'Password':
        if(value != userInput){
          return ('Incorrect Password');
        }
      break;
    }
  }

  textValidated() {
    if(_formKey.currentState.validate()){
      Navigator.of(context).push(
        CupertinoPageRoute<Null>(
          builder: (
            BuildContext context) => NavBar()));
    }
  }

  registerPage() => Navigator.of(context).push(
    CupertinoPageRoute<Null>(
      builder: (BuildContext context) => Register()  
      )
    );

  forgotPassDialog() { 
   return showDialog(
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
          child: Text('OKAY'),
          onPressed: (){
            Navigator.of(context).push(
              CupertinoPageRoute<Null>(
                builder: (
                  BuildContext context) => ForgetPin()));
            },
          ),
        ],
      ),
    );
  }
}
