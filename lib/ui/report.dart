import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_app/style/theme.dart' as Theme;
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Report extends StatefulWidget {
  @override
  _ReportState createState() {
    return new _ReportState();
  }
}

class _ReportState extends State<Report> {
  final formats = {
    InputType.both: DateFormat("d MMMM yyyy, h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };
  DateTime start_date;
  DateTime end_date;
  InputType inputType = InputType.both;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height < 600
              ? 600
              : MediaQuery.of(context).size.height - 130,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: DateTimePickerFormField(
                          inputType: inputType,
                          format: formats[inputType],
                          editable: true,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              labelText: 'Start date and time',
                              hasFloatingPlaceholder: false),
                          onChanged: (dt) => setState(() => start_date = dt),
                        ),
                      )),
                ),
                Card(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: DateTimePickerFormField(
                          inputType: inputType,
                          format: formats[inputType],
                          editable: true,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              labelText: 'End date and time',
                              hasFloatingPlaceholder: false),
                          onChanged: (dt) => setState(() => end_date = dt),
                        ),
                      )),
                ),
                transactionsWidget(),
                // piechart(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget transactionsWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
      ),
      child: new Container(
        height: MediaQuery.of(context).size.height / 1.63,
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
                "Transactions",
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
      ),
    );
  }

  Widget piechart() {
    return Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(children: <Widget>[
          Text(
            "Payment type distribution",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 150.0,
            width: MediaQuery.of(context).size.width / 1.05,
            child: last7dayspiechart(),
          ),
        ]));
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
}

class GaugeSegment {
  final String payMode;
  final int amount;
  GaugeSegment(this.payMode, this.amount);
}
