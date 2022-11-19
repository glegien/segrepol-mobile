import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Trash {
  int _id;
  String name;
  String description;
  String path;

  Trash(this._id, this.name, this.description, this.path);

  Container buildCard() {
    return Container(
        child: Card(
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
    ));
  }
}
