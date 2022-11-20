import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:segrepol/init.dart';
import 'package:segrepol/menu_overlay.dart';
import 'package:segrepol/model/ChatModel.dart';

class ChatView extends StatefulWidget {
  @override
  State<ChatView> createState() => _MyChatView();
}

class _MyChatView extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: OverlayMenu(),
      body: ListView(
        children: [_list()],
      ),
    );
  }

  Future<List<ChatModel>> _loadEmojiAsList() async {
    final response = await http.get(Uri.parse(
        'https://europe-central2-segrepol-b80d8.cloudfunctions.net/getChats?userId=' +
            Init.deviceId!));
    Map<String, dynamic> json = jsonDecode(response.body);
    return ChatModel.fromJson(json);
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
                      onTap: () {
                        debugPrint("clicked kart");
                      },
                      child: SizedBox(
                          width: 300,
                          height: 100,
                          child: Text(snapshot.data[index].itemName))),
                ),
              );
            });
      },
      future: _loadEmojiAsList(),
    );
  }
}
