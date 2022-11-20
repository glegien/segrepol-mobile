import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Trash {
  String id;
  String name;
  String description;
  String userId;
  String imageStr;

  Trash(this.id, this.name, this.description, this.userId, this.imageStr);

  Card buildCard(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            child: Image(
              image: Image.memory(base64Decode(imageStr)).image,
            ),
            height: MediaQuery.of(context).size.height * 0.40,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          SizedBox(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(15), //apply padding to all four sides
                  child: Text(name,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Anton",
                        fontSize: MediaQuery.of(context).size.height * 0.04,
                      ))),
              Padding(
                  padding: EdgeInsets.all(15), //apply padding to all four sides
                  child: Text(description,
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: "Anton",
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                      ))),
            ],
          ))
        ],
      ),
    );
  }

  static List<Trash> fromJson(Map<String, dynamic> json) {
    List<Trash> result = List.empty(growable: true);
    for (var el in json['result']) {
      log(el.toString());
      result.add(Trash(
          el['id'], el['name'], el['description'], el['userId'], el['image']));
    }
    return result;
  }
}
