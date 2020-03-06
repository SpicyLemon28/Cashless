import 'package:flutter/material.dart';

class ChangeName extends StatefulWidget {
  ChangeName({Key key}) : super(key: key);

  @override
  _ChangeNameState createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {navigatePreviousPage(context);},
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Name'),
        ),
      ),
    );
  }

  void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);

  void navigatePreviousPage(context) => Navigator.pushReplacementNamed(context, '/editProfile');
}