import 'package:flutter/material.dart';

class ChangeName extends StatefulWidget {
  ChangeName({Key key}) : super(key: key);

  @override
  _ChangeNameState createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {navigatePreviousPage(context);},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: Text('Edit Name'),
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () {navigatePreviousPage(context);}),
        ),
        body: Form(
          key: _formKey,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(top: 200, left: 10, right: 10),
                    child: text('Current Name: Myco Paul John Perez')),
                  
                  textFormField('New Name:'),
                  saveBtn('Save Changes')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget text(listTxt) => Card(
    child: ListTile(
      title: Text(listTxt, style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500),),
    ),
  );

  Widget textFormField(hntText) => Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
    child: TextFormField(
      decoration: InputDecoration(
        hintText: hntText, hintStyle: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500)
      ),
    ),
  );

  Widget saveBtn(btnText) => Padding(
    padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
    child: ButtonTheme(
      minWidth: 300,
      height: 50,
      child: RaisedButton(
        elevation: 3,
        color: Colors.green [900],
        child: Text(btnText, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
        onPressed: () => dialog(),
      ),
    ),
  );

  void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);

  void navigatePreviousPage(context) => Navigator.pushReplacementNamed(context, '/editProfile');

  dialog() => showDialog(
    context: context, builder: (BuildContext context) => AlertDialog(
      title: IconButton(icon: Icon(Icons.check_circle_outline),
        disabledColor: Colors.green,
        iconSize: 60,
        onPressed: null
      ),
      content: Text('Name has been changed successfully!' ,style: TextStyle(fontSize: 16)),
      actions: <Widget>[
        FlatButton(
          child: Text('OKAY'),
          onPressed: () => navigatePage('/editProfile'),
        )
      ],
    )
  );
}