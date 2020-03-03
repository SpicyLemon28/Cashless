import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {navigatePreviousPage(context);},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green [900],
          title: Text('Profile'),
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () => navigatePreviousPage('/settings'),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 580),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 130),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: text('User Name', TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 70),
                            child: text('User Phone Number', TextStyle(color: Colors.grey [700], fontSize: 14, fontWeight: FontWeight.w400)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //QR Icon
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 90, 260, 520),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey [700],
                        blurRadius: 5,
                        spreadRadius: 2
                      )
                    ]
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 230),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) => Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 60),
                          child: title('Email:'),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                          child: Card(
                            elevation: 3,
                            child: listTile('example@email.com', null),
                          ),
                        ),

                         title('Password:'),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                          child: Card(
                            elevation: 3,
                            child: listTile('12345678', () => navigatePage('/changePass')),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 70),
                          child: title('Pin:'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            elevation: 3,
                            child: listTile('123456', null),
                          ),
                        ),
                      ],
                    )
                    ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
  Widget title(txt) => Padding(
    padding: const EdgeInsets.only(right: 230),
    child: Text(txt, style: TextStyle(color: Colors.grey [600], fontSize: 20, fontWeight: FontWeight.w500)),
  );

  Widget text(txt, styleText) => Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Text(txt, style: styleText,),
  );

  Widget listTile(txt, goTo) => ListTile(
    title: Text(txt, style: TextStyle(color: Colors.grey, fontSize: 14)),
    onTap: goTo,
    trailing: Icon(Icons.edit),
  );

  Widget editIcon(iconTxt) => Padding(
    padding: const EdgeInsets.only(left: 350),
    child: Icon(iconTxt),
  );

  void navigatePage(navTo) =>
		Navigator.pushReplacementNamed(context, navTo);

  void navigatePreviousPage(navTo){
    Navigator.popAndPushNamed(context, navTo);
  }
}