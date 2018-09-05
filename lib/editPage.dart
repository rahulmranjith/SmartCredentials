import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_bank/models/sourcelist.dart';
import './models/smartCredentials.dart';
import 'db.dart';

class EditAdd extends StatefulWidget {
  final int id;

  EditAdd(this.id);

  @override
  _EditAddState createState() => new _EditAddState();
}

class _EditAddState extends State<EditAdd> {
  final GlobalKey<FormState> _credentials = new GlobalKey<FormState>();
  final GlobalKey<FormState> _creditCards = new GlobalKey<FormState>();
  final GlobalKey<FormState> _debitCards = new GlobalKey<FormState>();
  int _screen = 0;
  SmartCredentialDatabase db;
  PageController _pageController;
  void navigationTapped(int page) {
    // Animating to the page.
    // You can use whatever duration and curve you like
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 100),
        curve: Curves.fastOutSlowIn);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  TextEditingController entityTextCtrl;
  bool hasLoaded = true;
  String ccfimg;
  String ccbimg;
  String bi;
  SmartCredentials initialValue = new SmartCredentials();
  @override
  void initState() {
    super.initState();

    sources.add(ImageSource.gallery);
    sources.add(ImageSource.camera);
    db = new SmartCredentialDatabase();
    _pageController = new PageController();

    if (widget.id != null) {
      hasLoaded = false;
      db.fetchSmartCredentials(widget.id).then((oSC) {
        setState(() {
          hasLoaded = true;
          initialValue = oSC;
          entityName = initialValue.bk;
          ccbimg = initialValue.ccbimg;
          ccfimg = initialValue.ccfimg;
          bi = initialValue.bi;
        });
      });
    } else {
      initialValue = SmartCredentials.fromMap(initialValue.toMap());
      entityName = initialValue.bk;
      ccbimg = initialValue.ccbimg;
      ccfimg = initialValue.ccfimg;
      bi = initialValue.bi;
      hasLoaded = true;
    }
    entityTextCtrl = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  List sources = new List();
  Future submit() async {
    SmartCredentials oSC;

    if (widget.id == null) {
      oSC = new SmartCredentials();
    } else {
      oSC = initialValue;
    }

    oSC.id = widget.id;
    if (this._creditCards.currentState != null) {
      if (this._creditCards.currentState.validate()) {
        _creditCards.currentState.save(); // Save our form now.

        oSC.ccn = oSmartCred.ccn;

        oSC.cccvv = oSmartCred.cccvv;
        oSC.ccexp = oSmartCred.ccexp;
        oSC.ccpin = oSmartCred.ccpin;

        oSC.ccfimg = ccfimg;
        oSC.ccbimg = ccbimg;
        oSC = await db.upsertSmartCredentials(oSC);

        SmartCredentials myc = await db.fetchSmartCredentials(oSC.id);

        print('Save CC Data');
      }
    }
    if (this._debitCards.currentState != null) {
      if (this._debitCards.currentState.validate()) {
        _debitCards.currentState.save(); // Save our form now.

        oSC.dcn = oSmartCred.dcn;
        oSC.dccvv = oSmartCred.dccvv;
        oSC.dcexp = oSmartCred.dcexp;
        oSC.dcpin = oSmartCred.dcpin;
        oSC.dcfimg = oSmartCred.dcfimg;
        oSC.dcbimg = oSmartCred.dcbimg;

        oSC = await db.upsertSmartCredentials(oSC);

        SmartCredentials myc = await db.fetchSmartCredentials(oSC.id);

        print('Save DC Data');
      }
    }
    if (this._credentials.currentState != null) {
      if (this._credentials.currentState.validate()) {
        _credentials.currentState.save(); // Save our form now.

        oSC.un = oSmartCred.un;
        oSC.pw = oSmartCred.pw;
        oSC.bk = oSmartCred.bk;
        oSC.bi = bi;
        //oSC.id = 3;
        oSC = await db.upsertSmartCredentials(oSC);

        SmartCredentials myc = await db.fetchSmartCredentials(oSC.id);

        print('Save Credential Data');
      }
    }
  }

  int _page = 0;
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: new DateTime(2015, 8),
        lastDate: new DateTime(2101));
    setState(() {
      initialValue.ccexp = picked.toString();
    });
  }

  SmartCredentials oSmartCred = new SmartCredentials();
  final TextEditingController _controller = new TextEditingController();
  final DateTime selectedDate;
  Image bankImage;

  void ddlChanged(newValue) {
    setState(() {
      entityTextCtrl.text = newValue.name.toString();
      bankImage = new Image(
          image: new AssetImage(newValue.path), height: 45.0, width: 45.0);
      bi = newValue.path;
    });
  }

  String entityName;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            bottomOpacity: 0.5,
            // ignore: const_eval_throws_exception
            backgroundColor: const Color.fromRGBO(78, 67, 117, 1.0),
            elevation:
                defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
            actions: <Widget>[
              new IconButton(
                  icon: const Icon(Icons.save), onPressed: this.submit),
            ],
            title: new Text(
                widget.id == null ? "Feed New Record" : "Edit Record",
                style: const TextStyle(
                    fontFamily: 'Exo', fontSize: 19.0, color: Colors.white))),
        body: hasLoaded
            ? new PageView(
                children: [
                    new Container(
                      child: new SafeArea(
                          top: false,
                          bottom: false,
                          child: new Form(
                              key: this._credentials,
                              child: new SingleChildScrollView(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  child: new Column(
                                    children: <Widget>[
                                      const SizedBox(height: 10.0),
                                      new Row(
                                        children: <Widget>[
                                          new Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                40.0, 0.0, 0.0, 0.0),
                                            child: new EntityList(
                                                current: 1,
                                                onChanged: ddlChanged),
                                          )
                                        ],
                                      ),
                                      new TextFormField(
                                        //controller: entityTextCtrl,
                                        decoration: const InputDecoration(
                                          border: const UnderlineInputBorder(),

                                          filled: true,
                                          hintStyle: const TextStyle(
                                            fontFamily: 'Exo',
                                            fontSize: 15.0,
                                            color: Colors.grey,
                                          ),
                                          // prefixIcon: const Icon(
                                          //   Icons.person,
                                          //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                                          // ),
                                          icon: const Icon(
                                            Icons.home,
                                            color: Colors.redAccent,
                                          ),
                                          hintText: 'Name',
                                          fillColor: Colors.white,
                                          labelText: 'Name',

                                          labelStyle: const TextStyle(
                                              fontFamily: 'Exo',
                                              fontSize: 12.0,
                                              color: const Color.fromRGBO(
                                                  78, 67, 117, 1.0)),
                                        ),
                                        initialValue: entityName,
                                        onSaved: (String value) {
                                          oSmartCred.bk = value;
                                        },
                                      ),
                                      new TextFormField(
                                        decoration: const InputDecoration(
                                          border: const UnderlineInputBorder(),

                                          filled: true,
                                          hintStyle: const TextStyle(
                                            fontFamily: 'Exo',
                                            fontSize: 15.0,
                                            color: Colors.grey,
                                          ),
                                          // prefixIcon: const Icon(
                                          //   Icons.person,
                                          //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                                          // ),
                                          icon: const Icon(
                                            Icons.person,
                                            color: Colors.red,
                                          ),
                                          hintText: 'User Name',
                                          fillColor: Colors.white,
                                          labelText: 'User Name',

                                          labelStyle: const TextStyle(
                                              fontFamily: 'Exo',
                                              fontSize: 12.0,
                                              color: const Color.fromRGBO(
                                                  78, 67, 117, 1.0)),
                                        ),
                                        initialValue: initialValue.un,
                                        onSaved: (String value) {
                                          oSmartCred.un = value;
                                        },
                                      ),
                                      new TextFormField(
                                        decoration: const InputDecoration(
                                            border:
                                                const UnderlineInputBorder(),
                                            filled: true,
                                            hintStyle: const TextStyle(
                                                fontFamily: 'Exo',
                                                fontSize: 15.0,
                                                color: Colors.grey),
                                            // prefixIcon: const Icon(
                                            //   Icons.security,
                                            //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                                            // ),
                                            icon: const Icon(Icons.security,
                                                color: Colors
                                                    .cyanAccent //const Color.fromRGBO(78, 67, 117, 1.0),
                                                ),
                                            hintText: 'Password',
                                            fillColor: Colors.white,
                                            labelStyle: const TextStyle(
                                                fontFamily: 'Exo',
                                                fontSize: 12.0,
                                                color: const Color.fromRGBO(
                                                    78, 67, 117, 1.0)),
                                            labelText: 'Password'),
                                        initialValue: initialValue.pw,
                                        onSaved: (String value) {
                                          oSmartCred.pw = value;
                                        },
                                      ),
                                      new Row(
                                        children: <Widget>[
                                          new IconButton(
                                              icon: new Icon(
                                                Icons.add_a_photo,
                                                color: Colors.blue,
                                              ),
                                              tooltip: 'Capture Entity Picture',
                                              onPressed: () async {
                                                var image =
                                                    await ImagePicker.pickImage(
                                                        source:
                                                            ImageSource.camera);
                                                setState(() {
                                                  bi = image.path;
                                                });
                                              }
//                                            onPressed: () async {
//                                              var ccfimgPath =
//                                              await Navigator.push(
//                                                  context,
//                                                  new MaterialPageRoute(
//                                                      builder: (context) =>
//                                                      new CameraApp()));
//
//                                              if (ccfimgPath != "" ||
//                                                  ccfimgPath == null) {
//                                                ccfimg = ccfimgPath;
//                                                var a;
//                                                a = 1;
//                                              }
//                                            },
                                              ),
                                          new Container(
                                            height: 100.0,
                                            width: 100.0,
                                            child: bi != null
                                                // ? new Image.file(new File(bi))
                                                ? new Image(
                                                    image: new AssetImage(bi),
                                                    height: 45.0,
                                                    width: 45.0)
                                                : new Container(),
                                          )
                                        ],
                                      )
                                    ],
                                  )))),
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
                    ),
                    new Container(
                      child: new SafeArea(
                          top: false,
                          bottom: false,
                          child: new Form(
                              key: this._creditCards,
                              child: new SingleChildScrollView(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  child: new Column(
                                    children: <Widget>[
                                      const SizedBox(height: 12.0),
                                      new TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            border:
                                                const UnderlineInputBorder(),
                                            filled: true,
                                            hintStyle: const TextStyle(
                                                fontFamily: 'Exo',
                                                fontSize: 15.0,
                                                color: Colors.grey),
                                            // prefixIcon: const Icon(
                                            //   Icons.credit_card,
                                            //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                                            // ),
                                            icon: const Icon(Icons.credit_card,
                                                color: Colors.cyanAccent),
                                            hintText: 'Credit Card #',
                                            fillColor: Colors.white,
                                            labelStyle: const TextStyle(
                                                fontFamily: 'Exo',
                                                fontSize: 12.0,
                                                color: const Color.fromRGBO(
                                                    78, 67, 117, 1.0)),
                                            labelText: 'Credit Card #'),
                                        initialValue: initialValue.ccn,
                                        onSaved: (String value) {
                                          oSmartCred.ccn = value;
                                        },
                                      ),
                                      new TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            border:
                                                const UnderlineInputBorder(),
                                            filled: true,
                                            // prefixIcon: const Icon(
                                            //   Icons.security,
                                            //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                                            // ),
                                            icon: const Icon(
                                              Icons.format_list_numbered,
                                              color: Colors.cyanAccent,
                                            ),
                                            hintText: 'Credit Card CVV',
                                            fillColor: Colors.white,
                                            labelStyle: const TextStyle(
                                                fontFamily: 'Exo',
                                                fontSize: 12.0,
                                                color: const Color.fromRGBO(
                                                    78, 67, 117, 1.0)),
                                            labelText: 'Credit Card CVV'),
                                        initialValue: initialValue.cccvv,
                                        onSaved: (String value) {
                                          oSmartCred.cccvv = value;
                                        },
                                      ),
                                      new TextFormField(
                                        keyboardType: TextInputType.datetime,
                                        decoration: const InputDecoration(
                                            border:
                                                const UnderlineInputBorder(),
                                            filled: true,
                                            // prefixIcon: const Icon(
                                            //   Icons.security,
                                            //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                                            // ),

                                            icon: const Icon(Icons.date_range,
                                                color: Colors.cyanAccent),
                                            hintText: 'mm/yy',
                                            fillColor: Colors.white,
                                            labelStyle: const TextStyle(
                                                fontFamily: 'Exo',
                                                fontSize: 12.0,
                                                color: const Color.fromRGBO(
                                                    78, 67, 117, 1.0)),
                                            labelText: 'CC Exp'),
                                        initialValue: initialValue.ccexp,
                                        onSaved: (String value) {
                                          oSmartCred.ccexp = value;
                                        },
                                      ),
                                      new TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            border:
                                                const UnderlineInputBorder(),
                                            filled: true,
                                            // prefixIcon: const Icon(
                                            //   Icons.security,
                                            //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                                            // ),
                                            icon: const Icon(
                                              Icons.fiber_pin,
                                              color: Colors.cyanAccent,
                                            ),
                                            hintText: 'xxxx',
                                            fillColor: Colors.white,
                                            labelStyle: const TextStyle(
                                                fontFamily: 'Exo',
                                                fontSize: 12.0,
                                                color: const Color.fromRGBO(
                                                    78, 67, 117, 1.0)),
                                            labelText: 'CC PIN'),
                                        initialValue: initialValue.ccpin,
                                        onSaved: (String value) {
                                          oSmartCred.ccpin = value;
                                        },
                                      ),
