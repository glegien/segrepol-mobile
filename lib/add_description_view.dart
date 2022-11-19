import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddDescription extends StatefulWidget {
  final String imageString;

  const AddDescription(this.imageString, {super.key});

  @override
  State<AddDescription> createState() => _MyDescriptionAdapter();
}

class _MyDescriptionAdapter extends State<AddDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child:
                TextField(decoration: InputDecoration(labelText: "Add Title")),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
                decoration: InputDecoration(labelText: "Description")),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.green[200],
                  textStyle: const TextStyle(fontSize: 30)),
              child: const Text("Share"),
              onPressed: () => sendImage(),
            ),
          ),
        ],
      ),
    ));
  }

  sendImage() {}
}
