import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'summary.dart';
import 'report.dart';

class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: new Icon(FontAwesomeIcons.chartArea)),
                Tab(icon: new Icon(FontAwesomeIcons.chartBar))
              ],
            ),
            title: Text('MoneyTracker'),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height < 420
                ? 420
                : MediaQuery.of(context).size.height,
            child: new TabBarView(
              children: [
                Summary(),
                Report(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
