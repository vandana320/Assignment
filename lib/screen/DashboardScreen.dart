import 'package:assignment/screen/OrderScreen.dart';
import 'package:assignment/screen/ProfileScreen.dart';
import 'package:assignment/ui/BaseState.dart';
import 'package:assignment/util/CommonUtil.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _DashboardScreenState();
  }
}

class _DashboardScreenState extends BaseState<DashboardScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Icon(Icons.offline_bolt, color: Colors.white, size: 40),
              ),
              ListTile(
                title: const Text('Dashboard'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Order'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
              ),
            ],
          )
      ),
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(
            fontFamily: CommonUtil.FONT_FAMILY,
            fontWeight: FontWeight.bold,
          ),
        ),
        brightness: Brightness.dark,
      ),
      backgroundColor: Color(0xFFF1F9FC),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}