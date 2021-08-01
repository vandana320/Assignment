import 'package:assignment/model/LoginResponse.dart';
import 'package:assignment/ui/BaseState.dart';
import 'package:assignment/util/CommonUtil.dart';
import 'package:assignment/util/PrefKey.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends BaseState<LoginScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _emailFieldController = TextEditingController();
  TextEditingController _passwordFieldController = TextEditingController();
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    Widget emailWidgetNew = Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: TextFormField(
          onChanged: (String value) {},
          cursorColor: Color(0xff1B1DC7),
          controller: _emailFieldController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontFamily: CommonUtil.FONT_FAMILY),
          validator: (value) {
            if (value!.isEmpty) return "User-name or email address";
            return null;
          },
          decoration: InputDecoration(
              hintText: "Username or email",
              hintStyle: TextStyle(fontFamily: CommonUtil.FONT_FAMILY),
              prefixIcon: Material(
                elevation: 0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Icon(
                  Icons.email,
                  color: Color(0xff1B1DC7),
                ),
              ),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
        ),
      ),
    );

    Widget passwordWidgetNew = Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: TextFormField(
          onChanged: (String value) {},
          obscureText: true,
          style: TextStyle(fontFamily: CommonUtil.FONT_FAMILY),
          controller: _passwordFieldController,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Enter password";
            }
            if (value.trim().length < 6) {
              return "Enter correct six digit password";
            }
            return null;
          },
          cursorColor: Color(0xff1B1DC7),
          decoration: InputDecoration(
              hintText: "Password",
              hintStyle: TextStyle(fontFamily: CommonUtil.FONT_FAMILY),
              prefixIcon: Material(
                elevation: 0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Icon(
                  Icons.lock,
                  color: Color(0xff1B1DC7),
                ),
              ),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
        ),
      ),
    );

    Widget loginButtonnew = Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Container(
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xff1B1DC7), Color(0xff484AD2)]),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          child: FlatButton(
            child: Text(
              "Login",
              style: TextStyle(
                  fontFamily: CommonUtil.FONT_FAMILY,
                  color: Colors.white,
                  fontSize: 18),
            ),
            onPressed: _onLoginButtonTap,
          ),
        ));

    var loaderView = new Center(
        child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor)));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _saving
            ? loaderView
            : Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        ClipPath(
                          clipper: WaveClipper2(),
                          child: Container(
                            child: Column(),
                            width: double.infinity,
                            height: 320,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              Color(0xffd1d1f3),
                              Color(0xffffffff)
                            ])),
                          ),
                        ),
                        ClipPath(
                          clipper: WaveClipper3(),
                          child: Container(
                            child: Column(),
                            width: double.infinity,
                            height: 320,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              Color(0xffa3a4e8),
                              Color(0xffbabbee)
                            ])),
                          ),
                        ),
                        ClipPath(
                          clipper: WaveClipper1(),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 50,
                                ),
                                Icon(
                                  Icons.fastfood,
                                  color: Colors.white,
                                  size: 60,
                                ),
                                //#1B1DC7
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Logo",
                                  style: TextStyle(
                                      fontFamily: CommonUtil.FONT_FAMILY,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30),
                                ),
                              ],
                            ),
                            width: double.infinity,
                            height: 320,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              Color(0xff1B1DC7),
                              Color(0xff484AD2)
                            ])),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    emailWidgetNew,
                    SizedBox(
                      height: 20,
                    ),
                    passwordWidgetNew,
                    SizedBox(
                      height: 25,
                    ),
                    loginButtonnew,
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "FORGOT PASSWORD ?",
                        style: TextStyle(
                            fontFamily: CommonUtil.FONT_FAMILY,
                            color: Color(0xff1B1DC7),
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _onLoginButtonTap() {
    // Validate will return true if the form is valid, or false if
    // the form is invalid.
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _saving = true;
      });
      LoginResponse response = LoginResponse(
          _emailFieldController.text, _passwordFieldController.text);
      _onLoginResultSuccess(response);
    }
  }

  Future<void> _onLoginResultSuccess(LoginResponse response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await saveLoginSession(response, prefs).then((bool done) {
      prefs.setBool(PrefKey.PREF_KEY_PROFILE_SLIDE_SETUP, done);
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/home', (Route<dynamic> route) => false);
    });
  }

  saveLoginSession(LoginResponse user, SharedPreferences _prefs) {
    _prefs.setString(PrefKey.PREF_KEY_EMAIL, user.email);
    return _prefs.setString(PrefKey.PREF_KEY_USERID, user.password);
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 15 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 40);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
