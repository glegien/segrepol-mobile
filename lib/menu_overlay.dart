import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:segrepol/actionRow/floating_action_row.dart';
import 'package:segrepol/actionRow/floating_action_row_button.dart';
import 'package:segrepol/add_image.dart';
import 'package:segrepol/main.dart';

import 'actionRow/floating_action_row_divider.dart';

class OverlayMenu extends StatelessWidget {
  onPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MyHomePage(title: "title"),
    ));
    log("message");
  }

  onPressed2() {

    log("dupa123");
  }

  onPressed3(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ImageAdder(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 10),
      child: FloatingActionRow(height: 100, children: [
        FloatingActionRowButton(
            color: Colors.white,
            foregroundColor: Colors.black,
            icon: Icon(size: 40, Icons.shopping_basket),
            onTap: () => onPressed(context)),
        FloatingActionRowDivider(),
        FloatingActionRowButton(
            color: Colors.white,
            foregroundColor: Colors.black,
            icon: Icon(size: 40, Icons.question_answer),
            onTap: () => onPressed2()),
        FloatingActionRowDivider(),
        FloatingActionRowButton(
            color: Colors.white,
            foregroundColor: Colors.black,
            icon: Icon(size: 40, Icons.add_circle_outline),
            onTap: () => onPressed3(context)),
      ]),
    );
  }
}
