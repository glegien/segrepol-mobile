import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:segrepol/init.dart';
import 'package:segrepol/model/ConservationModel.dart';

class Conservation extends StatefulWidget {
  String chatId;

  Conservation(this.chatId, {super.key});

  @override
  State<Conservation> createState() => _ConservationState();
}

class _ConservationState extends State<Conservation> {
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Timer.periodic(Duration(seconds: 5), (Timer t) => setState((){}));
    return Scaffold(
      // body: SafeArea(child: _list()),
      body: Stack(
        children: [
          _list(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () => sendMessage(),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.green,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
                title: Container(
                  height: 50,
                  child: snapshot.data[index].senderId == Init.deviceId!
                      ? userCard(snapshot, index)
                      : enemyCard(snapshot, index),
                ),
              );
            });
      },
      future: _loadEmojiAsList(),
    );
  }

  Card userCard(AsyncSnapshot<dynamic> snapshot, int index) {
    return Card(
        color: Colors.green,
        child: Text(
          snapshot.data[index].message, style: TextStyle(fontSize: 22),));
  }

  Card enemyCard(AsyncSnapshot<dynamic> snapshot, int index) {
    return Card(
        color: Colors.red,
        child: Text(
          snapshot.data[index].message, style: TextStyle(fontSize: 22),));
  }

  sendMessage() async {
    final response = await http.post(
        Uri.parse(
            'https://europe-central2-segrepol-b80d8.cloudfunctions.net/sendMessage'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "chatId": widget.chatId,
          "message": titleController.text.toString(),
          "senderId": Init.deviceId!
        }));
    if (response.statusCode == 200) {
      setState(() {});
    }
  }
}
