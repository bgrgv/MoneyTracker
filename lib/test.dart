import 'package:flutter/material.dart';

void main() {
  runApp(testScreen(
    items: List<String>.generate(10000, (i) => "Item $i"),
  ));
}

class testScreen extends StatelessWidget {
  final List<String> items;

  testScreen({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Long List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),

        //------------------------

        body: Column(
          children: <Widget>[
            new Text("sdfsdf"),
            new Container(
              alignment: Alignment.center,
              child: new Container(
                padding: EdgeInsets.only(top: 90.0,left: 60.0),
                height: 350.0,
                width: 200.0,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${items[index]}'),
                    );
                  },
                ),
              ),
            ),
          ],
        ),

        //-----------------------
      ),
    );
  }
}
