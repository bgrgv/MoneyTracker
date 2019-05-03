import 'package:flutter/material.dart';
import 'package:flutter_app/style/theme.dart' as Theme;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/ui/report.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter_app/ui/transact.dart';

class Summary extends StatefulWidget {
  @override
  _SummaryState createState() {
    return new _SummaryState();
  }
}

class _SummaryState extends State<Summary> {
  double sales_prev_day = 0;
  double sales_today = 0;
  bool sync_state = true;

  double mode_gpay = 0;
  double mode_paytm = 0;
  double mode_phonepe = 0;
  double mode_cash = 0;
  double mode_card = 0;
  double mode_other = 0;

  double trans_d2 = 0;
  double trans_d3 = 0;
  double trans_d4 = 0;
  double trans_d5 = 0;
  double trans_d6 = 0;
  String day1="",day2="",day3="",day4="",day5="",day6="",day7="";

  void _onSyncStateChange(bool value) => setState(() => sync_state = value);
  _SummaryState() {
    getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        resizeToAvoidBottomPadding: true,
        body: SingleChildScrollView(
          child: Center(
            child: new Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height < 400
                    ? 400
                    : MediaQuery.of(context).size.height - 90,
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
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Card(
                              elevation: 15,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: new Column(
                                children: <Widget>[
                                  Text(
                                    "Yesterday's Sales",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Text(
                                    "₹ " + sales_prev_day.toString(),
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 30.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              elevation: 15,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: new Column(
                                children: <Widget>[
                                  Text(
                                    "Today's Sales",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Text(
                                    "₹ " + sales_today.toString(),
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 30.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      new Divider(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      // recentTransactionsWidget(),
                      weeklySummary(),
                      new Divider(
                        height: MediaQuery.of(context).size.height * 0.033,
                      ),

                      Padding(
                        padding: EdgeInsets.all(0),
                        child: MaterialButton(
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            minWidth: double.infinity,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Transaction()),
                              );
                            },
                            child: Text(
                              "New Transaction",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20.0,
                                  fontFamily: "WorkSansBold"),
                            )),
                      )
                    ],
                  ),
                )),
          ),
        ));
  }

  Widget recentTransactionsWidget() {
    return Expanded(
      child: Card(
        elevation: 15,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Recent Transactions",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            // ListView(
            //   shrinkWrap: true,
            //   children: <Widget>[
            //     ListTile(
            //       title: Text("Timestamp - Amount - Payment Mode"),
            //     )
            //   ],
            // ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Table(
                border: TableBorder(horizontalInside: BorderSide()),
                columnWidths: {
                  1: FlexColumnWidth(0.5),
                  2: FlexColumnWidth(0.5),
                  3: FlexColumnWidth()
                },
                children: [
                  TableRow(children: [
                    TableCell(
                      child: Text(
                        "Time",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        "Amount",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        "Payment Mode",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    TableCell(
                      child: Text("03 May 2019 6:03 PM"),
                    ),
                    TableCell(
                      child: Text("120"),
                    ),
                    TableCell(
                      child: Text("PayTM"),
                    ),
                  ]),
                  TableRow(children: [
                    TableCell(
                      child: Text("03 May 2019 5:33 PM"),
                    ),
                    TableCell(
                      child: Text("65"),
                    ),
                    TableCell(
                      child: Text("G Pay"),
                    ),
                  ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget weeklySummary() {
    return Card(
        elevation: 15,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(children: <Widget>[
          Text(
            "Weekly statistics",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
          new Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.21,
                width: MediaQuery.of(context).size.width / 1.2,
                child: last7daysbarchart(),
              ),
              new Divider(
                height: MediaQuery.of(context).size.height / 7.75,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.21,
                width: MediaQuery.of(context).size.width / 1.2,
                child: last7dayspiechart(),
              ),
            ],
          ),
        ]));
  }

  Widget last7daysbarchart() {
    List<charts.Series> seriesList = _getBarPlotData();
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }

  List<charts.Series<WeeklySales, String>> _getBarPlotData() {
    final data = [
      new WeeklySales(day7, trans_d6.round()),
      new WeeklySales(day6, trans_d5.round()),
      new WeeklySales(day5, trans_d4.round()),
      new WeeklySales(day4, trans_d3.round()),
      new WeeklySales(day3, trans_d2.round()),
      new WeeklySales(day2, sales_prev_day.round()),
      new WeeklySales(day1, sales_today.round()),
    ];

    return [
      new charts.Series<WeeklySales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (WeeklySales sales, _) => sales.day,
        measureFn: (WeeklySales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  Widget last7dayspiechart() {
    List<charts.Series> seriesList = _getPieChartData();
    return new charts.PieChart(seriesList,
        animate: true,
        defaultRenderer: new charts.ArcRendererConfig(arcWidth: 20,
            //startAngle: 4 / 5 * pi,
            //arcLength: 7 / 5 * pi,
            arcRendererDecorators: [
              new charts.ArcLabelDecorator(
                  labelPosition: charts.ArcLabelPosition.auto)
            ]));
  }

  List<charts.Series<GaugeSegment, String>> _getPieChartData() {
    final data = [
      new GaugeSegment('G Pay', mode_gpay.round()),
      new GaugeSegment('PayTM', mode_paytm.round()),
      new GaugeSegment('Cash', mode_cash.round()),
      new GaugeSegment('Others', mode_other.round()),
      new GaugeSegment('PhonePe', mode_phonepe.round()),
      new GaugeSegment('Card', mode_card.round()),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
        id: 'Amount',
        domainFn: (GaugeSegment segment, _) => segment.payMode,
        measureFn: (GaugeSegment segment, _) => segment.amount,
        data: data,
        labelAccessorFn: (GaugeSegment segment, _) =>
            '${segment.payMode}: ${segment.amount}',
      )
    ];
  }

  Widget viewMore() {
    return Expanded(
        flex: 1,
        child: Card(
            elevation: 15,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: FlatButton(
                child: Text(
                  "More Info",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Report()),
                      )
                    },
              ),
            )));
  }

  getTransactions() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final firestore.CollectionReference transactRef = firestore
        .Firestore.instance
        .collection('user')
        .document(user.uid)
        .collection('transaction');
    transactRef
        .where("timestamp",
            isGreaterThanOrEqualTo:
                DateTime.now().subtract(new Duration(days: 7)))
        .snapshots()
        .listen((data) => processData(data));
  }

  processData(firestore.QuerySnapshot data) {
    print("Processing data");
    double trans_yest = 0;
    double trans_today = 0;
    double trans_d2 = 0;
    double trans_d3 = 0;
    double trans_d4 = 0;
    double trans_d5 = 0;
    double trans_d6 = 0;
    double mode_gpay = 0;
    double mode_paytm = 0;
    double mode_phonepe = 0;
    double mode_cash = 0;
    double mode_card = 0;
    double mode_other = 0;

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(new Duration(days: 1));
    DateTime d2 = yesterday.subtract(new Duration(days: 2));
    DateTime d3 = yesterday.subtract(new Duration(days: 3));
    DateTime d4 = yesterday.subtract(new Duration(days: 4));
    DateTime d5 = yesterday.subtract(new Duration(days: 5));
    ;
    DateTime d6 = yesterday.subtract(new Duration(days: 6));
    for (var doc in data.documents) {
      firestore.Timestamp ts = doc["timestamp"];
      if (ts.toDate().isAfter(today)) {
        trans_today += doc["amount"];
      } else if (ts.toDate().isAfter(yesterday)) {
        trans_yest += doc["amount"];
      } else if (ts.toDate().isAfter(d2)) {
        trans_d2 += doc["amount"];
      } else if (ts.toDate().isAfter(d3)) {
        trans_d3 += doc["amount"];
      } else if (ts.toDate().isAfter(d4)) {
        trans_d4 += doc["amount"];
      } else if (ts.toDate().isAfter(d5)) {
        trans_d5 += doc["amount"];
      } else if (ts.toDate().isAfter(d6)) {
        trans_d6 += doc["amount"];
      }
      if (doc["mode"] == "PayTm") {
        mode_paytm += doc["amount"];
      } else if (doc["mode"] == "PhonePe") {
        mode_phonepe += doc["amount"];
      } else if (doc["mode"] == "Gpay") {
        mode_gpay += doc["amount"];
      } else if (doc["mode"] == "Cash") {
        mode_cash += doc["amount"];
      } else if (doc["mode"] == "Card") {
        mode_card += doc["amount"];
      } else if (doc["mode"] == "Other") {
        mode_other += doc["amount"];
      }
    }
    print("Today=" + trans_today.toString());
    print("Yesterday=" + trans_yest.toString());
    final weeks = ['M','Tu','W','Th','F','Sa','Su'];
    setState(() {
      sales_prev_day = trans_yest;
      sales_today = trans_today;
      this.mode_card = mode_card;
      this.mode_cash = mode_cash;
      this.mode_paytm = mode_paytm;
      this.mode_phonepe = mode_phonepe;
      this.mode_gpay = mode_gpay;
      this.mode_other = mode_other;
      this.trans_d2 = trans_d2;
      this.trans_d3 = trans_d3;
      this.trans_d4 = trans_d4;
      this.trans_d5 = trans_d5;
      this.trans_d6 = trans_d6;
      day1 = weeks[today.weekday-1];
      day2 = weeks[yesterday.weekday-1];
      day3 = weeks[d2.weekday-1];
      day4 = weeks[d3.weekday-1];
      day5 = weeks[d4.weekday-1];
      day6 = weeks[d5.weekday-1];
      day7 = weeks[d6.weekday-1];
    });
  }
}

class GaugeSegment {
  final String payMode;
  final int amount;
  GaugeSegment(this.payMode, this.amount);
}

class WeeklySales {
  final String day;
  final int sales;
  WeeklySales(this.day, this.sales);
}
