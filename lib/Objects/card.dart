class MTGCard {
  String cardName;
  String manaCost;
  String keyword;
  String etbEffect;
  String tapEffect;
  int power;
  int toughness;

  MTGCard(this.cardName, this.manaCost, this.keyword, this.etbEffect,
      this.tapEffect, this.power, this.toughness);

  MTGCard.fromJson(Map<String, dynamic> json) {
    cardName = json['card_name'];
    manaCost = json['mana_cost'];
    keyword = json['keyword'];
    etbEffect = json['etb_effect'];
    tapEffect = json['tap_effect'];
    power = json['power'];
    toughness = json['toughness'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_name'] = this.cardName;
    data['mana_cost'] = this.manaCost;
    data['keyword'] = this.keyword;
    data['etb_effect'] = this.etbEffect;
    data['tap_effect'] = this.tapEffect;
    data['power'] = this.power;
    data['toughness'] = this.toughness;
    return data;
  }

  void printCard() async {
    print(
        cardName); //Why does this return "Instance of 'Future<dynamic>'" instead of a card object?
    // now returning instance of MTG card
  }
}
