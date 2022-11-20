import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:segrepol/model/ConservationModel.dart';

class Conservation extends StatefulWidget {
  String chatId;

  Conservation(this.chatId, {super.key});

  @override
  State<Conservation> createState() => _ConservationState();
}

class _ConservationState extends State<Conservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _list(),
    );
  }

  Future<List<ConservationModel>> _loadEmojiAsList() async {
    final response = await http.get(Uri.parse(
        'https://europe-central2-segrepol-b80d8.cloudfunctions.net/getMessages?chatId=' +
            widget.chatId));
    debugPrint("response message " + response.body);
    Map<String, dynamic> json = jsonDecode(response.body);
    return ConservationModel.fromJson(json);
  }

  Widget _list() {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            !snapshot.hasData) {
          return Text('No Chat yet');
        }
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data != null ? snapshot.data.length : 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Card(
                  child: InkWell(
                      splashColor: Colors.green,
                      child: SizedBox(
                          width: 300,
                          height: 100,
                          child: Text(snapshot.data[index].message))),
                ),
              );
            });
      },
      future: _loadEmojiAsList(),
    );
  }
}
