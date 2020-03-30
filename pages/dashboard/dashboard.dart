import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

	var signIn, _phone, _fullname;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userInfo = json.decode(preferences.getString("user"));
		setState(() {
			signIn = userInfo["signIn"];
      _phone = userInfo["phone"];
      _fullname =  userInfo["name"];
		});
  }

  @override
	void initState() {
		super.initState();
		getPref();
    _tabController = TabController(length: 2, vsync: this);
	}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
			onWillPop: () async {
				return Future.value(false);
			},
			child: Scaffold(
				drawer: SideMenuDrawer(_fullname, _phone),
				appBar: AppBar(
          elevation: 0,
					backgroundColor: Color(0xFF2c3e50),
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
          color: Color(0xFF2c3e50),
          shadowColor: Colors.white,
          child: TabBar(
            indicatorColor: Colors.greenAccent,
            controller: _tabController,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home), text: 'Home',),
              Tab(icon: Icon(Icons.receipt), text: 'Transaction',)
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


