class PurchaseUrls {
  String cardmarket;
  String tcgplayer;

  PurchaseUrls({this.cardmarket, this.tcgplayer});

  PurchaseUrls.fromJson(Map<String, dynamic> json) {
    cardmarket = json['cardmarket'] as String;
    tcgplayer = json['tcgplayer'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['cardmarket'] = this.cardmarket;
    data['tcgplayer'] = this.tcgplayer;
    return data;
  }
}