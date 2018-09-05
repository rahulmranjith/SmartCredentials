import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsState createState() => new _DetailsState();
}

class _DetailsState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            backgroundColor: Colors.amber,
            title: new Text("Credential Details",
                style: new TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.white))),
        );
  }
}


