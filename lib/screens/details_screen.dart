import 'package:flutter/material.dart';
import './main_drawer.dart';

class DetailsScreen extends StatelessWidget {
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
                "We are in the details page now",
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
