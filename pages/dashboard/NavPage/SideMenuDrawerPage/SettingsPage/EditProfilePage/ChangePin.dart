import 'package:flutter/material.dart';

class ChangePin extends StatefulWidget {
  ChangePin({Key key}) : super(key: key);

  @override
  _ChangePinState createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {

  final _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;
  bool newPasswordVisible, cfmPasswordVisible;

  final _newPassword = TextEditingController();
	final _cfmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
		newPasswordVisible = true;
		cfmPasswordVisible = true;
  }

	void dispose() {
    super.dispose();
		_newPassword.dispose();
		_cfmPassword.dispose();
	}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () { navigatePreviousPage(context); },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF2c3e50),
          title: Text('Change Pin'),
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
                Column(children: <Widget>[
                  Padding(padding: const EdgeInsets.only(top: 200)),
                  text('Create a Strong Pin', TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  text('A pin must contain 6 digits or longer', TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                  textFormField(_newPassword, 'New Password', 'Enter New Password', newPasswordVisible),
                  textFormField(_cfmPassword, 'Confirm Password', 'Re-type Password', cfmPasswordVisible),
                  submitButton('Submit', TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400))
                ],)
              ],)
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

  Widget text(txt, styleText) => Padding(
    padding: const EdgeInsets.only(top: 5, bottom: 20),
    child: Text(txt, style: styleText,),
  );

  Widget textFormField(txtController, lblText, hntText, blnObscure) => Padding(
    padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
    child: TextFormField(
      validator: (value) => textValidation(lblText, value),
      controller: txtController,
      obscureText: blnObscure,
      decoration: InputDecoration(
        labelText: lblText,
        hintText: hntText,
        suffixIcon: _suffixIcon(lblText, blnObscure),
        focusedBorder: greenBorder,
        enabledBorder: greenBorder,
        errorBorder: redBorder,
        focusedErrorBorder: redBorder
      ),
    ),
  );

  Widget submitButton(btnText, styleText) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: ButtonTheme(
        minWidth: 300,
        height: 50,
        child: RaisedButton(
          color: Colors.green,
          child: Text(btnText, style: styleText),
          onPressed: () => _submit(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
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
    if (lblText == 'New Password' || lblText == 'Confirm Password') {
      return IconButton(
        icon: Icon(blnObscure ? Icons.visibility_off : Icons.visibility, color: Colors.grey[300],),
        onPressed: () {
          lblText == 'New Password'
            ? setState(() => newPasswordVisible = !newPasswordVisible)
            : setState(() => cfmPasswordVisible = !cfmPasswordVisible);
        },
      );
    }
  }

  textValidation(lblText, value) {
    if (value.isEmpty) {
      return '$lblText should not be empty';
    } else {
      switch (lblText) {
        case 'New Password':
          return value.length < 6 ? 'Password must be 6 characters or longer' : null;
				case 'Confirm Password':
					return _newPassword.text != value ? 'Password does not match' : null;
      }
    }
  }

  dialog() => showDialog(
    context:  context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      title: Icon(Icons.check_circle, size: 80, color: Colors.green,),
      content: Text('Pin changed successfully!'),
      actions: <Widget>[
        FlatButton(
          child: Text('OKAY'),
          onPressed: () => navigatePage('/editProfile'),
        )
      ],
    )
  );

  void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);

  void navigatePreviousPage(context) => Navigator.pushReplacementNamed(context, '/editProfile');
}