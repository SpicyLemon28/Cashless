import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

import './NavPage/Home.dart';
import './NavPage/LoadWalletPage/LoadWallet.dart';
import './NavPage/TransactionPage/Transaction.dart';
import './NavPage/SideMenuDrawerPage/SideMenuDrawer.dart';


class Dashboard extends StatefulWidget {
  final VoidCallback signOut;
  Dashboard(this.signOut);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
	signOut() {
		setState(() { widget.signOut(); });
	}

	var signIn;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() => signIn = preferences.getInt("signIn") );
  } 

  @override
	void initState() {
		super.initState();
		getPref();
	} 

  int selectedPage = 0;
  final pageOptions = [
    Home(),
    LoadWallet(),
    Transaction()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        centerTitle: true,
        title: Text('SmartPay', style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.lock_open),
            onPressed: () => signOut(),
          )
        ],
      ),
      body: pageOptions[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPage,
        onTap: (int index) => setState((){
          selectedPage = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('Load Wallet')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            title: Text('Transaction')
          )
        ],
      ),
    );
  }

}

/*class NaviBar extends StatefulWidget {
  NaviBar({Key key}) : super(key: key);

  @override
  _NaviBarState createState() => _NaviBarState();
}

class _NaviBarState extends State<NaviBar> {

  Color bkgColor = Colors.white;

  List<NavItem> items = [
    NavItem(
      Icon(Icons.menu),
      Text('Menu',style: TextStyle(fontSize: 11)),
      Colors.greenAccent
    ),
    NavItem(
      Icon(Icons.home),
      Text('Home',style: TextStyle(fontSize: 11)),
      Colors.lightGreen
    ),
    NavItem(
      Icon(Icons.add),
      Text('Load Wallet',style: TextStyle(fontSize: 11)),
      Colors.green[700]
    ),
    NavItem(
      Icon(Icons.receipt),
      Text('Transaction',style: TextStyle(fontSize: 11)),
      Colors.blueGrey
      ),
  ];

  Widget _buildItem(NavItem item, bool isSelected){
      return AnimatedContainer(
        duration: Duration(milliseconds: 200) ,
        height: double.maxFinite,
        width: isSelected ? 140 : 50,
        padding: isSelected ?
        EdgeInsets.only(left: 12, right: 12) : null,
        decoration: isSelected ? BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.all(Radius.circular(40))
        ) : null,
          child: ListView(
           scrollDirection: Axis.horizontal,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconTheme(
                data: IconThemeData(
                size: 24,
                color: isSelected ? bkgColor : Colors.grey[600]
                ),
                child: item.icon,
              ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: isSelected ?
                  DefaultTextStyle.merge(
                  style: TextStyle(
                  color: bkgColor,
                ),
                  child: item.title
                )
                  : Container(),
            )
              ],
            ),
          ],
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: const EdgeInsets.only(left: 8, top: 4, right: 8),
        height: 56,
        decoration: BoxDecoration(
          color: bkgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
            ),
          ]
        ),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.map((item) {
            var itemIndex = items.indexOf(item);

            return GestureDetector(
              onTap: () => selectedPage(Home()),
              child: _buildItem(item, selectedPage == itemIndex),
            );
          }).toList(),
        ),
    );
  }

  void selectedPage(navTo) => Navigator.of(context).push(
        CupertinoPageRoute<Null>(
          builder: (BuildContext context) => navTo
    )
  );

}

class NavItem {
  final Icon icon;
  final Text title;
  final Color color;

  NavItem(this.icon, this.title, this.color);
} */

