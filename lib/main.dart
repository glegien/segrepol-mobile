import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:segrepol/chat.dart';
import 'package:segrepol/menu.dart';
import 'package:http/http.dart' as http;

import 'init.dart';
import 'dart:ui';

import 'model.dart';

void main() async {
  runApp(const MyApp());
}

List<Card> cards =
[
 Card(
    child: Column(
      children: [
        const Image(
          image: NetworkImage(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
        ),
        SizedBox(
            //width: screenSize.width / 1.2,
            //height: screenSize.height / 1.7 - screenSize.height / 2.2,
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Stara sowa"
            ),
            Text(
              "Oddam starą sową za darmo. Czasem lata..."
            ),
          ],
        ))
      ],
    ),
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(
              title: 'AAAA',
            ),
        '/chat': (context) => ChatPage(),
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
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

Future<List<Trash>> fetchTrashes() async {
  final response = await http.get(Uri.parse(
      'https://europe-central2-segrepol-b80d8.cloudfunctions.net/getOthersItems?userId=dupa'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map<String, dynamic> json = jsonDecode(response.body);
    List<Trash> result = Trash.fromJson(json);
    return result;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  final Future _initFuture = Init.initialize();
  final Future _fetchTrasches = fetchTrashes();

  List<Card> fetchTrashes2() {
    List<Card> list = List.empty();
    _fetchTrasches
        .then((value) => () {
      for (Trash el in value) {
        list.add(el.buildCard());
      }
      log(list.toString());
      return list;
    })
        .catchError((error) => () {
      list.add(Card());
      return list;
    });
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          leading: CircleAvatar(
            backgroundColor: Colors.brown.shade800,
            child: FutureBuilder(
                future: _initFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(Init.deviceId!);
                  } else {
                    return const Text("LOADING...");
                  }
                }),
          )),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: FutureBuilder(
                  future: _fetchTrasches,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return AppinioSwiper(
                                cards: fetchTrashes2(),
                                onSwipe: _swipe,
                              );
                    } else {
                      return const Text("LOADING...");
                    }
                  })
          // child: AppinioSwiper(
          //       cards: fetchTrashes2(),
          //       onSwipe: _swipe,
          //     ),
            ),
            SizedBox(child: Row() // lower menu
                )
          ],
        ),
      ),
    );
  }

  void _swipe(int index, AppinioSwiperDirection direction) {
    log("the card was swiped to the: " + direction.name);
    if (direction == AppinioSwiperDirection.right) {
      // Open the chat
      Navigator.pushNamed(context, '/chat');
    } else {
      // Nothing, just go to the next
    }
  }
}
