class SmartCredentials {
  int id;
  String un;
  String pw;
  String bk;
  String bi;
  String ccn;
  String cccvv;
  String ccexp;
  String ccpin;
  String dcn;
  String dccvv;
  String dcexp;
  String dcpin;
  String dcfimg;
  String ccfimg;
  String dcbimg;
  String ccbimg;
  //

  SmartCredentials(
      {this.id,
      this.un,
      this.pw,
      this.bk,
      this.bi,
      this.ccn,
      this.cccvv,
      this.ccexp,
      this.ccpin,
      this.dcn,
      this.dccvv,
      this.dcexp,
      this.dcpin,
      this.dcfimg,
      this.ccfimg,
      this.dcbimg,
      this.ccbimg});

 

  Map toMap() {
    Map map = {
      "un": un,
      "pw": pw,
      "bk": bk,
      "bi": bi,
      "ccn": ccn,
      "cccvv": cccvv,
      "ccexp": ccexp,
      "ccpin": ccpin,
      "dcn": dcn,
      "dccvv": dccvv,
      "dcexp": dcexp,
      "dcpin": dcpin,
      "dcfimg": dcfimg,
      "ccfimg": ccfimg,
      "dcbimg": dcbimg,
      "ccbimg": ccbimg
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  static fromMap(Map card) {
    SmartCredentials mycard = new SmartCredentials();
    mycard.id = card["id"];
    mycard.un = convert(card["un"]);
    mycard.pw = convert(card["pw"]);
    mycard.bk = convert(card["bk"]);
    mycard.bi = convert(card["bi"]);
    mycard.ccn = convert(card["ccn"]);
    mycard.cccvv = convert(card["cccvv"]);
    mycard.ccexp = convert(card["ccexp"]);
    mycard.ccpin = convert(card["ccpin"]);
    mycard.dcn = convert(card["dcn"]);
    mycard.dccvv = convert(card["dccvv"]);
    mycard.dcexp = convert(card["dcexp"]);
    mycard.dcpin = convert(card["dcpin"]);
    mycard.dcfimg = convert(card["dcfimg"]);
    mycard.ccfimg = convert(card["ccfimg"]);
    mycard.dcbimg = convert(card["dcfimg"]);
    mycard.ccbimg = convert(card["ccbimg"]);
    return mycard;
  }

  static convert(input) {
    if (input == null) {
      return "";
    } else {
      return input;
    }
  }

  SmartCredentials.fromJSON(Map card) {
    this.id = card["id"];
    this.un = card["un"];
    this.pw = card["pw"];
    this.bk = card["bk"];
    this.bi = card["bi"];
    this.ccn = card["ccn"];
    this.cccvv = card["cccvv"];
    this.ccexp = card["ccexp"];
    this.ccpin = card["ccpin"];
    this.dcn = card["dcn"];
    this.dccvv = card["dccvv"];
    this.dcexp = card["dcexp"];
    this.dcpin = card["dcpin"];
    this.dcfimg = card["dcfimg"];
    this.ccfimg = card["ccfimg"];
    this.dcbimg = card["dcfimg"];
    this.ccbimg = card["ccbimg"];
  }
}

List<SmartCredentials> sampleData = [
  new SmartCredentials.fromJSON({
    "id": 2,
    "un": "Cleveland",
    "pw": "Lindsey",
    "bk": "ICICI",
    "bi": "images/icici.jpg",
    "ccn": "4733419073745608",
    "cccvv": "295",
    "ccexp": "11/12",
    "ccpin": "473",
    "dcn": "9597899883519858",
    "dccvv": "222",
    "dcexp": "10/01",
    "dcpin": "836",
    "dcfimg": "",
    "dcbimg": "",
    "ccfimg": "",
    "ccbimg": ""
  }),
  new SmartCredentials.fromJSON({
    "id": 0,
    "un": "Hodge",
    "pw": "Logan",
    "bk": "AXIS",
    "bi": "images/axis.jpeg",
    "ccn": "461409871932119",
    "cccvv": "180",
    "ccexp": "10/01",
    "ccpin": "162",
    "dcn": "3448368888348341",
    "dccvv": "243",
    "dcexp": "12/11",
    "dcpin": "190",
    "dcfimg": "",
    "dcbimg": "",
    "ccfimg": "",
    "ccbimg": ""
  }),
  new SmartCredentials.fromJSON({
    "id": 1,
    "un": "Edith",
    "pw": "Tonia",
    "bk": "SBI",
    "bi": "images/sbi.png",
    "ccn": "6959659869316964",
    "cccvv": "353",
    "ccexp": "10/01",
    "ccpin": "852",
    "dcn": "6607356870081276",
    "dccvv": "626",
    "dcexp": "10/01",
    "dcpin": "418",
    "dcfimg": "",
    "dcbimg": "",
    "ccfimg": "",
    "ccbimg": ""
  }),
  new SmartCredentials.fromJSON({
    "id": 3,
    "un": "Shelton",
    "pw": "Guerra",
    "bk": "ICICI",
    "bi": "images/indian.png",
    "ccn": "1063850042410194",
    "cccvv": "133",
    "ccexp": "12/11",
    "ccpin": "362",
    "dcn": "3998720829840749",
    "dccvv": "946",
    "dcexp": "11/12",
    "dcpin": "542",
    "dcfimg": "",
    "dcbimg": "",
    "ccfimg": "",
    "ccbimg": ""
  }),
  new SmartCredentials.fromJSON({
    "id": 4,
    "un": "Latisha",
    "pw": "Larson",
    "bk": "AXIS",
    "bi": "images/axis.jpeg",
    "ccn": "4642169426660984",
    "cccvv": "603",
    "ccexp": "11/12",
    "ccpin": "892",
    "dcn": "465286679100245",
    "dccvv": "441",
    "dcexp": "12/11",
    "dcpin": "420",
    "dcfimg": "",
    "dcbimg": "",
    "ccfimg": "",
    "ccbimg": ""
  }),
  new SmartCredentials.fromJSON({
    "id": 5,
    "un": "Aguilar",
    "pw": "Hogan",
    "bk": "HDFC",
    "bi": "images/hdfc.png",
    "ccn": "1777479918673634",
    "cccvv": "768",
    "ccexp": "11/12",
    "ccpin": "377",
    "dcn": "442562401294708",
    "dccvv": "708",
    "dcexp": "10/01",
    "dcpin": "821",
    "dcfimg": "",
    "dcbimg": "",
    "ccfimg": "",
    "ccbimg": ""
  }),
  new SmartCredentials.fromJSON({
    "id": 6,
    "un": "Stevens",
    "pw": "Mary",
    "bk": "AXIS",
    "bi": "images/axis.jpeg",
    "ccn": "546190508175641",
    "cccvv": "178",
    "ccexp": "12/11",
    "ccpin": "702",
    "dcn": "3838796734344214",
    "dccvv": "602",
    "dcexp": "12/11",
    "dcpin": "688",
    "dcfimg": "",
    "dcbimg": "",
    "ccfimg": "",
    "ccbimg": ""
  }),
  new SmartCredentials.fromJSON({
    "id": 7,
    "un": "Wiley",
    "pw": "Garner",
    "bk": "INDIAN",
    "bi": "images/indian.png",
    "ccn": "3811420949641615",
    "cccvv": "665",
    "ccexp": "11/12",
    "ccpin": "310",
    "dcn": "2964404132217169",
    "dccvv": "799",
    "dcexp": "12/11",
    "dcpin": "684",
    "dcfimg": "",
    "dcbimg": "",
    "ccfimg": "",
    "ccbimg": ""
  }),
  new SmartCredentials.fromJSON({
    "id": 8,
    "un": "Fran",
    "pw": "Erna",
    "bk": "HDFC",
    "bi": "images/hdfc.png",
    "ccn": "5609927822370082",
    "cccvv": "252",
    "ccexp": "10/01",
    "ccpin": "904",
    "dcn": "6043263706378638",
    "dccvv": "161",
    "dcexp": "10/01",
    "dcpin": "307",
    "dcfimg": "",
    "dcbimg": "",
    "ccfimg": "",
    "ccbimg": ""
  }),
  new SmartCredentials.fromJSON({
    "id": 9,
    "un": "Shaffer",
    "pw": "Eva",
    "bk": "SBI",
    "bi": "images/sbi.png",
    "ccn": "9242659322917462",
    "cccvv": "177",
    "ccexp": "11/12",
    "ccpin": "731",
    "dcn": "1537440042011439",
    "dccvv": "411",
    "dcexp": "10/01",
    "dcpin": "176",
    "dcfimg": "",
    "dcbimg": "",
    "ccfimg": "",
    "ccbimg": ""
  }),
  new SmartCredentials.fromJSON({
    "id": 10,
    "un": "Emerson",
    "pw": "Mccormick",
    "bk": "HDFC",
    "bi": "images/hdfc.png",
    "ccn": "191625976003706",
    "cccvv": "231",
    "ccexp": "12/11",
    "ccpin": "974",
    "dcn": "6135284893680364",
    "dccvv": "298",
    "dcexp": "10/01",
    "dcpin": "131",
    "dcfimg": "",
    "dcbimg": "",
    "ccfimg": "",
    "ccbimg": ""
  }),
  new SmartCredentials.fromJSON({
    "id": 11,
    "un": "Battle",
    "pw": "Angie",
    "bk": "BM",
    "bi": "images/BM.jpeg",
    "ccn": "6714740572497248",
    "cccvv": "926",
    "ccexp": "11/12",
    "ccpin": "771",
    "dcn": "9742928200867028",
    "dccvv": "451",
    "dcexp": "11/12",
    "dcpin": "741",
    "dcfimg": "",
    "dcbimg": "",
    "ccfimg": "",
    "ccbimg": ""
  }),
  new SmartCredentials.fromJSON({
    "id": 12,
    "un": "Alford",
    "pw": "Kristin",
    "bk": "Kotak",
    "bi": "images/kot.jpeg",
    "ccn": "9443729326594620",
    "cccvv": "478",
    "ccexp": "12/11",
    "ccpin": "980",
    "dcn": "9881931592244654",
    "dccvv": "517",
    "dcexp": "11/12",
    "dcpin": "503",
    "dcfimg": "",
    "dcbimg": "",
    "ccfimg": "",
    "ccbimg": ""
  })
];
