import 'package:flutter/material.dart';
import 'package:segrepol/actionRow/floating_action_row.dart';
import 'package:segrepol/actionRow/floating_action_row_button.dart';
import 'package:segrepol/add_image.dart';
import 'package:segrepol/chat_view.dart';
import 'package:segrepol/main.dart';

import 'actionRow/floating_action_row_divider.dart';

class OverlayMenu extends StatelessWidget {
  onPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MyHomePage(title: "title"),
    ));
  }

  onPressed2(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ChatView(),
    ));
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
            onTap: () => onPressed2(context)),
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
