import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';


class LoadWallet extends StatefulWidget {
  LoadWallet({Key key}) : super(key: key);

  @override
  _LoadWalletState createState() => _LoadWalletState();
}

class _LoadWalletState extends State<LoadWallet> {

  bool _autoValidate = false;

  var _formKey = GlobalKey<FormState>();

  int _selectedLoadType = 0;

  List<DropdownMenuItem<int>> loadTypeList = [];

  void loadWalletList() {
    loadTypeList = [];

    loadTypeList.add(DropdownMenuItem(
      child: Text('School Fees', style: TextStyle(color: Colors.grey)),
      value: 0,

    ));

    loadTypeList.add(DropdownMenuItem(
      child: Text('Allowance', style: TextStyle(color: Colors.grey)),
      value: 1,
    ));
  }

  @override
  Widget build(BuildContext context) {

    loadWalletList();
    return WillPopScope(
      onWillPop: () {navigatePreviousPage(context);},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF2c3e50),
          title: Text('Load Wallet'),
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
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 50),
                      child: Image.asset("assets/SmartPayIcons/Load.png", width: 400, height: 200)
                    ),
                    Container(
                      height: 420,
                      decoration: BoxDecoration(
                        color: Color(0xFF2c3e50),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                      ),
                      child: Column(
                        children: <Widget>[
                          textFormField('Amount', 'Enter amount to load to your account'),
                          loadTypeButton('School Fees'),
                          continueButton('Continue')
                        ],
                      ),
                    )
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

  Widget textFormField(lblText, hntText) => Padding(
    padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
    child: TextFormField(
      autofocus: true,
      style: TextStyle(color: Colors.white),
      validator: (value) => textValidation(lblText, value),
      decoration: InputDecoration(
        labelText: lblText, hintText: hntText,
        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        hintStyle: TextStyle(color: Colors.grey [300], fontSize: 12),
        enabledBorder: greenBorder,
        focusedBorder: greenBorder,
        errorBorder: redBorder,
        focusedErrorBorder: redBorder
      ),
    ),
  );

  Widget loadTypeButton(lblText) => Padding(
    padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
    child: DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: 'Load Wallet For',
        labelStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        enabledBorder: greenBorder,
        focusedBorder: greenBorder
      ),
      items: loadTypeList,
      value: _selectedLoadType,
      validator: (value) => textValidation(lblText, value),
      onChanged: (value) {
        setState(()=> _selectedLoadType = value);
      },

    )
  );

  Widget continueButton(buttonText) => Padding(
    padding: const EdgeInsets.only(top: 80),
    child: ButtonTheme(
      minWidth: 300,
      height: 50,
      child: RaisedButton(
        color: Colors.green,
        child: Text(buttonText, style: TextStyle(color: Colors.white, fontSize: 18),),
        onPressed: _submit,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    ),
  );

  void _submit() {
    final form = _formKey.currentState;
    if(form.validate()) {
      navigatePage('/loadWalletQR');
    } else {
      setState(() => _autoValidate = true);
    }
  }

  void navigatePage(navTo){
    Navigator.pushReplacementNamed(context, navTo);
  }

  void navigatePreviousPage(context) => Navigator.pushReplacementNamed(context, '/');

  textValidation(lblText, value) {
    if (lblText == 'Amount') {
      return value.isEmpty ? '$lblText should not be empty' : null;
    }

    if (lblText == 'Load Wallet For'){
      return value == null ? '$lblText should not be empty' : null;
    }
  }
}
