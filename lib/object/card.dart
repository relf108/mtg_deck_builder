/*
class MTGCard {
  String name; //name
  String manaCost;
  String text;
  String keyword; //text
  String etbEffect; //text
  String tapEffect; //text
  String power;
  String toughness;

  MTGCard(this.name, this.manaCost, this.keyword, this.etbEffect,
      this.tapEffect, this.power, this.toughness);

  MTGCard.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    manaCost = json['manaCost'];
    keyword = json['keyword'];
    etbEffect = json['etb_effect'];
    tapEffect = json['tap_effect'];
    power = json['power'];
    toughness = json['toughness'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['manaCost'] = this.manaCost;
    data['keyword'] = this.keyword;
    data['etb_effect'] = this.etbEffect;
    data['tap_effect'] = this.tapEffect;
    data['power'] = this.power;
    data['toughness'] = this.toughness;
    return data;
  }

  void printCard() async {
    print(
        name); //Why does this return "Instance of 'Future<dynamic>'" instead of a card object?
    // now returning instance of MTG card
  }
}
*/


import 'dart:convert';

import 'package:flutter/services.dart';

class Cards {
  Map<String, MTGCard> cards;

  static const String PATH = "assets/standard_cards.json";

  static Future<Cards> fromJson(String path) async {
    String json = await rootBundle.loadString('assets/config.json');
    var cards =
    jsonDecode(json);
    return cards;
  }

/*  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.absorb != null) {
      data['Absorb'] = this.absorb.toJson();
    }
    return data;
  }*/
}

class MTGCard {
  List<String> colorIdentity;
  List<String> colors;
  double convertedManaCost;
  int edhrecRank;
  List<ForeignData> foreignData;
  String layout;
  Legalities legalities;
  String manaCost;
  int mtgArenaId;
  int mtgoId;
  String name;
  List<String> printings;
  PurchaseUrls purchaseUrls;
  List<Rulings> rulings;
  String scryfallOracleId;
  List<Subtypes> subtypes;
  List<Supertypes> supertypes;
  String text;
  String type;
  List<String> types;
  String uuid;

  MTGCard(
      {this.colorIdentity,
        this.colors,
        this.convertedManaCost,
        this.edhrecRank,
        this.foreignData,
        this.layout,
        this.legalities,
        this.manaCost,
        this.mtgArenaId,
        this.mtgoId,
        this.name,
        this.printings,
        this.purchaseUrls,
        this.rulings,
        this.scryfallOracleId,
        this.subtypes,
        this.supertypes,
        this.text,
        this.type,
        this.types,
        this.uuid});