////
//                                      new TextFormField(
//                                        decoration: const InputDecoration(
//                                            border:
//                                                const UnderlineInputBorder(),
//                                            filled: true,
//                                            // prefixIcon: const Icon(
//                                            //   Icons.security,
//                                            //   color: const Color.fromRGBO(78, 67, 117, 1.0),
//                                            // ),
//                                            icon: const Icon(Icons.image,
//                                                color: Colors.cyanAccent),
//                                            hintText: 'Credit Card Front Image',
//                                            fillColor: Colors.white,
//                                            labelStyle: const TextStyle(
//                                                fontFamily: 'Exo',
//                                                fontSize: 12.0,
//                                                color: const Color.fromRGBO(
//                                                    78, 67, 117, 1.0)),
//                                            labelText:
//                                                'Credit Card Front Image'),
//                                        initialValue: initialValue.ccfimg,
//                                        onSaved: (String value) {
//                                          oSmartCred.ccfimg = value;
//                                        },
//                                      ),

                                      new Row(
                                        children: <Widget>[
                                          new IconButton(
                                              icon: new Icon(
                                                Icons.add_a_photo,
                                                color: Colors.orange,
                                              ),
                                              tooltip: 'Increase volume by 10%',
                                              onPressed: () async {
                                                var image =
                                                    await ImagePicker.pickImage(
                                                        source:
                                                            ImageSource.camera);
                                                setState(() {
                                                  ccfimg = image.path;
                                                });
                                              }
//                                            onPressed: () async {
//                                              var ccfimgPath =
//                                              await Navigator.push(
//                                                  context,
//                                                  new MaterialPageRoute(
//                                                      builder: (context) =>
//                                                      new CameraApp()));
//
//                                              if (ccfimgPath != "" ||
//                                                  ccfimgPath == null) {
//                                                ccfimg = ccfimgPath;
//                                                var a;
//                                                a = 1;
//                                              }
//                                            },
                                              ),
                                          new SizedBox(
                                            height: 250.0,
                                            width: 350.0,
                                            child: ccfimg != null
                                                ? new Image.file(
                                                    new File(ccfimg))
                                                : new Container(),
                                          )
                                        ],
                                      ),
                                      new Row(
                                        children: <Widget>[
                                          new IconButton(
                                            icon: new Icon(
                                              Icons.add_a_photo,
                                              color: Colors.yellow,
                                            ),
                                            tooltip: 'Increase volume by 10%',
                                            onPressed: () async {
                                              var image =
                                                  await ImagePicker.pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              setState(() {
                                                ccbimg = image.path;
                                              });
                                            },
                                          ),
                                          new SizedBox(
                                            height: 250.0,
                                            width: 350.0,
                                            child: ccbimg != null
                                                ? new Image.file(
                                                    new File(ccbimg))
                                                : new Container(),
                                          )
                                        ],
                                      ),

                                      // new SizedBox(
                                      //     height: 50.0,
                                      //     width: 50.0,
                                      //     child: new SafeArea(
                                      //         top: false,
                                      //         child: new CameraApp())),
                                    ],
                                  )))),
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
                    ),
                    new Container(
                      child: new SafeArea(
                          top: false,
                          bottom: false,
                          child: new Form(
                              key: this._debitCards,
                              child: new SingleChildScrollView(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  child: new Column(
                                    children: <Widget>[
                                      const SizedBox(height: 12.0),
                                      new TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            border:
                                                const UnderlineInputBorder(),
                                            filled: true,
                                            // prefixIcon: const Icon(
                                            //   Icons.security,
                                            //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                                            // ),
                                            icon: const Icon(
                                              Icons.credit_card,
                                              color: Colors.cyanAccent,
                                            ),
                                            hintText: 'Debit Card #',
                                            fillColor: Colors.white,
                                            labelStyle: const TextStyle(
                                                fontFamily: 'Exo',
                                                fontSize: 12.0,
                                                color: const Color.fromRGBO(
                                                    78, 67, 117, 1.0)),
                                            labelText: 'Debit Card #'),
                                        initialValue: initialValue.dcn,
                                        onSaved: (String value) {
                                          oSmartCred.dcn = value;
                                        },
                                      ),
                                      new TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            border:
                                                const UnderlineInputBorder(),
                                            filled: true,
                                            // prefixIcon: const Icon(
                                            //   Icons.security,
                                            //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                                            // ),
                                            icon: const Icon(
                                                Icons.format_list_numbered,
                                                color: Colors.cyanAccent),
                                            hintText: 'Debit Card CVV',
                                            fillColor: Colors.white,
                                            labelStyle: const TextStyle(
                                                fontFamily: 'Exo',
                                                fontSize: 12.0,
                                                color: const Color.fromRGBO(
                                                    78, 67, 117, 1.0)),
                                            labelText: 'Debit Card CVV'),
                                        initialValue: initialValue.dccvv,
                                        onSaved: (String value) {
                                          oSmartCred.dccvv = value;
                                        },
                                      ),
                                      new TextFormField(
                                        keyboardType: TextInputType.datetime,
                                        decoration: const InputDecoration(
                                            border:
                                                const UnderlineInputBorder(),
                                            filled: true,
                                            icon: const Icon(Icons.date_range,
                                                color: Colors.cyanAccent),
                                            hintText: 'Debit Card Exp',
                                            fillColor: Colors.white,
                                            labelStyle: const TextStyle(
                                                fontFamily: 'Exo',
                                                fontSize: 12.0,
                                                color: const Color.fromRGBO(
                                                    78, 67, 117, 1.0)),
                                            labelText: 'Debit Card Exp'),
                                        initialValue: initialValue.dcexp,
                                        onSaved: (String value) {
                                          oSmartCred.dcexp = value;
                                        },
                                      ),
                                      new TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            border:
                                                const UnderlineInputBorder(),
                                            filled: true,
                                            icon: const Icon(Icons.fiber_pin,
                                                color: Colors.cyanAccent),
                                            hintText: 'Debit Card PIN',
                                            fillColor: Colors.white,
                                            labelStyle: const TextStyle(
                                                fontFamily: 'Exo',
                                                fontSize: 12.0,
                                                color: const Color.fromRGBO(
                                                    78, 67, 117, 1.0)),
                                            labelText: 'Debit Card PIN'),
                                        initialValue: initialValue.dcpin,
                                        onSaved: (String value) {
                                          oSmartCred.dcpin = value;
                                        },
                                      ),
                                      new TextFormField(
                                        decoration: const InputDecoration(
                                            border:
                                                const UnderlineInputBorder(),
                                            filled: true,
                                            icon: const Icon(Icons.image,
                                                color: Colors.cyanAccent),
                                            hintText: 'Debit Card Front Image',
                                            fillColor: Colors.white,
                                            labelStyle: const TextStyle(
                                                fontFamily: 'Exo',
                                                fontSize: 12.0,
                                                color: const Color.fromRGBO(
                                                    78, 67, 117, 1.0)),
                                            labelText:
                                                'Debit Card Front Image'),
                                        initialValue: initialValue.dcfimg,
                                        onSaved: (String value) {
                                          oSmartCred.dcfimg = value;
                                        },
                                      ),
                                      new TextFormField(
                                        decoration: const InputDecoration(
                                            border:
                                                const UnderlineInputBorder(),
                                            filled: true,
                                            icon: const Icon(Icons.image,
                                                color: Colors.cyanAccent),
                                            hintText: 'Debit Card Back Image',
                                            fillColor: Colors.white,
                                            labelStyle: const TextStyle(
                                                fontFamily: 'Exo',
                                                fontSize: 12.0,
                                                color: const Color.fromRGBO(
                                                    78, 67, 117, 1.0)),
                                            labelText: 'Debit Card Back Image'),
                                        initialValue: initialValue.dcbimg,
                                        onSaved: (String value) {
                                          oSmartCred.dcbimg = value;
                                        },
                                      ),
                                    ],
                                  )))),
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
                    )
                  ],

                /// Specify the page controller
                controller: _pageController,
                onPageChanged: onPageChanged)
            : new CircularProgressIndicator(),
        bottomNavigationBar: new BottomNavigationBar(
            fixedColor: const Color.fromRGBO(43, 88, 118, 1.0),
            items: [
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.person), title: new Text("Credentials")),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.credit_card),
                  title: new Text("Credit Card")),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.credit_card),
                  title: new Text("Debit Card"))
            ],

            /// Will be used to scroll to the next page
            /// using the _pageController
            onTap: navigationTapped,
            currentIndex: _page));
  }
}

