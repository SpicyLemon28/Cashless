import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

import './NavPage/Home.dart';
import './NavPage/TransactionPage/Transaction.dart';
import './NavPage/SideMenuDrawerPage/SideMenuDrawer.dart';


class Dashboard extends StatefulWidget {
  final VoidCallback signOut;
  Dashboard(this.signOut);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin{

  TabController _tabController;

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
    _tabController = TabController(length: 2, vsync: this);
	}

  //int selectedPage = 0;
  /*final pageOptions = [
    Home(),
    Transaction()
  ]; */

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
			onWillPop: () async {
				return Future.value(false);
			},
			child: Scaffold(
				drawer: SideMenuDrawer(),
				appBar: AppBar(
          elevation: 0,
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
        bottomNavigationBar: Material(
          color: Colors.green [900],
          shadowColor: Colors.white,
          child: TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.receipt))
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Home(), 
            Transaction()
          ],
        ),
			)
    );
  }

}


