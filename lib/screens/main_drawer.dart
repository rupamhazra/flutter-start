import 'package:flutter/material.dart';
import './details_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                          image: NetworkImage(
                              'https://secure.gravatar.com/avatar/317e886f9db6f48efe76ecb91034184a?s=100&d=mm&r=g'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Text('Rupam Hazra',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  Text('rupamhazra@gmail.com',
                      style: TextStyle(color: Colors.white)),
                  Text('9038698174', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Account'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/details-screen');
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
            onTap: null,
          )
        ],
      ),
    );
  }
}
