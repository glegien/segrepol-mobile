import 'dart:convert';
import 'dart:developer';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:segrepol/menu_overlay.dart';

import 'init.dart';
import 'model.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hubka',
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(
              title: 'SEGREPOL',
            ),
        //'/chat': (context) => new ChatPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  final Future _initFuture = Init.initialize();
  final Future _fetchTrashes = initialize();

  static List<Trash>? trashList;

  static Future initialize() async {
    await fetchTrashes();
  }

  static fetchTrashes() async {
    await Init.initialize();
    log('https://europe-central2-segrepol-b80d8.cloudfunctions.net/getOthersItems?userId=' +
        Init.deviceId!);
    final response = await http.get(Uri.parse(
        'https://europe-central2-segrepol-b80d8.cloudfunctions.net/getOthersItems?userId=' +
            Init.deviceId!));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> json = jsonDecode(response.body);
      trashList = Trash.fromJson(json);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load TRASHES!!!');
    }
  }

  static fetchMoreTrashes() async {
    final response = await http.get(Uri.parse(
        'https://europe-central2-segrepol-b80d8.cloudfunctions.net/getOthersItems?userId=' +
            Init.deviceId!));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> json = jsonDecode(response.body);
      trashList!.insertAll(0, Trash.fromJson(json));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load TRASHES!!!');
    }
  }

  List<Card> buildCards(BuildContext context) {
    List<Card> list = List.empty(growable: true);
    for (Trash el in trashList!) {
      list.add(el.buildCard(context));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: OverlayMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    Text(
                      "SEGREPOL",
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: "Anton",
                          fontSize: MediaQuery.of(context).size.height * 0.07,
                          shadows: const [
                            Shadow(color: Colors.black, blurRadius: 4)
                          ]),
                    )
                  ],
                ) // lower menu
                ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.72,
                child: FutureBuilder(
                    future: _fetchTrashes,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AppinioSwiper(
                          cards: buildCards(context),
                          onSwipe: _swipe,
                          onEnd: () => setState(() {
                            fetchMoreTrashes();
                          }),
                        );
                      } else {
                        return const Text("LOADING...");
                      }
                    })),
          ],
        ),
      ),
    );
  }

  void _swipe(int index, AppinioSwiperDirection direction) {
    log("the card was swiped to the: " + direction.name);
    if (direction == AppinioSwiperDirection.right) {
      // Open the chat
      Map<String, String> map = {
        'itemId': trashList![index].id,
        'buyerId': Init.deviceId!
      };
      http.post(
          Uri.parse(
              'https://europe-central2-segrepol-b80d8.cloudfunctions.net/createChat'),
          body: map);
    } else {
      // Nothing, just go to the next
      log('INDEX:' + index.toString());
      log('LEN:' + trashList!.length.toString());
    }
  }
}
