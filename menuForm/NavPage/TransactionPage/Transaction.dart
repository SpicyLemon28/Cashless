import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  Transaction({Key key}) : super(key: key);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: Text('Transaction'),
       ),
    );
  }
}