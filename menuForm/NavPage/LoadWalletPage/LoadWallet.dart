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

  var _formKey = GlobalKey<FormState>();

  Item selectedUser;

  List<Item>loadType = <Item> [
    Item('School Fees'),
    Item('Allowance')
  ];

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
                  Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: DropdownButtonFormField<Item>(
                      validator: (value){
                        if (value == null) {
                          return 'Select Load Type';
                        }
                      },
                      hint: Text('Select Type of Load'),
                      onChanged: (Item value) => setState((){
                        selectedUser = value;
                      }),
                      items: loadType.map((Item loadType) {
                        return DropdownMenuItem<Item>(
                          value: loadType,
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Text(loadType.name)
                            ],
                          ),
                        );
                      }).toList()
                    ),
                  ),
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
  Widget txtFormField(txtLabel, txtHint, styleHint) => Padding(
    padding: const EdgeInsets.only(top: 30),
    child: TextFormField(
      validator: (String value) {
        if(value.isEmpty) {
          return '$txtLabel should not be empty';
        }
      },
      decoration: InputDecoration(
        labelText: txtLabel,
        hintText: txtHint,
        hintStyle: styleHint
      ),
    )
  );

  Widget continueButton(buttonLabel) => Padding(
    padding: const EdgeInsets.only(top: 40),
    child: RaisedButton(
      color: Colors.greenAccent,
      child: Text(buttonLabel),
      onPressed: (){
        if (_formKey.currentState.validate()) navigatePage(LoadWalletQR());
      },
    )
  );

  void navigatePage(navTo) => Navigator.of(context).push(
        CupertinoPageRoute<Null>(
          builder: (BuildContext context) => navTo
		)
	);
}

class Item {
  final String name;
  
  const Item(this.name);
}