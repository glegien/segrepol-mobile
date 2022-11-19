import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Trash {
  int _id;
  String name;
  String description;
  String path;

  Trash(this._id, this.name, this.description, this.path);

  Card buildCard() {
    return  Card(
      child: Column(
        children: [
          Image(
            image: NetworkImage(path),
          ),
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
    List<Trash> result = List.empty();
    for(var el in json.entries) {
      log(el.toString());
      result.add(Trash(el.value['userId'], el.value['name'], 'description', 'path'));
    }
    return result;
  }
}
