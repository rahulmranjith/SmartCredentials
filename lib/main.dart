import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_bank/imagepicker.dart';
import 'package:smart_bank/models/sourcelist.dart';
import './dashboard.dart';
import 'package:flutter/rendering.dart';
import 'editPage.dart';

void main() {
 SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(new MaterialApp(home: new SmartBank()));
}

class SmartBank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled:
    true;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Smart Credentials',
            style: const TextStyle(
                fontFamily: 'Exo', fontSize: 22.0, color: Colors.white)),
        bottomOpacity: 0.5,
        // ignore: const_eval_throws_exception
        //const Color.fromRGBO(254, 84, 147, 1.0),
             //const Color.fromRGBO(247, 110, 100, 1.0)
        backgroundColor: const Color.fromRGBO(78, 67, 117, 1.0),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      drawer: new Drawer(
          child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text("RMR"),
            accountEmail: new Text("rahulmr@gmail.com"),
          ),
          new Divider(
            color: Colors.lightBlueAccent,
          ),
          new ListTile(
            title: new Text(
              "Settings",
              style:
                  new TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            leading: new Icon(Icons.settings),
          ),
          new Divider(
            color: Colors.lightBlueAccent,
          ),
          new ListTile(
              title: new Text(
                "Sign Out",
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.red),
              ),
              leading: new Icon(Icons.exit_to_app))
        ],
      )),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.red,
        child: new Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new EditAdd(null)));
          //new MaterialPageRoute(builder: (context) => new SettingsWidget()));
        },
      ),
      body: new Material(
          child: new Container(
        // red box

        child: new DashBoard(),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.topRight,
            end: new Alignment(0.9, 0.9),
             colors: <Color>[
             //const Color.fromRGBO(254, 84, 147, 1.0),
             //const Color.fromRGBO(247, 110, 100, 1.0)

            const Color.fromRGBO(50, 35, 100, 1.0),
             //const Color.fromRGBO(128, 64, 1, 1.0)
                const Color.fromRGBO(43, 88, 118, 1.0),
              //  const Color.fromRGBO(78, 67, 117, 1.0)
            ],
          ),
        ),
        padding: new EdgeInsets.all(16.0),
      )),
    );
  }
}
