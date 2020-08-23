import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_photo_app/FullScreenPhotoPage.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(UnsplashPhotoViewer());
}

class UnsplashPhotoViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Unsplash Photos",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhotoLIstPage(),
    );
  }
}

class PhotoLIstPage extends StatefulWidget {
  PhotoLIstPage({Key key}) : super(key: key);

  @override
  _PhotoLIstPageState createState() => _PhotoLIstPageState();
}

class _PhotoLIstPageState extends State<PhotoLIstPage> {
  List widgets = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    bool isLOading = true;
    return Scaffold(
      appBar: AppBar(
        title: Text("Unsplash Photos"),
      ),
      body: widgets.length > 0
          ? ListView.builder(
              itemCount: widgets.length,
              itemBuilder: (BuildContext context, int position) {
                return getItem(position);
              })
          : Container(
        alignment: Alignment.center,
          child: const Text("No items")),
    );
  }

  Widget getItem(int i) {
    return Padding(padding: EdgeInsets.all(10.0), child: itemSchema(i));
  }

  loadData() async {
    String dataURL =
        "https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0";
    try {
      http.Response response = await http.get(dataURL);
      setState(() {
        widgets = json.decode(response.body);
      });
    } catch (e) {}
  }

  Widget itemSchema(int i) {
    String imageUrl = widgets[i]["urls"]["regular"];
    String authorName = widgets[i]["user"]["name"];
    String title =
        widgets[i]["description"] != null ? widgets[i]["description"] : "";
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FullScreenPhotoPage(imageUrl)),
              );
            },
            child: Image.network(
              imageUrl,
              height: 70,
              width: 70,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authorName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(title),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
