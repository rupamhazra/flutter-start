import 'package:flutter/material.dart';
import './details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MainDrawer extends StatefulWidget {
  @override
  MainDrawerState createState() => MainDrawerState();
}

class MainDrawerState extends State {
  String _name = '';
  String _email = '';
  String _contactno = '';
  String _profileImage = '';
  Map<String, dynamic> userDetails;
  checkData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    setState(() {
      userDetails = json.decode(_prefs.getString('result'));
      print('Response body: ${userDetails['result']}');
      _name = userDetails['result']['name'];
      _email = userDetails['result']['email'];
      _contactno = userDetails['result']['contact'];
      _profileImage = 'http://tobuekalabya.com/rskart/uploads/'+userDetails['result']['profile_image'];
      // print('_name: ${_name}');
    });
  }

  logout() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
    Navigator.of(context).pushNamed('/login-screen');
  }

  @override
  void initState() {
    checkData();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(_profileImage), fit: BoxFit.fill),
                    ),
                  ),
                  Text(_name,
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  Text(_email, style: TextStyle(color: Colors.white)),
                  Text(_contactno, style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Account'),
            onTap: () {
              Navigator.of(context).pushNamed('/profile-screen');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: null,
          ),
          ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text('Logout'),
              onTap: () {
                logout();
              })
        ],
      ),
    );
  }
}
