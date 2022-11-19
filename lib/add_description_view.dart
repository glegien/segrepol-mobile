import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:segrepol/menu_overlay.dart';

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
        floatingActionButton: OverlayMenu(),
        body: Center(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                                height: 200,
                                child: getImage(widget.imageString)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: const [
                            SizedBox(
                              height: 200,
                              child: TextField(
                                  decoration:
                                      InputDecoration(labelText: "Add Title")),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                  decoration: InputDecoration(
                                      labelText: "Description")),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
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

  getImage(String imageString) {
    return Image.file(File(imageString),
        height: MediaQuery.of(context).size.height * 0.45,
        width: MediaQuery.of(context).size.width);
  }
}
