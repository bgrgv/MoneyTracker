import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/style/theme.dart' as Theme;
import 'package:flutter_app/ui/auth.dart';
import 'package:flutter_app/ui/transact.dart';

void main() => runApp(
  new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new FirebaseAuthWidget(),
  )
);

class FirebaseAuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _handleCurrentScreen(),
    );
  }

  Widget _handleCurrentScreen() {
    return new StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return new SplashScreen();
        } else {
            if (snapshot.hasData) {
              //return new MainScreen(firestore: firestore, uuid: snapshot.data.uid);
              //Logged In

              if(snapshot.data.isEmailVerified){
                return new Transaction();
              }
              else{
                // email not verified
                return new Auth();
              }
            }
            return new Auth();
          }
        }
      );
  }

  
}

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        resizeToAvoidBottomPadding: true,
        body: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height < 550?550:MediaQuery.of(context).size.height,
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
                      padding: EdgeInsets.only(top: 50, bottom: 50, left: 50, right: 50),
                      child: new Image(
                        fit: BoxFit.contain,
                        image: new AssetImage('assets/img/dsc_logo.png'),
                      ),
                    ),
                  ),
                ],
              )),
        )),
    );
  }
    
  } 