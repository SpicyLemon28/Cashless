import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

import './LoadWalletQR.dart';

class LoadWallet extends StatefulWidget {
  LoadWallet({Key key}) : super(key: key);

  @override
  _LoadWalletState createState() => _LoadWalletState();
}

class _LoadWalletState extends State<LoadWallet> {

  bool _autoValidate = false;

  var _formKey = GlobalKey<FormState>();

  int _selectedLoadType = 0;

  List<DropdownMenuItem<int>> loadTypeList = [];

  void loadWalletList() {
    loadTypeList = [];

    loadTypeList.add(DropdownMenuItem(
      child: Text('School Fees'),
      value: 0,
    ));

    loadTypeList.add(DropdownMenuItem(
      child: Text('Allowance'),
      value: 1,
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadWalletList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('Load Wallet')
      ),
      body: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    textFormField('Amount', 'Enter amount to load to your account'),
                    loadTypeButton('School Fees'),
                    continueButton('Continue')
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget textFormField(lblText, hntText) => Padding(
    padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
    child: TextFormField(
      validator: (value) => textValidation(lblText, value),
      decoration: InputDecoration(
        labelText: lblText, hintText: hntText,
        hintStyle: TextStyle(fontSize: 12)
      ),
    ),
  );

  Widget loadTypeButton(lblText) => Padding(
    padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
    child: DropdownButtonFormField(
      items: loadTypeList,
      value: _selectedLoadType,
      validator: (value) => textValidation(lblText, value),
      onChanged: (value) {
        setState(()=> _selectedLoadType = value);
      },
      decoration: InputDecoration(
        labelText: 'Load Wallet For',
        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)
      ),
    )
  );

  Widget continueButton(buttonText) => Padding(
    padding: const EdgeInsets.only(top: 434),
    child: ButtonTheme(
      minWidth: 400,
      height: 50,
      child: RaisedButton(
        color: Colors.green[900],
        child: Text(buttonText, style: TextStyle(color: Colors.white, fontSize: 18),),
        onPressed: _submit,
      ),
    ),
  );

  void _submit() {
    final form = _formKey.currentState;
    if(form.validate()) {
      navigatePage('/loadWalletQR');
    } else {
      setState(() => _autoValidate = true);
    }
  }

  void navigatePage(navTo){
    Navigator.pushReplacementNamed(context, navTo);
  }
  
  textValidation(lblText, value) {
    if (lblText == 'Amount') {
      return value.isEmpty ? '$lblText should not be empty' : null;
    }

    if (lblText == 'Load Wallet For'){
      return value == null ? '$lblText should not be empty' : null;
    }
  }
}