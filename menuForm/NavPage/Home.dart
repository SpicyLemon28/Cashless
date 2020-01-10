import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'LoadWallet.dart';
import './HomePage/ScantoPay.dart';
import './HomePage/TransferMoney.dart';
import './HomePage/ReceiveMoney.dart';


class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.green[900], Colors.white]
              )
            ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              children: <Widget>[
                appName('SmartPay', TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
                text('BALANCE', TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal)),
                text('₱ 0.00', TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600)),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 160),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14)
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 180),
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: RaisedButton(
                              padding: const EdgeInsets.all(15),
                              color: Colors.white70,
                              child: Image.asset('assets/icons/wallet.png'),
                              shape: CircleBorder(
                                side: BorderSide.none
                              ),
                              onPressed: () => setState((){
                                Navigator.of(context).push(
                                  CupertinoPageRoute<Null>(
                                    builder: (BuildContext context) => LoadWallet()));
                              }),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(),
                            child: RaisedButton(
                              padding: const EdgeInsets.all(15),
                              color: Colors.white70,
                              child: Image.asset('assets/icons/wallet.png'),
                              shape: CircleBorder(
                                side: BorderSide.none
                              ),
                              onPressed: () => setState((){
                                Navigator.of(context).push(
                                  CupertinoPageRoute<Null>(
                                    builder: (BuildContext context) => ScantoPay()));
                              }),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            iconTxt('Load Wallet'),
                            iconTxt('Scan to Pay'),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                            padding: const EdgeInsets.only(),
                            child: RaisedButton(
                              padding: const EdgeInsets.all(15),
                              color: Colors.white70,
                              child: Image.asset('assets/icons/wallet.png'),
                              shape: CircleBorder(
                                side: BorderSide.none
                              ),
                              onPressed: () => setState((){
                                Navigator.of(context).push(
                                  CupertinoPageRoute<Null>(
                                    builder: (BuildContext context) => TransferMoney()));
                              }),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(),
                            child: RaisedButton(
                              padding: const EdgeInsets.all(15),
                              color: Colors.white70,
                              child: Image.asset('assets/icons/wallet.png'),
                              shape: CircleBorder(
                                side: BorderSide.none
                              ),
                              onPressed: () => setState((){
                                Navigator.of(context).push(
                                  CupertinoPageRoute<Null>(
                                    builder: (BuildContext context) => ReceiveMoney()));
                              }),
                            ),
                          ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            iconTxt('Transfer\n Money'),
                            iconTxt('Receive\n Money'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, right: 240),
                        child: Text('Promos for You', 
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.green[900]
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget appName(txt, txtStyle) => Padding(
    padding: const EdgeInsets.only(top:40, bottom: 30),
    child: Text(txt, style: txtStyle,)
  ); 

  Widget text(txt, txtStyle) => Padding(
    padding: const EdgeInsets.only(),
    child: Text(txt, style: txtStyle)
  );

  Widget iconTxt(txtIcon) => Text(txtIcon);
} 
