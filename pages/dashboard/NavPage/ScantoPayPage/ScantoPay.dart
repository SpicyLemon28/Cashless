import 'package:flutter/material.dart';

class ScantoPay extends StatefulWidget {
  ScantoPay({Key key}) : super(key: key);

  @override
  _ScantoPayState createState() => _ScantoPayState();
}

class _ScantoPayState extends State<ScantoPay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Scan to Pay'),),
    );
  }
}