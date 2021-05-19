import 'package:adv_async_widget/adv_async_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

const TITLE = "AdvAsyncWidget Demo";

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  Future<String> exampleFuture;

  @override
  void initState() {
    super.initState();
    exampleFuture = Future.delayed(Duration(seconds: 5), () => "FINISHED");
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: TITLE,
    home: Scaffold(
      appBar: AppBar(
        title: Text(TITLE),
      ),
      body: AdvFutureBuilder<String>(
        future: exampleFuture,
        onWait: (context) => CircularProgressIndicator(),
        onData: (context, data) => Text(data),
      ),
    ),
  );
}
