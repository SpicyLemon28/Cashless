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
        appBar: AppBar(
          title: Text("Scan QR"),
          backgroundColor: Colors.black,
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
            Container(
              decoration: BoxDecoration(
                color: Colors.black
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(15)
                ),
              ),
            ),

            ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    instructions('Scan QR to Load Wallet', TextStyle(fontWeight: FontWeight.w500)),
                    amountNValid('Amount : ', TextStyle(fontWeight: FontWeight.w600,)),
                    amountNValid('Valid Until : ', TextStyle(fontWeight: FontWeight.w600)),
                    instructions('• Wait for a SMS confirmation before leaving.', TextStyle(fontStyle: FontStyle.italic, fontSize: 11, fontWeight: FontWeight.w500)),
                    
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

  Widget amountNValid(txt, txtStyle) => Padding(
    padding: const EdgeInsets.only(top: 50, right: 200),
    child: Text(txt, style: txtStyle),
  );

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


