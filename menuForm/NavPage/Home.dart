import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true, 
        title: Text('SmartPay', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white
      ),
       body: ListView(
         children: <Widget>[
           SafeArea(
             child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
             child: Column(
               children: <Widget>[
                 text('P0.00'),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                    icon(Icons.account_balance_wallet),
                    icon(Icons.shopping_cart), 
                    icon(Icons.attach_money), 
                    icon(Icons.monetization_on), 
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    txtIcon('Load\nWallet'),
                    txtIcon('Scan\nto Pay'), 
                    txtIcon('Send\nMoney'), 
                    txtIcon('Receive\nMoney'), 
                    ],
                  )
                ],
              ),
             ),
           ),
         ],
       )
    );
  }

  Widget text(txt) => Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Text(txt, style: TextStyle(fontSize: 40))
  );

  Widget icon(iconTxt) => Padding(
    padding: const EdgeInsets.only(top: 200),
    child: FlatButton(
      onPressed: (){},
      child: Icon(iconTxt),
    ), 
  );

  Widget txtIcon(textIcon) => Padding(
    padding: const EdgeInsets.only(right: 20, left: 30),
    child: Text(textIcon, style: TextStyle(fontSize: 8),),
    );
}