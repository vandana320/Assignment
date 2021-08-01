import 'package:assignment/model/Order.dart';
import 'package:assignment/model/OrderModel.dart';
import 'package:assignment/screen/OrderList.dart';
import 'package:assignment/ui/BaseState.dart';
import 'package:assignment/util/CommonUtil.dart';
import 'package:assignment/util/PrefKey.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }

}

class _ProfileScreenState extends BaseState<ProfileScreen> {
 String email = "", userId="";
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value){
      setState(() {
        email = value.getString(PrefKey.PREF_KEY_EMAIL)!;
        userId = value.getString(PrefKey.PREF_KEY_USERID)!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: _buildWidget(context) ,
    );
  }

  Widget _buildWidget(BuildContext context) {
    Widget imageWidget = Container(
        width: MediaQuery.of(context).size.width * 1.0,
        height: MediaQuery.of(context).size.width * 0.29,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('assets/images/profile_img.png'),
                fit: BoxFit.fitHeight)));
    Widget nameWidget = Text("Vandana", style: TextStyle(color: Colors.black,
        fontFamily: CommonUtil.FONT_FAMILY, fontSize: 16));
    Widget userIdWidget = Text(userId, style: TextStyle(color: Colors.black,
    fontFamily: CommonUtil.FONT_FAMILY, fontSize: 16));
    Widget addressWidget = Text("Banagalore", style: TextStyle(color: Colors.black,
    fontFamily: CommonUtil.FONT_FAMILY, fontSize: 16));
    Widget emailWidget = Text("$email", style: TextStyle(color: Colors.black,
    fontFamily: CommonUtil.FONT_FAMILY, fontSize: 16));

    Widget logoutWidget = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient:
        LinearGradient(colors: [Color(0xff1B1DC7), Color(0xff484AD2)]),
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: FlatButton(
        child: Text(
          "Logout",
          style: TextStyle(
              fontFamily: CommonUtil.FONT_FAMILY,
              color: Colors.white,
              fontSize: 18),
        ),
        onPressed: () {
          logoutUser().then((_) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (Route<dynamic> route) => false);
          });
        },
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          imageWidget,
          SizedBox(height: 30.0),
          nameWidget,
          SizedBox(height: 15.0),
          userIdWidget,
          SizedBox(height: 10.0),
          addressWidget,
          SizedBox(height: 10.0),
          emailWidget,
          SizedBox(height: 30),
          logoutWidget
        ],
      ),
    );
  }
 Future<bool> logoutUser() async {
   final SharedPreferences _prefs = await SharedPreferences.getInstance();
   return _prefs.clear();
 }
}