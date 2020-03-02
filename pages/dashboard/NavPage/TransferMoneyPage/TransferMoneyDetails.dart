import 'package:flutter/material.dart';

class TransferMoneyDetails extends StatefulWidget {
  TransferMoneyDetails({Key key}) : super(key: key);

  @override
  _TransferMoneyDetailsState createState() => _TransferMoneyDetailsState();
}

class _TransferMoneyDetailsState extends State<TransferMoneyDetails> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){ navigatePreviousPage(context);},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: Text('Confirmation'),
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () => navigatePreviousPage(context),
          ),
        ),
      body: Column(
        children: <Widget>[
          text('Phone Number of money transfered'),
          Padding(
            padding: const EdgeInsets.only(right: 140),
            child: text('Transfer Amount: '),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 200),
            child: text('Message: '),
          ),
          transferButton('Transfer')
        ],
      )
      ),
    );
  }

  Widget text(txt) => Padding(
    padding: const EdgeInsets.only(top: 50),
    child: Text(txt, style: TextStyle(color: Colors.grey [600], fontWeight: FontWeight.w500))
  );

  Widget transferButton(buttonText) => Padding(
    padding: const EdgeInsets.only(top: 452.5),
    child: ButtonTheme(
      minWidth: 400,
      height: 50,
      child: RaisedButton(
        color: Colors.green[900],
        child: Text(buttonText, style: TextStyle(color: Colors.white, fontSize: 18),),
        onPressed: () => print('SENT!'),
      ),
    ),
  );

  void navigatePreviousPage(context) => Navigator.pushReplacementNamed(context, '/transferMoney');
}