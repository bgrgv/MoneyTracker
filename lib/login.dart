import 'package:flutter/material.dart';
import 'dart:async';
import 'package:my/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'inCome!',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new loginScreen(),
    );
  }
}

class loginScreen extends StatefulWidget{
  loginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _loginScreen createState() => new _loginScreen();
}

class _loginScreen extends State<loginScreen>{

  String _email,_password,loginMessage="";
  Future<void> signIn() async{
    final _formState=_formkey.currentState;
    if(_formState.validate()){
      _formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>calcScreen()));
      }catch(e){
        setState(() {
          loginMessage=e.message;
        });
      }
    }
  }

  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("Login --DEVELOPMENT VERSION"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0,right: 30.0),
              child: new Column(
                children: <Widget>[
                  new TextFormField(
                    validator: (input){
                      if(!(!(input.contains("@")))&&(!(input.contains(".")))){
                        return "This Email pattern isn't allowed.";
                      }
                    },
                    onSaved: (input)=>_email=input,
                    decoration: InputDecoration(
                      labelText: 'Enter your Email',
                    ),style: TextStyle(
                    fontSize: 23.0,
                    color: Colors.black

                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: new TextFormField(
                      validator: (input){
                        if(input.length<6){
                          return 'Enter a strong password!';
                        }
                      },
                      onSaved: (input)=>_password=input,
                      decoration: InputDecoration(
                          labelText: 'Enter your password'
                      ),style: TextStyle(
                      fontSize: 23.0,
                      color: Colors.black
                    ),
                      obscureText: true,
                    ),
                  ),
                  new MaterialButton(onPressed: signIn,
                    color: Colors.lightGreen,textColor: Colors.white,
                  child: new Text("Login!",style: TextStyle(
                    fontSize: 20.0
                  ),),),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: new Text(loginMessage,style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),

                ],
              ),
            ),
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text("© Blessin George Varghese\n\n SRM DSC | 2018-2019\n\nblesing79@live.com",style: TextStyle(
                    fontSize: 15.0,
                  ),textAlign: TextAlign.center,)
                ],
              )
            ],
          ),
          new Text("! DEVELOPMENT VERSION !")
        ],
      )
    );
  }
}