import 'package:flutter/material.dart';
import 'dart:core';
import './models/smartCredentials.dart';
import 'editPage.dart';

class CardInfoItem extends StatelessWidget {
  final SmartCredentials cardInformation;

  CardInfoItem(this.cardInformation);

  @override
  Widget build(BuildContext context) {
    final credentialImage = new Container(
      margin: new EdgeInsets.symmetric(vertical: 32.0, horizontal: 1.0),
      alignment: FractionalOffset.topLeft,
      width: 60.0,
      height: 60.0,
      child: new Container(
          decoration: new BoxDecoration(
        color: const Color(0xff7c94b6),
      
        image: new DecorationImage(
          image: new AssetImage(cardInformation.bi),
          //image:new Image.file(new File(ccfimg)),
          // image:new Image.asset(name)
          fit: BoxFit.fill,
        ),
        borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
        border: new Border.all(
          color: const Color.fromRGBO(247, 120, 100, 0.9),
          width: 1.5,
        ),
      )),
    );

    void _handleTap() {
      {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new EditAdd(cardInformation.id)));
      }
    }

    final credentialCard = new GestureDetector(
        // onTapDown: _handleTapDown, // Handle the tap events in the order that
        //onTapUp: _handleTapUp, // they occur: down, up, tap, cancel
        onTap: _handleTap,
        //onTapCancel: _handleTapCancel,
        child: new Container(
            height: 200.0,
            width: 400.0,
            margin: new EdgeInsets.only(left: 32.0),
            child: new Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,R
              //  mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.only(left: 75.0),
                  child: new Column(
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                      ),
                      new Container(
                          alignment: Alignment.topLeft,
                          padding: new EdgeInsets.only(bottom: 10.0),
                          //margin: new EdgeInsets.fromLTRB(55.0, 15.0, 0.0, 0.0),
                          child: new Text(cardInformation.bk,
                              style: const TextStyle(
                                  fontFamily: 'Exo',
                                  fontSize: 20.0,
                                  color: Colors.limeAccent))),
                      new Row(
                        children: <Widget>[
                          new Container(
                              alignment: Alignment.center,
                              //margin: new EdgeInsets.fromLTRB(55.0, 15.0, 0.0, 0.0),
                              child: new Text(
                                "UserName: ",
                                style: const TextStyle(
                                    fontFamily: 'Exo',
                                    fontSize: 13.0,
                                    color: Colors.red),
                              )),
                          new Container(
                              //margin: new EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                              child: new Text(cardInformation.un.toString(),
                                  style: const TextStyle(
                                      fontFamily: 'Exo',
                                      fontSize: 18.0,
                                      color: Colors.white)))
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Container(
                              //margin: new EdgeInsets.only(left: 90.0),
                              child: new Text("PWD #: ",
                                  style: const TextStyle(
                                      fontFamily: 'Exo',
                                      fontSize: 12.0,
                                      color: Colors.red))),
                          new Container(
                              child: new Text(cardInformation.pw.toString(),
                                  style: const TextStyle(
                                      fontFamily: 'Exo',
                                      fontSize: 18.0,
                                      color: Colors.white))),
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Container(
                              //margin: new EdgeInsets.only(left: 90.0),
                              child: new Text("CC #: ",
                                  style: const TextStyle(
                                      fontFamily: 'Exo',
                                      fontSize: 13.0,
                                      color: Colors.red))),
                          new Container(
                              child: new Text(cardInformation.ccn.toString(),
                                  style: const TextStyle(
                                      fontFamily: 'Exo',
                                      fontSize: 18.0,
                                      color: Colors.white)))
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Container(
                              // margin: new EdgeInsets.only(left: 90.0),
                              child: new Text("DC #: ",
                                  style: const TextStyle(
                                      fontFamily: 'Exo',
                                      fontSize: 12.0,
                                      color: Colors.red))),
                          new Container(
                              child: new Text(cardInformation.dcn.toString(),
                                  style: const TextStyle(
                                      fontFamily: 'Exo',
                                      fontSize: 18.0,
                                      color: Colors.white))),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            decoration: new BoxDecoration(
                color: new Color(0xFF223366),
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(10.0),
//          gradient: new LinearGradient(
//            begin: Alignment.topCenter,
//            end: new Alignment(0.5, 0.9),
//            colors: <Color>[
//              const Color.fromRGBO(172,182,229, 1.0),
//              const Color.fromRGBO(134,253,232, 1.0)
//
//
//            ],
//          ),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: new Offset(0.0, 10.0))
                ])));

    return new Container(
      height: 200.0,
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: new Stack(
        children: <Widget>[credentialCard, credentialImage],
      ),
    );
  }
}
