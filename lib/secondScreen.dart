import 'package:flutter/material.dart';

final List<String> items = [];
var date = DateTime.now().day.toString() +    " / " +
    DateTime.now().month.toString() +    " / 2019";
double total = 0.0;
double cashTotal=0.0;
double othersTotal=0.0;

class secondScreen extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold();
  }

  _secondScreen createState() => new _secondScreen();
}

class _secondScreen extends State<secondScreen> {
  final List<String> cashList = ["1", "2", "3"];
  final List<String> otherList = ["4", "5", "6"];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Summary -DEV VERSION"),
      ),
      body: Column(
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 40.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "Report  for  " + date,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30.0),
                    ),
                  ],
                ),
              )
            ],
          ),
          new Column(
            children: <Widget>[
              new MaterialButton(
                onPressed: () {
                  items.clear();
                  setState(() {
                    items.add("");
                    cashTotal=0.0;
                    total=0.0;
                    othersTotal=0.0;
                  });
                },
                color: Colors.red[700],
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: new Text(
                    "DELETE  ALL",
                    style: TextStyle(
                      fontSize: 20.0,
//                                  fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 5.0,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Expanded(
            child: Column(
              children: <Widget>[
                new Container(
                  alignment: Alignment.center,
                  child: new Container(
                    padding: EdgeInsets.only(top: 0.0),
                    height: 400.0,
                    width: 200.0,
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.only(top: 10.0),
                          title: Text(
                            '${items[index]}',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Column(
              children: <Widget>[
                new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: new Column(
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new MaterialButton(
                                onPressed: () {},
                                color: Colors.green[700],
                                child: new Text(
                                  "CASH : "+cashTotal.toString(),
                                  style: TextStyle(
                                    fontSize: 20.0,
//                                  fontWeight: FontWeight.bold,
                                    color: Colors.white,
//                                  letterSpacing: 5.0,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                              new MaterialButton(
                                onPressed: () {},
                                color: Colors.green[700],
                                child: new Text(
                                  "OTHERS : "+othersTotal.toString(),
                                  style: TextStyle(
                                    fontSize: 20.0,
//                                  fontWeight: FontWeight.bold,
                                    color: Colors.white,
//                                  letterSpacing: 5.0,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: new Column(
                        children: <Widget>[
                          new MaterialButton(
                            onPressed: () {},
                            color: Colors.blue,
                            child: new Text(
                              "Total : " + total.toString(),
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 5.0,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
