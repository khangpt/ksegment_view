import 'package:flutter/material.dart';
import 'package:ksegment_view/segment/segment_flip_card.dart';
import 'package:ksegment_view/segment/segment_pos.dart';
import 'package:ksegment_view/segment/segment_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: KSegmentView(
            ['Left', 'Right'],
            (_, isLeft, angle) {
              return SegmentFlipCard(
                isLeft ? 'Left' : 'Right',
                pos: isLeft ? SegmentPos.left : SegmentPos.right,
                angle: angle,
                borderRadius: 50,
                cardBgColor: Colors.blueGrey,
                titleStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
            boundary: Size(200, 80),
            onChanged: (pos) {
              print('+ changed to : $pos');
            },
            backgroundColor: Colors.blue.shade300,
            borderColor: Colors.blueGrey,
            borderRadius: 50,
            borderThick: 5,
            initialSelected: SegmentPos.left,
            titleStyle: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
