import 'package:flutter/material.dart';

class ChangeName extends StatefulWidget {
  ChangeName({Key key}) : super(key: key);

  @override
  _ChangeNameState createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {navigatePreviousPage(context);},
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Edit Name'),
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () {navigatePreviousPage(context);}),
        ),
        body: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(top: 200, left: 30),
                    child: text('Current Name: Myco Paul John Perez')),
                  textFormField('New Name', 'Enter Full Name'),
                  saveBtn('Save Changes')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  var redBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.redAccent, width: 2)
        );

  var greenBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.greenAccent, width: 2)
        );      

  Widget text(listTxt) => Text(listTxt, style: TextStyle(color: Colors.grey[300], fontSize: 13, fontWeight: FontWeight.w500));

  Widget textFormField(lblText,hntText) => Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
    child: TextFormField(
      style: TextStyle(color: Colors.white),
      validator: (value) => textValidation(hntText, value),
      decoration: InputDecoration(
        labelText: lblText, labelStyle: TextStyle(color: Colors.grey[300], fontSize: 15, fontWeight: FontWeight.w500),
        hintText: hntText, hintStyle: TextStyle(color: Colors.grey[300], fontSize: 15),
        enabledBorder: greenBorder,
        focusedBorder: greenBorder,
        errorBorder: redBorder,
        focusedErrorBorder: redBorder
      ),
    ),
  );

  Widget saveBtn(btnText) => Padding(
    padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
    child: ButtonTheme(
      minWidth: 300,
      height: 50,
      child: RaisedButton(
        color: Colors.green,
        child: Text(btnText, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
        onPressed: _submit,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    ),
  );

  void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);

  void navigatePreviousPage(context) => Navigator.pushReplacementNamed(context, '/editProfile');

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      dialog();
    } else {
      setState(() => _autoValidate = true);
    }
  }

  dialog() => showDialog(
    context: context, builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: IconButton(icon: Icon(Icons.check_circle_outline),
        disabledColor: Colors.green,
        iconSize: 60,
        onPressed: null
      ),
      content: Text('Name has been changed successfully!',style: TextStyle(fontSize: 16)),
      actions: <Widget>[
        FlatButton(
          child: Text('OKAY'),
          onPressed: () => navigatePage('/editProfile'),
        )
      ],
    )
  );

  textValidation(hntText, value){
    if (value.isEmpty){
      return '$hntText should not be empty';
    }
    if(!value.contains(' ')) {
      return 'Invalid Full Name';
    }
  }
}