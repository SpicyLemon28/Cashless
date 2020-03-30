import 'package:flutter/material.dart';

class LoadWalletQR extends StatefulWidget {
  LoadWalletQR({Key key}) : super(key: key);

  @override
  _LoadWalletQRState createState() => _LoadWalletQRState();
}

class _LoadWalletQRState extends State<LoadWalletQR> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () { navigatePreviousPage(context); },
      child: Scaffold(
        backgroundColor: Color(0xFF2c3e50),
        appBar: AppBar(
          elevation: 0,
          title: Text("QR Code"),
          backgroundColor: Color(0xFF2c3e50),
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () => navigatePreviousPage('/loadWallet')),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => dialog()
            )
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF16a085), Color(0xFF00cc88)]),
                  borderRadius: BorderRadius.circular(15)
                ),
              ),
            ),

            ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    instructions('Scan QR to Load Wallet', TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 50, top: 50),
                      child: amountNValid('Amount : ', TextStyle(color: Colors.white, fontWeight: FontWeight.w600,))),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 50, top: 30),
                      child: amountNValid('Valid Until : ', TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                    instructions('• Wait for a SMS confirmation before leaving.', TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 11, fontWeight: FontWeight.w500)),

                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 70, right: 70),
                      child: Image.asset('assets/SampleQR.png'),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget instructions(txt, txtStyle) => Padding(
    padding: const EdgeInsets.only(left: 50, right: 50, top: 50),
    child: Text(txt, style: txtStyle),
  );

  Widget amountNValid(txt, txtStyle) => Text(txt, style: txtStyle);

  void navigatePreviousPage(navTo) => Navigator.pushReplacementNamed(context, navTo);

  dialog() => showDialog(
    context: context, builder: (BuildContext context) => AlertDialog(
      title: Text('Are you done using the QR code?', style: TextStyle( fontSize: 18, fontStyle: FontStyle.italic)),
      actions: <Widget>[
        FlatButton(
          child: Text('No'),
          onPressed: () =>  Navigator.pop(context)
        ),

        FlatButton(
          child: Text('Yes'),
          onPressed: () => navigatePreviousPage('/dashboard')
        )
      ],
    )
  );
}


