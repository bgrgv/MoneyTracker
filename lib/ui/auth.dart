import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/style/theme.dart' as Theme;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/ui/transact.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

final FirebaseAuth _auth = FirebaseAuth.instance;

class Auth extends StatefulWidget {
  Auth({Key key}) : super(key: key);
  @override
  _AuthPageState createState() {
    return new _AuthPageState();
  }
}

class _AuthPageState extends State<Auth> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PageController _pageController;

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _isSigningUp = false;
  bool _isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        body: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height < 550
                  ? 550
                  : MediaQuery.of(context).size.height,
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Theme.Colors.loginGradientStart,
                      Theme.Colors.loginGradientEnd
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: new Image(
                        fit: BoxFit.contain,
                        image: new AssetImage('assets/img/dsc_logo.png'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _pageController,
                      children: <Widget>[
                        new ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: _buildSignIn(context),
                        ),
                        new ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: _buildSignUp(context),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  void showInSnackBar(String value, Color color) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: color, fontSize: 16.0, fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(top: 23.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 170.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: "Email Address",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                FontAwesomeIcons.eye,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 150.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.Colors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Theme.Colors.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientEnd,
                        Theme.Colors.loginGradientStart
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Theme.Colors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () => _signInWithEmailAndPassword(
                        loginEmailController.text,
                        loginPasswordController.text)),
              ),
            ],
          ),
          SizedBox(
            height: 3,
            child: _isLoggingIn ? LinearProgressIndicator() : SizedBox.shrink(),
          ),
          FlatButton(
              onPressed: () {},
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: "WorkSansMedium"),
              )),
          Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: RaisedButton(
                  color: Colors.white,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: Text(
                      "Signup instead",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18.0,
                          fontFamily: "WorkSansBold"),
                    ),
                  ),
                  onPressed: _onSignUpButtonPress)),
        ],
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(top: 23.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 240.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 15.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeName,
                          controller: signupNameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                            ),
                            hintText: "Name",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmail,
                          controller: signupEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                            ),
                            hintText: "Email Address",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePassword,
                          controller: signupPasswordController,
                          obscureText: _obscureTextSignup,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignup,
                              child: Icon(
                                FontAwesomeIcons.eye,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 220.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.Colors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Theme.Colors.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientEnd,
                        Theme.Colors.loginGradientStart
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Theme.Colors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () => _signUpWithEmailAndPassword(
                        signupEmailController.text,
                        signupPasswordController.text,
                        signupNameController.text)),
              ),
            ],
          ),
          SizedBox(
            height: 3,
            child: _isSigningUp ? LinearProgressIndicator() : SizedBox.shrink(),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                  color: Colors.white,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: Text(
                      "Signin instead",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18.0,
                          fontFamily: "WorkSansBold"),
                    ),
                  ),
                  onPressed: _onSignInButtonPress)),
        ],
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _signInWithEmailAndPassword(String _email, String _pwd) async {
    setState(() {
      _isLoggingIn = true;
    });
    if (isValidEmail(_email) && isValidPassword(_pwd)) {
      try {
        final FirebaseUser user = await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _pwd,
        );
        if (user != null) {
          if (user.isEmailVerified) {
            setState(() {
              print(user.uid);
              // _success = true;
              // _userEmail = user.email;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Transaction()),
                  ModalRoute.withName("/Home"));
              setState(() {
                _isLoggingIn = false;
              });
            });
          } else {
            showInSnackBar("Email verification not complete", Colors.white);
            setState(() {
              _isLoggingIn = false;
            });
          }
        } else {
          // _success = false;
          setState(() {
            _isLoggingIn = false;
          });
        }
      } on PlatformException catch (e) {
        print(e);
        setState(() {
          _isLoggingIn = false;
        });
      }
    } else {
      showInSnackBar("Email / password invalid", Colors.red);
      setState(() {
        _isSigningUp = false;
      });
    }
  }

  void _signUpWithEmailAndPassword(String _email, String _pwd, String name) async {
    setState(() {
      _isSigningUp = true;
    });
    if (isValidEmail(_email) && isValidPassword(_pwd)) {
      try {
        final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _pwd,
        );
        if (user != null) {
          await user.sendEmailVerification();
          saveUserData(name, user.uid);
          print("Sent email verification to $user.email");
          setState(() {
            // _success = true;
            // _userEmail = user.email;
            _isSigningUp = false;
          });
          showInSnackBar("Verification email sent", Colors.white);
        } else {
          // _success = false;
          setState(() {
            _isSigningUp = false;
          });
        }
      } on PlatformException catch (e) {
        print(e);
        setState(() {
          _isSigningUp = false;
        });
      }
    } else {
      showInSnackBar("Email / password invalid", Colors.red);
      setState(() {
        _isSigningUp = false;
      });
    }
  }

  void saveUserData(String name, String userid) {
    final firestore.CollectionReference userRef = firestore.Firestore.instance.collection('/user');
    userRef.document(userid).setData({"name":name});
  }

  bool isValidEmail(String _email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(_email);
  }

  bool isValidPassword(String _pwd) {
    return _pwd.length >= 8 && _pwd.length <= 30;
  }
}
