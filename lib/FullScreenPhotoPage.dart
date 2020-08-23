import 'package:flutter/material.dart';

class FullScreenPhotoPage extends StatelessWidget {
  String image;

  FullScreenPhotoPage(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo"),
      ),
      body: Container(
        child: Image.network(image),
      ),
    );
  }
}
