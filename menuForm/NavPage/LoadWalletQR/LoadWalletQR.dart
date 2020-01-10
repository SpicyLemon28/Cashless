import 'package:flutter/material.dart';

class LoadWalletQR extends StatefulWidget {
  LoadWalletQR({Key key}) : super(key: key);

  @override
  _LoadWalletQRState createState() => _LoadWalletQRState();
}

class _LoadWalletQRState extends State<LoadWalletQR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.green[900], Colors.green[100]]
          ),
        ),
        
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 80, left: 20, right: 20, bottom: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14)
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:100),), 
                    text('Amount:      *Amount Loaded* ', TextStyle(fontWeight: FontWeight.w500)),
                    text('Valid Until:      *Date and Time* ', TextStyle(fontWeight: FontWeight.w500)),
                    text('   *QR CODE*', TextStyle(fontSize: 30,fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ]
          ),
        ),
    );
  }

  Widget txt(txt, txtStyle) => Padding(
    padding: const EdgeInsets.only(left: 50, bottom: 50),
    child: Text(txt, style: txtStyle,),
  );

  Widget text(txt, txtStyle) => Padding(
    padding: const EdgeInsets.only(bottom: 50),
    child: Text(txt, style: txtStyle),
  );

  Widget instructions(txt) => Padding(
    padding: const EdgeInsets.only(),
    child: Text(txt),
  );
}