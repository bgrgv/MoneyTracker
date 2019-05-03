import 'package:flutter/material.dart';
import 'package:flutter_app/style/theme.dart' as Theme;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/ui/report.dart';
import 'dart:math';

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

  void _onSyncStateChange(bool value) => setState(() => sync_state = value);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
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
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Card(
                            elevation: 5,
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
                                  "₹" + sales_prev_day.toString(),
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
                            elevation: 5,
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
                                  "₹" + sales_today.toString(),
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
                    recentTransactionsWidget(),
                    weeklySummary(),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[syncStatus(), viewMore()],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: MaterialButton(
                          padding: EdgeInsets.only(top: 12, bottom: 12),
                          minWidth: double.infinity,
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "New Transaction",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontFamily: "WorkSansBold"),
                          )),
                    )
                  ],
                ),
              )),
        ));
  }

  Widget recentTransactionsWidget() {
    return Expanded(
      child: Card(
        elevation: 5,
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
        elevation: 5,
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
          Row(
            children: <Widget>[
              SizedBox(
                height: 150.0,
                width: MediaQuery.of(context).size.width / 2.05,
                child: last7daysbarchart(),
              ),
              SizedBox(
                height: 150.0,
                width: MediaQuery.of(context).size.width / 2.05,
                child: last7dayspiechart(),
              ),
            ],
          )
        ]));
  }

  Widget last7daysbarchart() {
    final List<charts.Series> seriesList = _getBarPlotData();
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }

  static List<charts.Series<WeeklySales, String>> _getBarPlotData() {
    final data = [
      new WeeklySales('M', 5),
      new WeeklySales('Tu', 25),
      new WeeklySales('W', 100),
      new WeeklySales('Th', 75),
      new WeeklySales('F', 75),
      new WeeklySales('Sa', 75),
      new WeeklySales('Su', 75),
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
    final List<charts.Series> seriesList = _getPieChartData();
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

  static List<charts.Series<GaugeSegment, String>> _getPieChartData() {
    final data = [
      new GaugeSegment('G Pay', 75),
      new GaugeSegment('PayTM', 100),
      new GaugeSegment('Cash', 50),
      new GaugeSegment('Others', 5),
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

  Widget syncStatus() {
    return Expanded(
        flex: 2,
        child: Card(
            elevation: 5,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Sync to cloud",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Switch(
                      value: sync_state,
                      onChanged: _onSyncStateChange,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Last Synced: 05 May 2019 5:56 PM"),
                )
              ],
            )));
  }

  Widget viewMore() {
    return Expanded(
        flex: 1,
        child: Card(
            elevation: 5,
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
