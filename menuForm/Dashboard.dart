import 'package:flutter/material.dart';

import 'NavBar.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Dashboard', style: TextStyle(fontSize: 30)),
      ),
       bottomNavigationBar: NavBar() ,
    );
  }
}
