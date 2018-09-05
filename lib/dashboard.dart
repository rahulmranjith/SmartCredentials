import 'package:flutter/material.dart';

import 'cardRows.dart';
import './models/smartCredentials.dart';
import 'db.dart';
import 'dart:async';

class DashBoard extends StatefulWidget {
  @override
  DashBoardState createState() => new DashBoardState();
}

class DashBoardState extends State<DashBoard> {
  final roundImage = new Container(
    width: 50.0,
    height: 50.0,
    padding: const EdgeInsets.all(10.0),
    decoration: new BoxDecoration(
      color: const Color(0xff7c94b6),
      image: new DecorationImage(
        image: new AssetImage("images/indian.png"),
        fit: BoxFit.fill,
      ),
      borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
      border: new Border.all(
        color: const Color.fromRGBO(247, 110, 100, 1.0),
        width: 3.0,
      ),
    ),
  );
  SmartCredentialDatabase db;
  Future<List> getList() async {
    db = new SmartCredentialDatabase();
    return db.fetchAllData();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: getList(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (!snapshot.hasData) return new Container();
          var assetsImage = new AssetImage("images/hdfc.png");
          var image = new Image(image: assetsImage, height: 10.0, width: 10.0);
          final content = snapshot.data;
          final tiles = content.map((item) {
            // return new InkWell(
            //   child: new Text("data"),
            //   onTap: () => print("we tapped "),
            // );

            return new CardInfoItem(item);
          });
          return new ListView(
            children: tiles.toList(),
            itemExtent: 150.0,
          );
        });

    // final tiles = _saved.map(
    //   (pair) {
    //     return new ListTile(
    //       title: new Text(
    //         pair.toString(),

    //       ),
    //     );
    //   },
    // );

    db = new SmartCredentialDatabase();
    Iterable<Widget> tiles;
    bool hasLoaded = false;
    db.fetchAllData().then((onValue) {
      setState(() {
        hasLoaded = true;
        tiles = onValue.map((item) {
          // return new InkWell(
          //   child: new Text("data"),
          //   onTap: () => print("we tapped "),
          // );

          return new CardInfoItem(item);
        });
      });

      // final divided = ListTile
      //     .divideTiles(context: context, tiles: tiles, color: Colors.blueAccent)
      //     .toList();
    });

    if (hasLoaded == true) {
      return new ListView(
        children: tiles.toList(),
        itemExtent: 150.0,
      );
    } else {
      return new CircularProgressIndicator();
    }

    // db.fetchSmartCredentials(widget.id).then((oSC) {
    //   setState(() {
    //     hasLoaded = true;
    //     initialValue = oSC;
    //   });
    // });

    final tiles1 = sampleData.map((item) {
      // return new InkWell(
      //   child: new Text("data"),
      //   onTap: () => print("we tapped "),
      // );

      return new CardInfoItem(item);

      // return new Container(
      //   height: 200.0,
      //   margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      //   child: new Stack(
      //     children: <Widget>[planetCard, planetThumbnail],
      //   ),
      // );

      return new SafeArea(
          top: true,
          bottom: false,
          child: new Container(
            padding: const EdgeInsets.all(5.0),
            child: new Card(
              color: Colors.red,
              elevation: 10.0,
              child: new Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new FittedBox(
                    alignment: Alignment.bottomRight,
                    child: new Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: new DecorationImage(
                          image: new AssetImage("images/hdfc.png"),
                          fit: BoxFit.scaleDown,
                        ),
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(50.0)),
                        border: new Border.all(
                          color: const Color.fromRGBO(247, 110, 100, 1.0),
                          width: 4.0,
                        ),
                      ),
                    ),
                  ),
                  new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Stack(
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    80.0, 20.0, 1.0, 1.0),
                                child: new Text(
                                  item.bk,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ));

    //   return new Card(
    //     child: new Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: <Widget>[
    //         const ListTile(
    //           leading: const Icon(Icons.album),
    //           title: const Text('The Enchanted Nightingale'),
    //           subtitle:
    //               const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
    //         ),
    //         new ButtonTheme.bar(
    //           // make buttons use the appropriate styles for cards
    //           child: new ButtonBar(
    //             children: <Widget>[
    //               new FlatButton(
    //                 child: const Text('BUY TICKETS'),
    //                 onPressed: () {/* ... */},
    //               ),
    //               new FlatButton(
    //                 child: const Text('LISTEN'),
    //                 onPressed: () {/* ... */},
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    //   return new Card(
    //     elevation: 5.0,
    //     //color: Colors.tealAccent.withAlpha(500).withRed(0).withOpacity(0.35),
    //     color: Colors.white,
    //     child: new ListTile(
    //         title: new Text(
    //           item.bk,
    //           style: new TextStyle(
    //               color: Colors.black, fontWeight: FontWeight.bold),
    //         ),
    //         leading: image,
    //         onLongPress: () => Navigator.of(context).push(new MaterialPageRoute(
    //             builder: (BuildContext context) => new EditAdd(item.id))),
    //         trailing: new IconButton(
    //           icon: new Icon(Icons.info),
    //           highlightColor: Colors.limeAccent,
    //           iconSize: 25.0,
    //           color: Colors.blueAccent.withOpacity(1.0),
    //           onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
    //               builder: (BuildContext context) => new DetailsPage())),
    //         )),
    //   );
    //   return new ListTile(
    //       title: new Text(
    //         item.bk,
    //         style:
    //             new TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    //       ),
    //       leading: image,
    //       // subtitle: new Text(
    //       //    item["ccn"].toString() + "\n" + item["dcn"].toString(),
    //       //   style: new TextStyle(fontSize: 12.0, color: Colors.cyan[900]),
    //       //   textAlign: TextAlign.justify,
    //       // ),
    //       onLongPress: () => Navigator.of(context).push(new MaterialPageRoute(
    //           builder: (BuildContext context) => new EditAdd(item.id))),
    //       trailing: new IconButton(
    //         icon: new Icon(Icons.info),
    //         highlightColor: Colors.limeAccent,
    //         iconSize: 22.0,
    //         color: Colors.blue,
    //         onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
    //             builder: (BuildContext context) => new DetailsPage())),
    //       ));
    });

    // return new ListView.builder(
    //   padding: new EdgeInsets.all(8.0),
    //   //itemExtent: 50.0,
    //   itemBuilder: (BuildContext context, int index) {
    //     final listTile =
    //         new ListTile(title: new Text("Title $index"), trailing: image);

    //     return listTile;
    //   },
    // );
  }
}
