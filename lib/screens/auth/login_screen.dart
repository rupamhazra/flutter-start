import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool _isLoading = false;

  Future signIn(String username, password) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //print('username :${username}');
    //var url = 'http://52.66.138.162/api/usr.php/';
    var url = 'http://tobuekalabya.com/rskart/api/userlogin/';
    Map request_data = {"email_contact": username, "password": password};
    var response = await http.post(url, body: request_data);
    
    print('Response status: ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      _isLoading = false;
      var jsonData = json.decode(response.body);
      print('Response body: ${jsonData}');
      _prefs.setString('result', response.body);
      _prefs.setString('contact', jsonData['result']['contact']);
      //_prefs.setString('result', response.body);
      
      Navigator.of(context).pushNamed('/home-screen');
    } else {
      var result = json.decode(response.body);
      Fluttertoast.showToast(
        msg: result['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.blueGrey,
        fontSize: 12.0,
      );
    }
  }

  Future authenticate() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var contact = _prefs.getString('contact') ?? '_';
    print('contact ${contact}');
    if (contact != '_') {
      Navigator.of(context).pushNamed('/home-screen');
    }
  }

  @override
  void initState() {
    super.initState();
    authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: Text("Login")
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                color: Theme.of(context).primaryColor,
                width: double.infinity,
                child: SingleChildScrollView(
                    child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'assets/images/icon.png',
                        height: 80,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: username,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Username',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        obscureText: true,
                        controller: password,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              _isLoading = true;
                            });
                            signIn(username.text, password.text);
                          },
                          shape: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                )));
          },
        ));
  }
}
