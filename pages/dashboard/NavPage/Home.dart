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
                 Padding(
                   padding: const EdgeInsets.only(top: 20),
                   child: text('BALANCE', TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                 ),
                 text('₱ 0.00', TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600)),
               ],
             ),

             Padding(
               padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
               child: Container(
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(14)
                 ),
               ),
             ),

             Padding(
               padding: const EdgeInsets.only(top: 120),
               child: ListView(
                 children: <Widget>[
                   Column(
                     children: <Widget>[
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: <Widget>[
                           Padding(
                             padding: const EdgeInsets.only(),
                             child: IconButton(
                               iconSize: 75,
                               icon: Image.asset('assets/FunctionIcons/LoadWallet.png'),
                               onPressed: () => navigatePage('/loadWallet')
                             ),
                           ),

                           Padding(
                            padding: const EdgeInsets.only(),
                            child: IconButton(
                              iconSize: 75,
                              icon: Image.asset('assets/FunctionIcons/ScantoPay.png'),
                              onPressed: () => navigatePage('/scantoPay')
                            )
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
                               child: IconButton(
                                 iconSize: 90,
                                 icon: Image.asset('assets/FunctionIcons/TransferMoney.png'),
                                 onPressed: () => navigatePage('/transferMoney'),
                               )
                             ),

                             Padding(
                               padding: const EdgeInsets.only(),
                               child: IconButton(
                                 iconSize: 90,
                                 icon: Image.asset('assets/FunctionIcons/ReceiveMoney.png'),
                                 onPressed: () => navigatePage('/receiveMoney'),
                               )
                             ),
                           ],
                         ),
                       ),

                       Padding(
                        padding: const EdgeInsets.only(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            iconTxt('Transfer\n Money'),
                            iconTxt('Receive\n Money'),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 40, right: 190),
                        child: text('Promos for You', TextStyle(color: Colors.green[900], fontSize: 15, fontWeight: FontWeight.w700)),
                      )
                      
                     ],
                   )
                 ],
               ),
             )
           ],
         ),
       )
    );
  }

  Widget text(txt, styleText) => Padding(
    padding: const EdgeInsets.only(),
    child: Text(txt, style: styleText)
  );

   Widget iconTxt(txtIcon) => Text(txtIcon, style: TextStyle(color: Colors.green [900], fontWeight: FontWeight.w500),);

   void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);
}