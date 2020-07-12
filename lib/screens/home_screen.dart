import 'dart:async';

import 'package:flutter/material.dart';
import '../widgets/slide_dots.dart';
import '../model/slide.dart';
import '../widgets/slideitem.dart';
import './main_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State {
  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home Page")),
        drawer: MainDrawer(),
        body: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          PageView.builder(
                              scrollDirection: Axis.horizontal,
                              onPageChanged: _onPageChanged,
                              controller: _pageController,
                              itemCount: slideList.length,
                              itemBuilder: (ctx, i) => SlideItem(i),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.topStart,
                              children: [
                                Container(
                                  //margin: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for(int i=0; i < slideList.length;i++)
                                      if(i == _currentPage)
                                        SlideDots(true)
                                      else
                                        SlideDots(false)
                                    ],
                                  ),
                                )
                              ],
                            )
                        ],
                      ))
                      
                      ,
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FlatButton(
                        onPressed: () {},
                        child: Text('Getting Started'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Have an account?'),
                          FlatButton(onPressed: null, child: Text('Login'))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ))

        // body: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(
        //         "We are in the home page now",
        //         style: TextStyle(fontSize: 22),
        //       ),
        //       RaisedButton(
        //         child: Text('Go to details'),
        //         onPressed: () {
        //           Navigator.of(context).pushNamed('/details-screen');
        //         },
        //       )
        //     ],
        //   ),
        // )
        );
  }
}
