import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_storage_path/flutter_storage_path.dart';
import 'package:segrepol/FileModel.dart';
import 'package:segrepol/add_description_view.dart';
import 'package:segrepol/menu_overlay.dart';

class ImageAdder extends StatefulWidget {
  const ImageAdder({super.key});

  @override
  State<ImageAdder> createState() => _MyImageAdder();
}

class _MyImageAdder extends State<ImageAdder> {
  List<FileModel>? files;
  FileModel? selectedModel;
  String? image;

  @override
  void initState() {
    super.initState();
    getImagesPath();
  }

  getImagesPath() async {
    var imagePath = await StoragePath.imagesPath;
    var images = jsonDecode(imagePath!) as List;
    files = images.map<FileModel>((e) => FileModel.fromJson(e)).toList();
    if (files != null && files!.isNotEmpty) {
      setState(() {
        selectedModel = files![0];
        image = files![0].files[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: OverlayMenu(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: const Icon(Icons.navigate_next),
                    iconSize: 50,
                    onPressed: () => doSmth(),
                  ),
                )
              ],
            ),
            Divider(),
            Container(
                height: MediaQuery.of(context).size.height * 0.45,
                child: image != null
                    ? Image.file(File(image!),
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width)
                    : Container()),
            Divider(),
            selectedModel == null || selectedModel!.files.length < 1
                ? Container(
                    child: Text(
                      "NIE MA ZDJEC W GALERII Grzesiu",
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4),
                        itemBuilder: (_, i) {
                          var file = selectedModel?.files[i];
                          return GestureDetector(
                            child: Image.file(
                              File(file!),
                              fit: BoxFit.cover,
                            ),
                            onTap: () {
                              setState(() {
                                image = file;
                              });
                            },
                          );
                        },
                        itemCount: selectedModel?.files.length),
                  )
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<FileModel>>? getItems() {
    return files
        ?.map((e) => DropdownMenuItem(
              child: Text(
                e.folder,
                style: TextStyle(color: Colors.black),
              ),
              value: e,
            ))
        .toList();
  }

  doSmth() {
    if (image == null) {
      return;
    }
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AddDescription(image!),
    ));

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const Text("asd")),
    // );
  }
}
