import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:adv_async_widget/adv_async_widget.dart';

void main() {
  testWidgets('AdvFutureBuilder without future show onData with data null', (WidgetTester tester) async {
    // Create the widget
    await materialAppTest(tester, AdvFutureBuilder(
        onData: (context, data) => Text(getDataText(data))
    ));

    // Create the Finder
    final expectedData = null;
    final dataFinder = find.text(getDataText(expectedData));

    // verify that the Text widgets appear exactly once in the widget tree
    expect(dataFinder, findsOneWidget);
  });
  //TODO: add test to check waiting future
  //TODO: add test to check future with error
  //TODO: add test to check future with data

  //TODO: add test to check missing stream
  //TODO: add test to check waiting stream
  //TODO: add test to check stream with error
  //TODO: add test to check stream with data
}

String getDataText(data) => "data:$data";

Future<void> materialAppTest(tester, widget) => tester.pumpWidget(MaterialApp(
  home: widget,
));
