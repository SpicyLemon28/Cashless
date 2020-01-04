import 'package:flutter/material.dart';

class LoadWallet extends StatefulWidget {
  LoadWallet({Key key}) : super(key: key);

  @override
  _LoadWalletState createState() => _LoadWalletState();
}

class _LoadWalletState extends State<LoadWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: Text('Load Wallet'),
       ),
    );
  }
}