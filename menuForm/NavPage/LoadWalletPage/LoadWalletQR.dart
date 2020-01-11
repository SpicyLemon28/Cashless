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
      appBar: AppBar(
        centerTitle: true,
        title: Text("Scan QR"),
        backgroundColor: Colors.green[900],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.green
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)
              ),
            ),
          ),

          ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  instructions('Scan QR to Load Wallet', TextStyle(fontWeight: FontWeight.normal)),
                  amountNValid('Amount : ', TextStyle(fontWeight: FontWeight.w500)),
                  amountNValid('Valid Until : ', TextStyle(fontWeight: FontWeight.w500)),
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 70, right: 70),
                    child: Image.asset('assets/SampleQR.png'),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 30),
                    child: instructions('• Wait for a SMS confirmation before leaving, Thank You!', TextStyle(fontStyle: FontStyle.italic)),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget instructions(txt, txtStyle) => Padding(
    padding: const EdgeInsets.only(top: 50),
    child: Text(txt, style: txtStyle),
  );

  Widget amountNValid(txt, txtStyle) => Padding(
    padding: const EdgeInsets.only(top: 50, right: 200),
    child: Text(txt, style: txtStyle),
  );

}