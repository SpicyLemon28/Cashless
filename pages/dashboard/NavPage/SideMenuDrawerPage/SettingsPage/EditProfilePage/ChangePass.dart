import 'package:flutter/material.dart';

class ChangePass extends StatefulWidget {
  ChangePass({Key key}) : super(key: key);

  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {

  final _formKey = GlobalKey<FormState>();
	final scaffoldKey = GlobalKey<ScaffoldState>();

  final _newPassword = TextEditingController();
	final _cfmPassword = TextEditingController();

  //bool _isLoading = false;
  bool _autoValidate = false;

  bool newPasswordVisible, cfmPasswordVisible;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () { navigatePreviousPage(context); },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF2c3e50),
          title: Text('Change Password'),
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () => navigatePreviousPage(context),),
        ),
        key: scaffoldKey,
        body: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ListView(children: <Widget>[
                Column(children: <Widget>[
                  Padding(padding: const EdgeInsets.only(top: 200)),
                  text('Change your Password', TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  text('A password should contain 6 characters or longer', TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
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
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
    child: Text(txt, style: styleText),
  );

  Widget textFormField(txtController, lblText, hntText, blnObscure) => Padding(
    padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
    child: TextFormField(
      style: TextStyle(color: Colors.white),
			controller: txtController,
      validator: (value) => textValidation(lblText, value),
      obscureText: blnObscure,
      decoration: InputDecoration(
        labelText: lblText,
        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        hintText: hntText,
        hintStyle: TextStyle(color: Colors.grey[300], fontSize: 15),
        suffixIcon: _suffixIcon(lblText, blnObscure),
        focusedBorder: greenBorder,
        enabledBorder: greenBorder,
        errorBorder: redBorder,
        focusedErrorBorder: redBorder
      ),
    ),
  );

  Widget submitButton(buttonText, styleText) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: ButtonTheme(
        minWidth: 300,
        height: 50,
        child: RaisedButton(
          color: Colors.green,
          child: Text(buttonText, style: styleText),
          onPressed: null,/*() => _submit(),*/
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
          ),	
    );
  }

  /*Widget submitButton(buttonText, styleText) {
		return Padding(
		  padding: const EdgeInsets.only(top: 20),
		  child: _isLoading
      ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)
        )
    	: Padding(
		  			padding: const EdgeInsets.only(top: 30),
		  		  child: ButtonTheme(
              minWidth: 300,
              height: 50,
              child: RaisedButton(
                color: Colors.green,
                child: Text(buttonText, style: styleText,),
                onPressed: () => _submit(),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
            ),	
		  		),
      );
	} */

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

  void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);

  void navigatePreviousPage(context) => Navigator.pushReplacementNamed(context, '/editProfile');

  /*void _submit() {
		final form = _formKey.currentState;
		if (form.validate()) {
			setState(() => _isLoading = true);
			//_resetPassword(); 
		} else {
			setState(() => _autoValidate = true);
		}*/
  
  /*void _resetPassword() async {
		SharedPreferences preferences = await SharedPreferences.getInstance();
		setState(() {
			_phone = preferences.getString("phone");
			_token = preferences.getString("token");
		});

		var data = {
			"token"       : _token,
			"newPassword" : Password.hash(_newPassword.text, PBKDF2()),
			"cfmPassword" : Password.hash(_cfmPassword.text, PBKDF2())
		};

    http.Response response = await http.post(RESET_PASSWORD, body: data);
    final responseData = json.decode(response.body);

		setState(() => _isLoading = false);
    if (response.statusCode == 200) {
			int result = responseData['result'];
			if (result == 3) {
				result = await users.resetPassword(_phone, _newPassword.text);
				if (result == 1) {
					_formKey.currentState.reset();
					Navigator.pushReplacementNamed(context, '/login');
				} else {
					register.snackBarShow(scaffoldKey, 'Problem reseting password');
				}
			}
		} else {
  		register.snackBarShow(scaffoldKey, responseData['error']);
		}
  }*/
    
  

  
}