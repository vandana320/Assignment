import 'package:assignment/screen/DashboardScreen.dart';
import 'package:assignment/screen/MarketWatchScreen.dart';
import 'package:assignment/ui/BaseState.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends BaseState<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _cIndex = 0;
  late BuildContext mContext;
  MarketWatchScreen _marketwatchScreen = MarketWatchScreen();
  DashboardScreen _dashboardScreen = DashboardScreen();

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      body: getPage(_cIndex),
      bottomNavigationBar: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          child: BottomNavigationBar(
            backgroundColor: Colors.white70,
            elevation: 0.0,
            type: BottomNavigationBarType.fixed,
            onTap: (int index) {
              setState(() {
                this._cIndex = index;
              });
            },
            currentIndex: _cIndex,
            fixedColor: Theme.of(context).accentColor,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text("Home")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.contact_mail),
                  title: Text("Dashboard")),
            ],
          )
      ),
    );
  }

  Widget getPage(int index) {
    if (index == 0) {
      if (_marketwatchScreen == null) {
        _marketwatchScreen = MarketWatchScreen();
      }
      return _marketwatchScreen;
    }
    if (index == 1) {
      if (_dashboardScreen == null) {
        _dashboardScreen = DashboardScreen();
      }
      return _dashboardScreen;
    }
    return _marketwatchScreen;
  }
}
