import 'package:mtg_deck_builder_mobile/object/card/purchase_urls.dart';
import 'package:mtg_deck_builder_mobile/object/card/rulings.dart';
import 'package:mtg_deck_builder_mobile/object/card/subtypes.dart';
import 'package:mtg_deck_builder_mobile/object/card/supertypes.dart';
import 'foreign_datas.dart';
import 'legalities.dart';

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
    colorIdentity = json['colorIdentity'].cast<String>() as List<String>;
    colors = json['colors'].cast<String>() as List<String>;
    convertedManaCost = json['convertedManaCost'] as double;
    edhrecRank = json['edhrecRank'] as int;
    if (json['foreignData'] != null) {
      foreignData =  List<ForeignData>();
      json['foreignData'].forEach((dynamic  v) {
        foreignData.add( ForeignData.fromJson(v as Map<String, dynamic>));
      });
    }
    layout = json['layout'] as String;
    legalities = json['legalities'] != null
        ?  Legalities.fromJson(json['legalities'] as Map<String, dynamic>)
        : null;
    manaCost = json['manaCost'] as String;
    mtgArenaId = json['mtgArenaId'] as int;
    mtgoId = json['mtgoId'] as int;
    name = json['name'] as String;
    printings = json['printings'].cast<String>() as List<String>;
    purchaseUrls = json['purchaseUrls'] != null
        ?  PurchaseUrls.fromJson(json['purchaseUrls'] as Map<String, dynamic>)
        : null;
    if (json['rulings'] != null) {
      rulings =  List<Rulings>();
      json['rulings'].forEach((dynamic v) {
        rulings.add( Rulings.fromJson(v as Map<String, dynamic>));
      });
    }
    scryfallOracleId = json['scryfallOracleId'] as String;
    if (json['subtypes'] != null) {
      subtypes =  List<Subtypes>();
      json['subtypes'].forEach((dynamic v) {
        subtypes.add( Subtypes.fromJson(v as String));
      });
    }
    if (json['supertypes'] != null) {
      supertypes =  List<Supertypes>();
      json['supertypes'].forEach((dynamic v) {
        supertypes.add( Supertypes.fromJson(v as String));
      });
    }
    text = json['text'] as String;
    type = json['type'] as String;
    types = json['types'].cast<String>() as List<String>;
    uuid = json['uuid'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
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
