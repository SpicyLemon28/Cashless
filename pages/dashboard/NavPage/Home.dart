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
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                    color: Color(0xFF2c3e50)
                  ),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              card('Current Balance', TextStyle(color: Colors.white, fontSize: 16)),
                              card('PHP', TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
                       ),

                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: card('₱123,456', TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400)),
                        ),

                        Container(
                          child: Row(
                            children: <Widget>[
                              Padding(
                               padding: const EdgeInsets.only(top: 46, left: 30),
                                child: card('09123456789', TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300)),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 130, top: 10),
                                child: loadIcon(Icons.add),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 190,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [Color(0xFF16a085), Color(0xFF00cc88)] 
                    )
                  ),
                ),
              ),
            ],
          ),

          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 30),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                leading: IconButton(
                  icon: Image.asset('assets/FunctionIcons/ScantoPay.png'), 
                  onPressed: null,
                  iconSize: 80),
                onTap: () => navigatePage('/scantoPay'),
                title: Text('Scan to Pay', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            )
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                leading: IconButton(
                  icon: Image.asset('assets/FunctionIcons/TransferMoney.png'), 
                  onPressed: null,
                  iconSize: 80),
                onTap: () => navigatePage('/transferMoney'),
                title: Text('Transfer Money', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            )
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                leading: IconButton(
                  icon: Image.asset('assets/FunctionIcons/ReceiveMoney.png'), 
                  onPressed: null,
                  iconSize: 80),
                onTap: () => navigatePage('/receiveMoney'),
                title: Text('Receive Money', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            )
          )
          ]
        ),
      ),
    );
  }

  Widget card(txt, styleText) => Text(txt, style: styleText);

  Widget loadIcon(iconBtn) => FloatingActionButton(
    tooltip: 'Load Wallet',
    elevation: 0,
    backgroundColor: Color(0xFF006644),
    child: Icon(iconBtn),
    onPressed: () => navigatePage('/loadWallet'),
  );

  Widget iconBtn(iconTxt) => Card(
    child: ListTile(
      title: iconTxt,
    ),
  );


  void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);
}
  

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
         decoration: BoxDecoration(
           gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.greenAccent]
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
                   color: Colors.greenAccent,
                   borderRadius: BorderRadius.circular(15)
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
                        child: text('Promos for You', TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700)),
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
  } */

  

   
