import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

import './LoadWalletQR/LoadWalletQR.dart';

class LoadWallet extends StatefulWidget {
  LoadWallet({Key key}) : super(key: key);

  @override
  _LoadWalletState createState() => _LoadWalletState();
}

class _LoadWalletState extends State<LoadWallet> {

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Load Wallet'),
        backgroundColor: Colors.green[900],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: <Widget>[
                  loadType('Load Type'),
                  txtFormField('Enter Amount', 'Enter amount to load your wallet', TextStyle(fontSize: 14)),
                  continueButton('Continue')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  //Cant Show the load type in the field
  Widget loadType(txtLabel) => Padding(
    padding: const EdgeInsets.only(top: 200),
    child: DropdownButtonFormField<String>(
      validator: (String value) => formValidation(txtLabel, value),
      decoration: InputDecoration(
        labelText: txtLabel
      ),
      items: <String>['School Fees','Allowance'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (_){}, 
    )
  );

  Widget txtFormField(txtLabel, txtHint, styleHint) => Padding(
    padding: const EdgeInsets.only(top: 30),
    child: TextFormField(
      validator: (String value) => formValidation(txtLabel, value),
      decoration: InputDecoration(
        labelText: txtLabel,
        hintText: txtHint,
        hintStyle: styleHint
      ),
    )
  );

  Widget continueButton(buttonLabel) => Padding(
    padding: const EdgeInsets.only(top: 20),
    child: RaisedButton(
      color: Colors.greenAccent,
      child: Text(buttonLabel),
      onPressed: (){
        if (_formKey.currentState.validate()) navigatePage(LoadWalletQR());
      },
    )
  );

  formValidation(txtLabel, value) {
    
    if(value.isEmpty){
      return '$txtLabel should not be empty';
    }
  }

  void navigatePage(navTo) => Navigator.of(context).push(
        CupertinoPageRoute<Null>(
          builder: (BuildContext context) => navTo
		)
	);
}