  MTGCard.fromJson(Map<String, dynamic> json) {
    colorIdentity = json['colorIdentity'].cast<String>();
    colors = json['colors'].cast<String>();
    convertedManaCost = json['convertedManaCost'];
    edhrecRank = json['edhrecRank'];
    if (json['foreignData'] != null) {
      foreignData = new List<ForeignData>();
      json['foreignData'].forEach((v) {
        foreignData.add(new ForeignData.fromJson(v));
      });
    }
    layout = json['layout'];
    legalities = json['legalities'] != null
        ? new Legalities.fromJson(json['legalities'])
        : null;
    manaCost = json['manaCost'];
    mtgArenaId = json['mtgArenaId'];
    mtgoId = json['mtgoId'];
    name = json['name'];
    printings = json['printings'].cast<String>();
    purchaseUrls = json['purchaseUrls'] != null
        ? new PurchaseUrls.fromJson(json['purchaseUrls'])
        : null;
    if (json['rulings'] != null) {
      rulings = new List<Rulings>();
      json['rulings'].forEach((v) {
        rulings.add(new Rulings.fromJson(v));
      });
    }
    scryfallOracleId = json['scryfallOracleId'];
    if (json['subtypes'] != null) {
      subtypes = new List<Subtypes>();
      json['subtypes'].forEach((v) {
        subtypes.add(new Subtypes.fromJson(v));
      });
    }
    if (json['supertypes'] != null) {
      supertypes = new List<Supertypes>();
      json['supertypes'].forEach((v) {
        supertypes.add(new Supertypes.fromJson(v));
      });
    }
    text = json['text'];
    type = json['type'];
    types = json['types'].cast<String>();
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['colorIdentity'] = this.colorIdentity;
    data['colors'] = this.colors;
    data['convertedManaCost'] = this.convertedManaCost;
    data['edhrecRank'] = this.edhrecRank;
    if (this.foreignData != null) {
      data['foreignData'] = this.foreignData.map((v) => v.toJson()).toList();
    }
    data['layout'] = this.layout;
    if (this.legalities != null) {
      data['legalities'] = this.legalities.toJson();
    }
    data['manaCost'] = this.manaCost;
    data['mtgArenaId'] = this.mtgArenaId;
    data['mtgoId'] = this.mtgoId;
    data['name'] = this.name;
    data['printings'] = this.printings;
    if (this.purchaseUrls != null) {
      data['purchaseUrls'] = this.purchaseUrls.toJson();
    }
    if (this.rulings != null) {
      data['rulings'] = this.rulings.map((v) => v.toJson()).toList();
    }
    data['scryfallOracleId'] = this.scryfallOracleId;
    if (this.subtypes != null) {
      data['subtypes'] = this.subtypes.map((v) => v.toJson()).toList();
    }
    if (this.supertypes != null) {
      data['supertypes'] = this.supertypes.map((v) => v.toJson()).toList();
    }
    data['text'] = this.text;
    data['type'] = this.type;
    data['types'] = this.types;
    data['uuid'] = this.uuid;
    return data;
  }
}

class ForeignData {
  String flavorText;
  String language;
  String name;
  String text;
  String type;

  ForeignData(
      {this.flavorText, this.language, this.name, this.text, this.type});

  ForeignData.fromJson(Map<String, dynamic> json) {
    flavorText = json['flavorText'];
    language = json['language'];
    name = json['name'];
    text = json['text'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flavorText'] = this.flavorText;
    data['language'] = this.language;
    data['name'] = this.name;
    data['text'] = this.text;
    data['type'] = this.type;
    return data;
  }
}

class Legalities {
  String brawl;
  String commander;
  String duel;
  String future;
  String historic;
  String legacy;
  String modern;
  String pioneer;
  String standard;
  String vintage;

  Legalities(
      {this.brawl,
        this.commander,
        this.duel,
        this.future,
        this.historic,
        this.legacy,
        this.modern,
        this.pioneer,
        this.standard,
        this.vintage});

  Legalities.fromJson(Map<String, dynamic> json) {
    brawl = json['brawl'];
    commander = json['commander'];
    duel = json['duel'];
    future = json['future'];
    historic = json['historic'];
    legacy = json['legacy'];
    modern = json['modern'];
    pioneer = json['pioneer'];
    standard = json['standard'];
    vintage = json['vintage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brawl'] = this.brawl;
    data['commander'] = this.commander;
    data['duel'] = this.duel;
    data['future'] = this.future;
    data['historic'] = this.historic;
    data['legacy'] = this.legacy;
    data['modern'] = this.modern;
    data['pioneer'] = this.pioneer;
    data['standard'] = this.standard;
    data['vintage'] = this.vintage;
    return data;
  }
}

class PurchaseUrls {
  String cardmarket;
  String tcgplayer;

  PurchaseUrls({this.cardmarket, this.tcgplayer});

  PurchaseUrls.fromJson(Map<String, dynamic> json) {
    cardmarket = json['cardmarket'];
    tcgplayer = json['tcgplayer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardmarket'] = this.cardmarket;
    data['tcgplayer'] = this.tcgplayer;
    return data;
  }
}

class Rulings {
  String date;
  String text;

  Rulings({this.date, this.text});

  Rulings.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['text'] = this.text;
    return data;
  }
}

class Supertypes {
  String name;

  Supertypes();

  Supertypes.fromJson(String json){
    name = json;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class Subtypes {
  String name;

  Subtypes();

  Subtypes.fromJson(String json){
    name = json;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}