import 'package:flutter/material.dart';

class FullScreenPhotoPage extends StatelessWidget {
  String imageUrl;

  FullScreenPhotoPage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo"),
      ),
      body: Container(
        child: Image.network(imageUrl,
        fit: BoxFit.fill,),
      ),
    );
  }
}
