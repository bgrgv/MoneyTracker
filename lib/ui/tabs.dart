import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'summary.dart';
import 'report.dart';

class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: new Icon(FontAwesomeIcons.chartArea)),
                Tab(icon: new Icon(FontAwesomeIcons.chartBar))
              ],
            ),
            title: Text('MoneyTracker'),
          ),
          body: TabBarView(
            children: [
              Summary(),
              Report(),
            ],
          ),
        ),
      ),
    );
  }
}
