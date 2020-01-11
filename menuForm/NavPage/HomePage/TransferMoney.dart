import 'package:flutter/material.dart';

class TransferMoney extends StatefulWidget {
  TransferMoney({Key key}) : super(key: key);

  @override
  _TransferMoneyState createState() => _TransferMoneyState();
}

class _TransferMoneyState extends State<TransferMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Transfer Money'),
      ),
    );
  }
}