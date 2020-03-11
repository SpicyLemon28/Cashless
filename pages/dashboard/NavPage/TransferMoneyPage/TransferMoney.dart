import 'package:flutter/material.dart';

class TransferMoney extends StatefulWidget {
  TransferMoney({Key key}) : super(key: key);

  @override
  _TransferMoneyState createState() => _TransferMoneyState();
}



class _TransferMoneyState extends State<TransferMoney> {

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool pinVisible;

  @override
  void initState() {
    super.initState();
    pinVisible = true;
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () { navigatePreviousPage(context);},
      child: Scaffold(
        appBar: AppBar(
          title: Text('Transfer Money'),
          backgroundColor: Color(0xFF2c3e50),
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () => navigatePreviousPage(context),
          ),
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
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: Image.asset("assets/SmartPayIcons/Transfer.png", width: 400, height: 200)
                  ),
                  Container(
                    height: 460,
                    decoration: BoxDecoration(
                      color: Color(0xFF2c3e50),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: textFormField('Phone Number', 'Enter Phone Number', TextInputType.phone, false),
                        ),
                        textFormField('Amount', 'Enter desired amount', TextInputType.number, false),
                        textFormField('Message (optional)', null, TextInputType.text, false),
                        continueButton('Continue') 
                      ],
                    ),
                  ),
                ],
              ), 
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

  Widget textFormField(lblText, hntText, keyType, blnObscure) => Padding(
    padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
    child: TextFormField(
      autofocus: true,
      style: TextStyle(color: Colors.white),
      keyboardType: keyType,
      validator: (value) => textValidation(lblText, value),
      obscureText: blnObscure,
      decoration: InputDecoration(
        labelText: lblText, labelStyle: TextStyle(color: Colors.grey [300]),
        hintText: hntText, hintStyle: TextStyle(color: Colors.grey [300], fontSize: 14),
        suffixIcon: _suffixIcon(lblText, blnObscure),
        enabledBorder: greenBorder,
        focusedBorder: greenBorder,
        errorBorder: redBorder,
        focusedErrorBorder: redBorder
      ),
    ),
  );

  Widget continueButton(buttonText) => Padding(
    padding: const EdgeInsets.only(top: 30),
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

  void navigatePage(navTo){
    Navigator.pushReplacementNamed(context, navTo);
  }

  void navigatePreviousPage(context) => Navigator.pushReplacementNamed(context, '/dashboard');

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      navigatePage('/transferMoneyDetails');
    } else {
      setState(() => _autoValidate = true);
    }
  }
  _suffixIcon(lblText, blnObscure){
    switch (lblText) {

      case 'Phone Number':
        return Icon(Icons.phone_android, color: Colors.grey[300],);

      case 'Message (optional)':
        return Icon(Icons.message, color: Colors.grey[300],);
      }
    }
  }

  textValidation(lblText, value) {
      switch (lblText) {
        case 'Phone Number':
          return value.length < 11 ? '$lblText must be 11 digits' : null;

        case 'Amount':
          return value.isEmpty ? '$lblText should not be empty' : null;
        
        case 'Pin':
          return value.length < 6 ? '$lblText must be 6 digits or longer' : null;   
      }
    
}
