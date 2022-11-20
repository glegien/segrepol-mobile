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

  Card buildCard() {
    return Card(
      child: Column(
        children: [
          Image(image: Image.memory(base64Decode(imageStr)).image),
          SizedBox(
              //width: screenSize.width / 1.2,
              //height: screenSize.height / 1.7 - screenSize.height / 2.2,
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(name),
              Text(description),
            ],
          ))
        ],
      ),
    );
  }

  static List<Trash> fromJson(Map<String, dynamic> json) {
    List<Trash> result = List.empty(growable:true);
    for (var el in json['result']) {
      log(el.toString());
      result.add(Trash(el['id'], el['name'], el['description'], el['userId'], el['image']));
    }
    return result;
  }
}
