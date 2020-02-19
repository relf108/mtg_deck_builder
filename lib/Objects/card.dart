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
