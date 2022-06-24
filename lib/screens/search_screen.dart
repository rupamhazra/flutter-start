import 'dart:async';

import 'dart:convert';
import 'package:flutter/material.dart';
import './main_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                })
          ],
          elevation: 30.0,
        ),
        //drawer: MainDrawer(),
       
        );
  }
}


class DataSearch extends SearchDelegate<String> {
  final cities = [
    "Kolkata",
    "New Delhi",
    "Mumbai",
    "Jaipur",
    "Rajkot",
    "Bhopal",
    "Chennai",
    "Agra"
  ];

  final recentCities = ["Kolkata", "New Delhi", "Mumbai", "Jaipur"];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: actions for App Bar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
    //throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
    //throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: show some results based on the selection

    //throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: show when someone seraches for something
    
    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();
    print('suggestionList ${suggestionList}');
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.location_city),
        title: Text(suggestionList[index]),
      ),
      itemCount: suggestionList.length,
    );
    //throw UnimplementedError();
  }
}
