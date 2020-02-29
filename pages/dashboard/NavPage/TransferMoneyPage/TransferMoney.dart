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
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer Money'),
        backgroundColor: Colors.green[900],
      ),
      body: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.only(top: 200)),
                      textFormField('Enter Phone Number', TextInputType.phone, false),
                      textFormField('Amount', TextInputType.number, false),
                      textFormField('Pin', TextInputType.number, pinVisible),
                      textFormField('Message (optional)', TextInputType.text, false),
                      continueButton('Continue')
                  ],
                ),
              ],
            ), 
          ],
        ),
      ),
    );
  }

  Widget textFormField(lblText, keyType, blnObscure) => Padding(
    padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
    child: TextFormField(
      keyboardType: keyType,
      validator: (value) => textValidation(lblText, value),
      obscureText: blnObscure,
      decoration: InputDecoration(
        labelText: lblText,
        suffixIcon: _suffixIcon(lblText, blnObscure)
      ),
    ),
  );

  Widget continueButton(buttonText) => Padding(
    padding: const EdgeInsets.only(top: 30),
    child: ButtonTheme(
      minWidth: 300,
      height: 50,
      child: RaisedButton(
        color: Colors.green[900],
        child: Text(buttonText, style: TextStyle(color: Colors.white, fontSize: 18),),
        onPressed: _submit,
      ),
    ),
  );

  void navigatePage(navTo){
    Navigator.pushReplacementNamed(context, navTo);
  }

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

      case 'Enter Phone Number':
        return Icon(Icons.phone_android);

      case 'Pin':
        return IconButton(
          icon:  Icon(blnObscure ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() => pinVisible = !pinVisible);
          },
        );

      case 'Message (optional)':
        return Icon(Icons.message);
      }
    }
  }

  textValidation(lblText, value) {
      switch (lblText) {
        case 'Enter Phone Number':
          return value.length < 11 ? '$lblText must be 11 digits' : null;

        case 'Amount':
          return value.isEmpty ? '$lblText should not be empty' : null;
        
        case 'Pin':
          return value.length < 6 ? '$lblText must be 6 digits or longer' : null;   
      }
    
}
