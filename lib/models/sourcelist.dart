import 'package:flutter/material.dart';

import 'dart:convert';
import 'EntityListDto.dart';
import 'dart:io' as Io;

final entities = [
  {"name": "American Express", "path": "images/amer.PNG"},
  {"name": "Apple", "path": "images/apple.PNG"},
  {"name": "Axis", "path": "images/axis.PNG"},
  {"name": "Blogger", "path": "images/blogger.PNG"},
  {"name": "Bank Of Maharashtra", "path": "images/BOM.PNG"},
  {"name": "Canara Bank", "path": "images/canara.PNG"},
  {"name": "Dropbox", "path": "images/dropbox.PNG"},
  {"name": "EverNote", "path": "images/evernote.PNG"},
  {"name": "Facebook", "path": "images/fb.PNG"},
  {"name": "Google", "path": "images/google.PNG"},
  {"name": "HDFC Bank", "path": "images/hdfc.PNG"},
  {"name": "ICICI Bank", "path": "images/icici.PNG"},
  {"name": "Indian Bank", "path": "images/indian.PNG"},
  {"name": "Instagram", "path": "images/instagram.PNG"},
  {"name": "Kotak Bank", "path": "images/kotak.PNG"},
  {"name": "LinkedIn", "path": "images/linkedin.PNG"},
  {"name": "Pinterest", "path": "images/pinterest.PNG"},
  {"name": "RBL Bank", "path": "images/rbl.PNG"},
  {"name": "SBI Bank", "path": "images/sbi.PNG"},
  {"name": "Skype", "path": "images/skype.PNG"},
  {"name": "Standard Chartered Bank", "path": "images/std.PNG"},
  {"name": "Trip Advisor", "path": "images/tripadvisor.PNG"},
  {"name": "Twitter", "path": "images/twitter.PNG"},
  {"name": "WhatsApp", "path": "images/whatsapp.PNG"},
  {"name": "Yes Bank", "path": "images/yes.PNG"},
  {"name": "Youtube", "path": "images/youtube.PNG"}
];

class entityInfo {
  String name;
  String path;
}

class EntityList extends StatefulWidget {
  EntityList({Key key, this.current: 0, this.onChanged}) : super(key: key);
  final int current;
  final ValueChanged<EntityDTO> onChanged;

  @override
  _EntityListWidgetState createState() => new _EntityListWidgetState();
}

class _EntityListWidgetState extends State<EntityList> {
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentItem;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentItem = _dropDownMenuItems[0].value;
    super.initState();
  }

  List entityItems = EntityListDTO.parseJson(entities);
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    //
    //  "Blogger": "images/blogger.PNG",
    //  "Bank Of Maharashtra": "images/BOM.PNG",
    //  "Canara Bank": "images/canara.PNG",
    //  "Dropbox": "images/dropbox.PNG",
    //  "EverNote": "images/evernote.PNG",
    //  "Facebook": "images/fb.PNG",
    //  "Google": "images/google.PNG",
    //  "HDFC Bank": "images/hdfc.PNG",
    //  "ICICI Bank": "images/icici.PNG",
    //  "Indian Bank": "images/indian.PNG",
    //  "Instagram": "images/instagram.PNG",
    //  "Kotak Bank": "images/kotak.PNG",
    //  "LinkedIn": "images/linkedin.PNG",
    //  "Pinterest": "images/pinterest.PNG",
    //  "RBL Bank": "images/rbl.PNG",
    //  "SBI Bank": "images/sbi.PNG",
    //  "Skype": "images/skype.PNG",
    //  "Standard Chartered Bank": "images/std.PNG",
    //  "Trip Advisor": "images/tripadvisor.PNG",
    //  "Twitter": "images/twitter.PNG",
    //  "WhatsApp": "images/whatsapp.PNG",
    //  "Yes Bank": "images/yes.PNG",
    //  "Youtube": "images/youtube.PNG"});

    List<DropdownMenuItem<String>> items = new List();
    var assetsImage = new AssetImage("images/hdfc.PNG");
    var image = new Image(image: assetsImage, height: 45.0, width: 45.0);
    var imageFile =
        "storage/emulated/0/Android/data/com.example.smartbank/files/Pictures/05d6214b-7c0e-4c49-98e5-476f598c7a807453428143044110900.png";
    // Map jsonData = JSON.decode(source)

    items.add(new DropdownMenuItem(
        value: "",
        child: new Row(
          children: <Widget>[
            //new Image(image: image),

            
            new Text(" " + "Select an item.."),
          ],
        )));
    for (var i = 0; i < entityItems.length; i++) {
      items.add(new DropdownMenuItem(
          value: entityItems[i].name,
          child: new Row(
            children: <Widget>[
              new Image(
                  image: new AssetImage(entityItems[i].path),
                  height: 45.0,
                  width: 45.0),
              new Text(" " + entityItems[i].name),
            ],
          )));
    }
    items.add(new DropdownMenuItem(
        value: "OTH",
        child: new Row(
          children: <Widget>[
            new Text(" " + "Others.."),
          ],
        )));

    return items;
  }

  EntityDTO findmatchedItem(String name) {
    for (var i = 0; i < entityItems.length; i++) {
      if (entityItems[i].name == name) {
        return entityItems[i];
      }
    }
    EntityDTO edto = new EntityDTO({"name": "", "path": ""});

    return edto;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.transparent,
      child: new Container(
          child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //new Text("Please choose your city: "),

          new DropdownButton(
            value: "",
            items: _dropDownMenuItems,
            // isDense: true,
            style: const TextStyle(
              fontFamily: 'Exo',
              fontSize: 13.0,
              color: Colors.blue,
            ),
            isDense: false,
            onChanged: changedDropDownItem,
          )
        ],
      )),
    );
  }

  void changedDropDownItem(String selectedItem) {
    print("Value" + selectedItem);
    if (selectedItem == "") {
      return;
    }
    if (selectedItem == "OTH") {}

    EntityDTO item = findmatchedItem(selectedItem);
    widget.onChanged(item);
    setState(() {
      _currentItem = selectedItem;
    });
  }
}
