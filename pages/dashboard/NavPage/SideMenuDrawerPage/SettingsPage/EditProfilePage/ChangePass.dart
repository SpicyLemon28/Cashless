import 'package:flutter/material.dart';

class ChangePass extends StatefulWidget {
  ChangePass({Key key}) : super(key: key);

  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
   bool crntPasswordVisible, newPasswordVisible, cfmPasswordVisible;

  @override
  void initState() {
    super.initState();
    crntPasswordVisible = true;
		newPasswordVisible = true;
		cfmPasswordVisible = true;
  }

  final _crntPassword = TextEditingController();
  final _newPassword = TextEditingController();
	final _cfmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() {navigatePreviousPage(context);},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green [900],
          title: Text('Change Password'),
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () => navigatePreviousPage('/editProfile'),
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
                  Column(
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.only(top: 200)),
                      text('Create a Strong Password', TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                      text('A Password should be 6 characters or longer', TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                      Padding(padding: const EdgeInsets.only(top: 20)),
                      textFormField(_crntPassword, 'Current Password', crntPasswordVisible),
                      textFormField(_newPassword, 'New Password', newPasswordVisible),
                      textFormField(_cfmPassword, 'Re-type New Password', cfmPasswordVisible),
                      saveButton('Save Changes')
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget text(txt, styleText) => Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Text(txt, style: styleText,),
  );


  Widget textFormField(txtController, lblText, blnObscure) => Padding(
    padding: const EdgeInsets.only(left: 30, right: 30, bottom : 20),
    child: TextFormField(
      controller: txtController,
      validator: (value) => textValidation(lblText, value),
      obscureText: blnObscure,
      decoration: InputDecoration(
        labelText: lblText, labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        suffixIcon: _suffixIcon(lblText, blnObscure),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        )
      ),
    ),
  );

  Widget saveButton(buttonText) => Padding(
    padding: const EdgeInsets.only(top: 30),
    child: ButtonTheme(
      minWidth: 320,
      height: 50,
      child: RaisedButton(
        elevation: 5,
        color: Colors.green [900],
        child: Text(buttonText, style: TextStyle(color: Colors.white, fontSize: 16),),
        onPressed: _submit,
      ),
    ),
  );

  void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);

  void navigatePreviousPage(navTo){
    Navigator.popAndPushNamed(context, navTo);
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      dialog();
    } else {
      setState(() => _autoValidate = true);
    }
  }

  _suffixIcon(lblText, blnObscure) {
    
    switch (lblText) {
      case 'Current Password':
      return IconButton(
        icon: Icon(blnObscure ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => crntPasswordVisible = !crntPasswordVisible));

      case 'New Password':
      return IconButton(
        icon: Icon(blnObscure ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => newPasswordVisible = !newPasswordVisible));

      case 'Re-type New Password':
      return IconButton(
        icon: Icon(blnObscure ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => cfmPasswordVisible = !cfmPasswordVisible));  
    }
  }

  textValidation(lblText, value) {

    
  

    if (value.isEmpty) {return '$lblText should not be empty';}
    if (value.length < 6) {return 'Must be 6 characters or longer';}
    else{
      switch(lblText) {
        
        case 'New Password':
          return _crntPassword.text == value ? 'Should not match with the current password': null;
        
        case 'Re-type New Password':
          return _newPassword.text != value ? 'Password does not match' : null;
      }
    }
  }

  dialog() => showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('Password has been changed successfully!'),
      actions: <Widget>[
        FlatButton(
              child: Text('OKAY'),
              onPressed: () => Navigator.pop(context),
            )
      ],
    )
  );
}