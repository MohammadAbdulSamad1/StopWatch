import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Stopwatch _stopwatch;
  late Timer t;
  late String millisec;
  late String second;
  late String minutes;
  List laps = [];
  void handleStopWatch() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }
  }

  String formattedString() {
    var milli = _stopwatch.elapsed.inMilliseconds;
    var sec = _stopwatch.elapsed.inSeconds;
    var min = _stopwatch.elapsed.inMinutes;

    millisec = (milli % 1000).toString().padLeft(3, '0');
    second = ((milli ~/ 1000) % 60).toString().padLeft(2, '0');
    minutes = (((milli ~/ 1000) ~/ 60) % 60).toString().padLeft(2, '0');
    return "$minutes:$second:$millisec";
  }

  listLap() {
    laps.add("$minutes:$second:$millisec");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stopwatch = Stopwatch();
    t = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    double widthOfscreen = MediaQuery.of(context).size.width;
    double heightOfscreen = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('StopWatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.brown,
              radius: heightOfscreen * .17,
              child: Text(
                '${formattedString()}',
                style: TextStyle(
                    fontSize: heightOfscreen * .04, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                        borderRadius:
                            BorderRadius.circular(heightOfscreen * .2)),
                    child: TextButton(
                        onPressed: () {
                          _stopwatch.stop();
                          _stopwatch.reset();
                        },
                        child: Text(
                          'Reset',
                          style: TextStyle(
                              fontSize: heightOfscreen * .027,
                              color: Colors.red),
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                        borderRadius:
                            BorderRadius.circular(heightOfscreen * 1)),
                    child: TextButton(
                        onPressed: () {
                          // handleStopWatch();
                          _stopwatch.start();
                        },
                        child: Text(
                          'Start',
                          style: TextStyle(
                              fontSize: heightOfscreen * .027,
                              color: Colors.red),
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                        borderRadius:
                            BorderRadius.circular(heightOfscreen * .2)),
                    child: TextButton(
                        onPressed: () {
                          _stopwatch.stop();
                        },
                        child: Text(
                          'Stop',
                          style: TextStyle(
                              fontSize: heightOfscreen * .027,
                              color: Colors.red),
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                        borderRadius:
                            BorderRadius.circular(heightOfscreen * .2)),
                    child: TextButton(
                        onPressed: () {
                          listLap();
                        },
                        child: Text(
                          'Lap',
                          style: TextStyle(
                              fontSize: heightOfscreen * .027,
                              color: Colors.red),
                        )),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  width: widthOfscreen,
                  height: heightOfscreen * .46,
                  color: Colors.amber,
                  child: ListView.builder(
                      itemCount: laps.length,
                      itemBuilder: (context, index) {
                        return Text('${laps[index]}');
                      }),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: widthOfscreen * .25,
                    height: heightOfscreen * .08,
                    // color: Colors.black,
                    child: TextButton(
                        onPressed: () {
                          laps.clear();
                        },
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.black,
                          size: (heightOfscreen / widthOfscreen) * 20,
                        )),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
