import 'package:flutter/material.dart';

class ScantoPay extends StatefulWidget {
  ScantoPay({Key key}) : super(key: key);

  @override
  _ScantoPayState createState() => _ScantoPayState();
}

class _ScantoPayState extends State<ScantoPay> {

  var _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () { navigatePreviousPage(context);},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF2c3e50),
          title: Text('Scan To Pay'),
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
              ListView(children: <Widget>[
                textFormField('Enter amount to pay'),
                submitBtn('Submit')
              ],
              )
            ],
          ),
        ),
      ),
    );
  }

  var redBorder = outlineInputBorder(Colors.redAccent),
      greenBorder = outlineInputBorder(Colors.green);

  static outlineInputBorder(color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: color, width: 2)
  );


   Widget textFormField(hntText) => Padding(
     padding: const EdgeInsets.only(left: 30, right: 30, top: 250),
     child: TextFormField(
       keyboardType: TextInputType.number,
       validator: (value) => textValidation(hntText, value),
       decoration: InputDecoration(
         hintText: hntText, hintStyle: TextStyle(fontSize: 14),
         enabledBorder: greenBorder,
         focusedBorder: greenBorder,
         errorBorder: redBorder,
         focusedErrorBorder: redBorder,
         errorStyle: TextStyle(fontSize: 14, color: Colors.redAccent)
       ),
     ),
   );

   Widget submitBtn(buttonText) => Padding(
    padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
    child: ButtonTheme(
      minWidth: 300,
      height: 50,
      child: RaisedButton(
        elevation: 5,
        color: Colors.green,
        child: Text(buttonText, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
        onPressed: _submit,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    ),
  );

   void _submit() {
    final form = _formKey.currentState;
    if(form.validate()) {
      navigatePage('/payQR');
    } else {
      setState(() => _autoValidate = true);
    }
  }

   textValidation(hntText, value) {
    if (hntText == 'Enter amount to pay') {
      return value.isEmpty ? '*Field should not be empty' : null;
    }
  }
  
   void navigatePage(navTo) => Navigator.pushReplacementNamed(context, navTo);
  
   void navigatePreviousPage(context) => Navigator.pushReplacementNamed(context, '/');
}
