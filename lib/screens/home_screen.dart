import 'dart:async';

import 'dart:convert';
import 'package:flutter/material.dart';
import './main_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../widgets/slide_dots.dart';
import '../model/slide.dart';
import '../widgets/slideitem.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State {
  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);
  String _name = '';
  Map<String, dynamic> userDetails;
  String _userid;
  Position _currentPosition;
  String _currentAddress;

  void _getCurrentLocation() async {
    print('dsffdssf');
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //print('position ${position}');
    setState(() {
      _currentPosition = position;
    });
    _getAddressFromLatLng();
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
      print(place);
      setState(() {
        _currentAddress =
            "${place.administrativeArea}, ${place.subAdministrativeArea}, ${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  loadUserDetails() async {
    print('loadUserDetails');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    userDetails = json.decode(_prefs.getString('result'));
    _userid = userDetails['result']['id'];
    //print('_userid' + _userid);
    return _userid;
  }

  api_call() async {
    String id = await loadUserDetails();
    //print('api_call');
    //print('id' + id);
    var url = 'http://52.66.138.162/api/wallet.php/';
    Map request_data = {
      "type": "wallet",
      "user_id": id,
      "page": "1",
      "count": "3"
    };
    var response = await http.post(url, body: request_data);
    var result = json.decode(response.body);
    //print('Response status wallet: ${result}');
  }

  loadInitialData() async {
    //print('init method');
    api_call();
  }

  @override
  void initState() {
    super.initState();
    loadInitialData();

    //_name = 'sfsff';
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(_currentPage,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  _onSearch() {
    print('on serach');
    Navigator.of(context).pushNamed('/search-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          bottom: PreferredSize(
              child: Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    TextField(
                      onTap: () =>
                          _onSearch(),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search for Products',
                      ),
                    ),
                  ],
                ),
              ),
              preferredSize: Size(50, 50)),
          elevation: 30.0,
        ),
        drawer: MainDrawer(),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    Container(
                      // A fixed-height child.
                      color: const Color(0xffeeee00), // Yellow
                      height: 150.0,
                      alignment: Alignment.center,
                      child: Stack(children: [
                        PageView.builder(
                          scrollDirection: Axis.horizontal,
                          onPageChanged: _onPageChanged,
                          controller: _pageController,
                          itemCount: slideList.length,
                          itemBuilder: (ctx, i) => SlideItem(i),
                        ),
                      ]),
                    ),
                    Expanded(
                      // A flexible child that will grow to fit the viewport but
                      // still be at least as big as necessary to fit its contents.
                      child: Container(
                        color: const Color(0xffee0000), // Red
                        height: 600.0,
                        alignment: Alignment.center,
                        child: Stack(children: [
                          PageView.builder(
                            scrollDirection: Axis.horizontal,
                            onPageChanged: _onPageChanged,
                            controller: _pageController,
                            itemCount: slideList.length,
                            itemBuilder: (ctx, i) => SlideItem(i),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        })
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
    print(query);
    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();
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
