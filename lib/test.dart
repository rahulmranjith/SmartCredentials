import 'package:flutter/material.dart';
class YellowBird extends StatefulWidget {
  const YellowBird({ Key key }) : super(key: key);

  @override
  _YellowBirdState createState() => new _YellowBirdState();
}

class _YellowBirdState extends State<YellowBird> {
  @override
  Widget build(BuildContext context) {
    return new Container(color: const Color(0xFFFFE306));
  }
}