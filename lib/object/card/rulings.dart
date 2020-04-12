class Rulings {
  String date;
  String text;

  Rulings({this.date, this.text});

  Rulings.fromJson(Map<String, dynamic> json) {
    date = json['date'] as String;
    text = json['text'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['date'] = this.date;
    data['text'] = this.text;
    return data;
  }
}