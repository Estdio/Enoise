import 'dart:math';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enoise',
      home: MyHomePage(title: 'Enoise'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _httpcontent = '';
  bool _booltoggle = false;
  var _urllist = [
    "https://wedoaliltrollin.com/",
    "https://twitter.com/",
    "https://4chan.org",
    "https://www.reddit.com",
    "https://www.yahoo.com",
    "https://www.cnn.com",
    "https://www.ebay.com",
    "https://wikipedia.org",
    "https://youtube.com",
    "https://github.com/smokeytube",
    "https://medium.com",
    "https://flutter.dev/",
    "https://forum.hackthebox.eu/profile/xeno503",
    "https://github.com/Estdio",
    "https://www.youtube.com/",
    "https://www.roblox.com/"
  ];

  void makerequest() async {
    final _random = new Random();
    String requrl = _urllist[_random.nextInt(_urllist.length)];
    try {
      var r = await Requests.get(requrl);
      r.raiseForStatus();
      _httpcontent = "[200] " + requrl;
    } catch (TimeoutException) {
      _httpcontent = "[408] TimeoutException: " + requrl;
    }
  }

  void requesttoggle() {
    if (_booltoggle) {
      _booltoggle = false;
    } else {
      _booltoggle = true;
    }
  }

  void updatescreen() async {
    _booltoggle = true;
    while (_booltoggle) {
      setState(() {
        makerequest();
      });
      await Future.delayed(Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Color.fromRGBO(25, 25, 25, 1),
        ),
        home: Scaffold(
            appBar: AppBar(title: Text('Enoise')),
            body: Center(
              child: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/E.png"),
                        fit: BoxFit.scaleDown)),
                child: Center(
                  child: Container(
                    color: Color.fromRGBO(255, 255, 255, 0.8),
                    child: Text(
                      _httpcontent,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: Container(
                child: Container(
                    alignment: Alignment.bottomCenter,
                    padding:
                        EdgeInsets.only(left: (width / 3), right: (width / 3)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ElevatedButton(
                            onPressed: updatescreen,
                            child: Icon(Icons.network_cell),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ElevatedButton(
                            onPressed: requesttoggle,
                            child: Icon(Icons.stop_circle_outlined),
                          ),
                        ),
                      ],
                    )))));
  }
}
