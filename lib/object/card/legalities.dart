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
    brawl = json['brawl'] as String;
    commander = json['commander'] as String;
    duel = json['duel'] as String;
    future = json['future'] as String;
    historic = json['historic'] as String;
    legacy = json['legacy'] as String;
    modern = json['modern'] as String;
    pioneer = json['pioneer'] as String;
    standard = json['standard'] as String;
    vintage = json['vintage'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
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