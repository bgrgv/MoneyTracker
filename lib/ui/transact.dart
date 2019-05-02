
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() {
    // TODO: implement createState
    return new _TransactionState();
  }
}

class _TransactionState extends State<Transaction> {
  String amount_str = "0";

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _generateTransactionScreen(),
    );
  }

  Widget _generateTransactionScreen() {
    return new Scaffold(
      
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(0),
          child: Container(
        padding: EdgeInsets.all(0),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height < 600
            ? 600
            : MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left:20,right:20, top:10, bottom:10),
              child: new Container(
                child: new Text(
                  amount_str,
                  style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                alignment: Alignment.center,
              ),
            )),
            Card(
                margin: EdgeInsets.only(left: 1, right: 1, bottom: 0),
                elevation: 2.0,
                color: Colors.blue,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10.0),
                )),
                child: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        makeButtonNum("7"),
                        makeButtonNum("8"),
                        makeButtonNum("9"),
                        makeButtonOp("+"),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        makeButtonNum("4"),
                        makeButtonNum("5"),
                        makeButtonNum("6"),
                        makeButtonOp("*"),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        makeButtonNum("1"),
                        makeButtonNum("2"),
                        makeButtonNum("3"),
                        makeButtonOp("="),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        makeButtonNum("0"),
                        makeButtonNum("00"),
                        makeButtonNum("."),
                        makeButtonOp("C"),
                      ],
                    ),
                    new Card(
                      elevation: 20.0,
                      color: Colors.white,
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10.0),
                      )),
                      child: new Column(children: <Widget>[
                        new Row(
                          children: <Widget>[
                            makeButtonPay("Gpay"),
                            makeButtonPay("PayTm"),
                            makeButtonPay("Cash")
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            makeButtonPay("PhonePe"),
                            makeButtonPay("Card"),
                            makeButtonPay("Other")
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(0),child: MaterialButton(
                            padding: EdgeInsets.only(top:12, bottom:12),
                            minWidth: double.infinity,
                            color: Colors.blue,
                            onPressed: () {},
                            child: Text(
                              "View Summary",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontFamily: "WorkSansBold"),
                            )),)
                        
                      ]),
                    )
                  ],
                ))
          ],
        ),
      )),
    );
  }

  Widget makeButtonNum(String buttonText) {
    return new Expanded(
      child: new MaterialButton(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        child: new Text(
          buttonText,
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
        onPressed: () => print(buttonText),
        color: Colors.blue,
      ),
    );
  }

  Widget makeButtonOp(String buttonText) {
    return new Expanded(
      child: new MaterialButton(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        child: new Text(
          buttonText,
          style: TextStyle(
            color: Colors.orange,
            fontSize: 30.0,
          ),
        ),
        onPressed: () => print(buttonText),
        color: Colors.blue,
      ),
    );
  }

  Widget makeButtonPay(String buttonText) {
    //TODO: Use icon instead of text
    return new Expanded(
      child: new MaterialButton(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        child: new Text(
          buttonText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
          ),
        ),
        onPressed: () => print(buttonText),
        color: Colors.white,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

}