class _EditAddState1 extends State<EditAdd> {
  @override
  SmartCredentials myCard = new SmartCredentials();

  final formKey = new GlobalKey<FormState>();
  String _username;
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            bottomOpacity: 0.5,
            // ignore: const_eval_throws_exception
            backgroundColor: const Color.fromRGBO(78, 67, 117, 1.0),
            elevation:
                defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
            title: new Text(
                widget.id == null ? "Feed New Record" : "Edit Record",
                style: const TextStyle(
                    fontFamily: 'Exo', fontSize: 19.0, color: Colors.white))),
        body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              child: new SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: new Column(
              children: <Widget>[
                const SizedBox(height: 12.0),
                new TextFormField(
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),

                    filled: true,
                    hintStyle: const TextStyle(
                      fontFamily: 'Exo',
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                    // prefixIcon: const Icon(
                    //   Icons.person,
                    //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                    // ),
                    icon: const Icon(
                      Icons.person,
                      color: const Color.fromRGBO(78, 67, 117, 1.0),
                    ),
                    hintText: 'User Name',
                    fillColor: Colors.white,
                    labelText: 'User Name',
                    labelStyle: const TextStyle(
                        fontFamily: 'Exo',
                        fontSize: 12.0,
                        color: const Color.fromRGBO(78, 67, 117, 1.0)),
                  ),
                  onSaved: (String value) {
                    myCard.un = value;
                  },
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      hintStyle: const TextStyle(
                          fontFamily: 'Exo',
                          fontSize: 15.0,
                          color: Colors.grey),
                      // prefixIcon: const Icon(
                      //   Icons.security,
                      //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                      // ),
                      icon: const Icon(
                        Icons.security,
                        color: const Color.fromRGBO(78, 67, 117, 1.0),
                      ),
                      hintText: 'Password',
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                          fontFamily: 'Exo',
                          fontSize: 12.0,
                          color: const Color.fromRGBO(78, 67, 117, 1.0)),
                      labelText: 'Password'),
                  onSaved: (String value) {
                    myCard.pw = value;
                  },
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      hintStyle: const TextStyle(
                          fontFamily: 'Exo',
                          fontSize: 15.0,
                          color: Colors.grey),
                      // prefixIcon: const Icon(
                      //   Icons.credit_card,
                      //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                      // ),
                      icon: const Icon(
                        Icons.credit_card,
                        color: const Color.fromRGBO(78, 67, 117, 1.0),
                      ),
                      hintText: 'Credit Card #',
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                          fontFamily: 'Exo',
                          fontSize: 12.0,
                          color: const Color.fromRGBO(78, 67, 117, 1.0)),
                      labelText: 'Credit Card #'),
                  onSaved: (String value) {
                    myCard.ccn = value;
                  },
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      // prefixIcon: const Icon(
                      //   Icons.security,
                      //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                      // ),
                      icon: const Icon(
                        Icons.format_list_numbered,
                        color: const Color.fromRGBO(78, 67, 117, 1.0),
                      ),
                      hintText: 'Credit Card CVV',
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                          fontFamily: 'Exo',
                          fontSize: 12.0,
                          color: const Color.fromRGBO(78, 67, 117, 1.0)),
                      labelText: 'Credit Card CVV'),
                  onSaved: (String value) {
                    myCard.cccvv = value;
                  },
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      // prefixIcon: const Icon(
                      //   Icons.security,
                      //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                      // ),
                      icon: const Icon(
                        Icons.date_range,
                        color: const Color.fromRGBO(78, 67, 117, 1.0),
                      ),
                      hintText: 'CC Exp',
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                          fontFamily: 'Exo',
                          fontSize: 12.0,
                          color: const Color.fromRGBO(78, 67, 117, 1.0)),
                      labelText: 'CC Exp'),
                  onSaved: (String value) {
                    myCard.ccexp = value;
                  },
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      // prefixIcon: const Icon(
                      //   Icons.security,
                      //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                      // ),
                      icon: const Icon(
                        Icons.fiber_pin,
                        color: const Color.fromRGBO(78, 67, 117, 1.0),
                      ),
                      hintText: 'CC PIN',
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                          fontFamily: 'Exo',
                          fontSize: 12.0,
                          color: const Color.fromRGBO(78, 67, 117, 1.0)),
                      labelText: 'CC PIN'),
                  onSaved: (String value) {
                    myCard.ccpin = value;
                  },
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      // prefixIcon: const Icon(
                      //   Icons.security,
                      //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                      // ),
                      icon: const Icon(
                        Icons.credit_card,
                        color: const Color.fromRGBO(78, 67, 117, 1.0),
                      ),
                      hintText: 'Debit Card #',
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                          fontFamily: 'Exo',
                          fontSize: 12.0,
                          color: const Color.fromRGBO(78, 67, 117, 1.0)),
                      labelText: 'Debit Card #'),
                  onSaved: (String value) {
                    myCard.dcn = value;
                  },
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      // prefixIcon: const Icon(
                      //   Icons.security,
                      //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                      // ),
                      icon: const Icon(
                        Icons.format_list_numbered,
                        color: const Color.fromRGBO(78, 67, 117, 1.0),
                      ),
                      hintText: 'Debit Card CVV',
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                          fontFamily: 'Exo',
                          fontSize: 12.0,
                          color: const Color.fromRGBO(78, 67, 117, 1.0)),
                      labelText: 'Debit Card CVV'),
                  onSaved: (String value) {
                    myCard.dccvv = value;
                  },
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      icon: const Icon(
                        Icons.date_range,
                        color: const Color.fromRGBO(78, 67, 117, 1.0),
                      ),
                      hintText: 'Debit Card Exp',
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                          fontFamily: 'Exo',
                          fontSize: 12.0,
                          color: const Color.fromRGBO(78, 67, 117, 1.0)),
                      labelText: 'Debit Card Exp'),
                  onSaved: (String value) {
                    myCard.dcexp = value;
                  },
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      icon: const Icon(
                        Icons.fiber_pin,
                        color: const Color.fromRGBO(78, 67, 117, 1.0),
                      ),
                      hintText: 'Debit Card PIN',
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                          fontFamily: 'Exo',
                          fontSize: 12.0,
                          color: const Color.fromRGBO(78, 67, 117, 1.0)),
                      labelText: 'Debit Card PIN'),
                  onSaved: (String value) {
                    myCard.dcpin = value;
                  },
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      // prefixIcon: const Icon(
                      //   Icons.security,
                      //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                      // ),
                      icon: const Icon(
                        Icons.image,
                        color: const Color.fromRGBO(78, 67, 117, 1.0),
                      ),
                      hintText: 'Credit Card Front Image',
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                          fontFamily: 'Exo',
                          fontSize: 12.0,
                          color: const Color.fromRGBO(78, 67, 117, 1.0)),
                      labelText: 'Credit Card Front Image'),
                  onSaved: (String value) {
                    myCard.ccfimg = value;
                  },
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      // prefixIcon: const Icon(
                      //   Icons.security,
                      //   color: const Color.fromRGBO(78, 67, 117, 1.0),
                      // ),
                      icon: const Icon(
                        Icons.image,
                        color: const Color.fromRGBO(78, 67, 117, 1.0),
                      ),
                      hintText: 'Credit Card Back Image',
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                          fontFamily: 'Exo',
                          fontSize: 12.0,
                          color: const Color.fromRGBO(78, 67, 117, 1.0)),
                      labelText: 'Credit Card Back Image'),
                  onSaved: (String value) {
                    myCard.ccbimg = value;
                  },
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      icon: const Icon(
                        Icons.image,
                        color: const Color.fromRGBO(78, 67, 117, 1.0),
                      ),
                      hintText: 'Debit Card Front Image',
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                          fontFamily: 'Exo',
                          fontSize: 12.0,
                          color: const Color.fromRGBO(78, 67, 117, 1.0)),
                      labelText: 'Debit Card Front Image'),
                  onSaved: (String value) {
                    myCard.dcfimg = value;
                  },
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      icon: const Icon(
                        Icons.image,
                        color: const Color.fromRGBO(78, 67, 117, 1.0),
                      ),
                      hintText: 'Debit Card Back Image',
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                          fontFamily: 'Exo',
                          fontSize: 12.0,
                          color: const Color.fromRGBO(78, 67, 117, 1.0)),
                      labelText: 'Debit Card Back Image'),
                  onSaved: (String value) {
                    myCard.dcbimg = value;
                  },
                )
              ],
            ),
          )),
        ));

    // return new Scaffold(
    //     appBar: new AppBar(
    //         backgroundColor: Colors.amber,
    //         title: new Text("Edit Credentials",
    //             style: new TextStyle(
    //                 fontWeight: FontWeight.normal, color: Colors.white))),
    //     body: new Material(
    //         child: new Container(
    //       child: new GridView.count(
    //         crossAxisCount: 4,
    //         childAspectRatio: 1.0,
    //         padding: const EdgeInsets.all(4.0),
    //         mainAxisSpacing: 4.0,
    //         crossAxisSpacing: 4.0,
    //         children: new List<Widget>.generate(100, (index) {
    //           return new GridTile(
    //             child: new Card(
    //                 color: Colors.red,
    //                 child: new Center(
    //                   child: new Text('tile $index'),
    //                 )),
    //           );
    //         }),
    //       ),
    //       decoration: new BoxDecoration(
    //         gradient: new LinearGradient(
    //           begin: const Alignment(0.0, -1.0),
    //           end: const Alignment(0.0, 0.1),
    //           colors: <Color>[Colors.limeAccent, Colors.lightBlue.shade300],
    //         ),
    //       ),
    //     )));

    return new Container(child: new Text(widget.id.toString()));
  }
}

class PushButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool raised;

  PushButton({
    this.label,
    this.onPressed,
    this.raised = false,
  });

  @override
  build(BuildContext context) {
    Widget button;

    if (Platform.isAndroid) {
      if (raised) {
        button = new RaisedButton(
          child: new Text(label),
          onPressed: onPressed,
        );
      } else {
        button = new FlatButton(
          child: new Text(label),
          onPressed: onPressed,
        );
      }
    }
    if (Platform.isIOS) {
      button = new CupertinoButton(
        child: new Text(label),
        color: raised ? CupertinoColors.activeBlue : null,
        padding: new EdgeInsets.all(12.0),
        onPressed: onPressed,
      );
    }

    return button;
  }
}
