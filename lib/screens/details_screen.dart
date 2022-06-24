import 'package:flutter/material.dart';
import './main_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String _name = '';
  checkData() async {
    print('ssssss');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //print('check data: ${value}');
    _name = _prefs.getString('result');
    print('_name: ${_name}');
     setState(() {
        //_name = _prefs.getString('result');
      });
  }

  @override
  void initState() {
    checkData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Details Page")),
        drawer: MainDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "We are in the details page now" + _name,
                style: TextStyle(fontSize: 22),
              ),
              RaisedButton(
                child: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ));
  }
}