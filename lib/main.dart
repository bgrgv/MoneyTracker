import 'package:flutter/services.dart';
import 'test.dart';
import 'package:my/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'secondScreen.dart';


void main(){
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(new login());
}

class calcScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'inCome!',
      debugShowCheckedModeBanner: false,

      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new calcHomeScreen(title: 'inCome!-DEVELOPMENT VERSION'),
    );
  }
}

class calcHomeScreen extends StatefulWidget {
  calcHomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _calcHomeScreenState createState() => new _calcHomeScreenState();
}

class _calcHomeScreenState extends State<calcHomeScreen> {
  String output="0";

  String temp="0";
  double n1=0.0;
  double n2=0.0;
  String op ="";
  double others=0.0;
  double cash=0.0;

  //YOU CAN MODIFY THIS FOR CREATING ALERTS! :)


  buttonPressed(String buttonText){

    if(buttonText=="CLS"){

      temp="0";
      n1=0.0;
      n2=0.0;
      op ="";

      print("CLEAR");
    }
    else if(buttonText=="+"||buttonText=="-"||buttonText=="/"||buttonText=="*"){

      n1 = double.parse(output);
      op=buttonText;
      temp="0";
      print("hi");

    }

    else if(buttonText=="."){

      if(temp.contains(".")){   //Checks for an existing Decimal Point in the code!

        print("A decimal point exists already!");  //Shows this in the log in your IDE, the part on the left bottom part of the IDE.
      }
      else
      {
        temp=temp+buttonText;
      }

    }

    else if(buttonText=="="){

      n2=double.parse(output);
      if(op=="+"){

        temp=(n1+n2).toString();

      }
      if(op=="-"){

        temp=(n1-n2).toString();

      }
      if(op=="/"){

        temp=(n1/n2).toString();

      }
      if(op=="*"){

        temp=(n1*n2).toString();

      }
      n1=0.0;
      n2=0.0;
      op="";

    }else if(buttonText=="CASH"){
//      cash=double.parse(temp);
//      print(cash);
        setState(() {
          items.add(double.parse(temp).toStringAsFixed(1)+"   -CASH");
        });
        op="";
        n1=0.0;
        n2=0.0;
        cashTotal=cashTotal+double.parse(temp);
        total=total+cashTotal;
        setState(() {
          temp="0";
        });

    }else if(buttonText=="OTHERS"){
//      others=double.parse(temp);
//      print(others);
        setState(() {
          items.add(double.parse(temp).toStringAsFixed(1)+"   -OTHERS");
        });
        op="";
        n1=0.0;
        n2=0.0;
        othersTotal=othersTotal+double.parse(temp);
        total=total+othersTotal;
        setState(() {
          temp="0";
        });

    }
    else{

      temp=temp+buttonText;

    }

    setState(() {
      output=double.parse(temp).toStringAsFixed(1);
    });

  }


  Widget makeButton(String buttonText){

    return new Expanded(
      child:
      new MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 20.0,),

        child: new Text(buttonText,style: TextStyle(color: Colors.white,fontSize: 30.0),),
        onPressed: (){

          buttonPressed(buttonText);
        },
        color: Colors.blue[900],

      ),
    );

  }

  Widget makeButton2(String buttonText){

    return new Expanded(
      child: new MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 20.0,),


        child: new Text(buttonText,style: TextStyle(color: Colors.white,fontSize: 30.0,),),
        onPressed: (){

          buttonPressed(buttonText);
        },
        color: Colors.blue[500],

      ),
    );

  }

  Widget makeButton3(String buttonText){

    return new Expanded(
      child: new MaterialButton(
        padding: EdgeInsets.all(20.0),

        child: new Text(buttonText,style: TextStyle(color: Colors.white,fontSize: 30.0),),
        onPressed: (){

          buttonPressed(buttonText);
        },
        color: Colors.blue,

      ),
    );

  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new Container(


          child: new Column(

            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(75.0),
                child: new Container(
                  child: new Text(output,style: TextStyle(

                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,

                  ),),alignment: Alignment.center,
                ),
              ),

              new Expanded(child: new Divider()),


              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new MaterialButton(
                      padding: EdgeInsets.all(20.0),

                      child: new Text("ALL TRANSACTIONS",style: TextStyle(color: Colors.white,fontSize: 30.0),),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new secondScreen()));
                      },
                      color: Colors.blue,

                    ),
                  ),
                ],
              ),
              new Row(
                children: <Widget>[

                  makeButton("7"),
                  makeButton("8"),
                  makeButton("9"),
                  makeButton2("+"),


                ],
              ),
              new Row(
                children: <Widget>[

                  makeButton("4"),
                  makeButton("5"),
                  makeButton("6"),
                  makeButton2("*"),


                ],
              ),
              new Row(
                children: <Widget>[

                  makeButton("1"),
                  makeButton("2"),
                  makeButton("3"),
                  makeButton2("="),


                ],
              ),
              new Row(
                children: <Widget>[

                  makeButton("0"),
                  makeButton("00"),
                  makeButton("."),
                  makeButton2("CLS"),


                ],
              ),
              new Row(
                children: <Widget>[
                  makeButton3("CASH"),
                  makeButton3("OTHERS")
                ],
              )



            ],

          ),

        )

    );
  }
}
