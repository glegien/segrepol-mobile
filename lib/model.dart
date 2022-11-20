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
        //mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            child: Image(
              image: Image.memory(base64Decode(imageStr)).image,
            ),
            height: MediaQuery.of(context).size.height * 0.30,
          ),
          SizedBox(
              //width: MediaQuery.of(context).size.width * 0.9,
              //height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(name,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Anton",
                    fontSize: MediaQuery.of(context).size.height * 0.04,
                  )),
              Text(description,
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: "Anton",
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                  )),
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
