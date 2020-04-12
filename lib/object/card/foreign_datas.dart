class ForeignData {
  String flavorText;
  String language;
  String name;
  String text;
  String type;

  ForeignData(
      {this.flavorText, this.language, this.name, this.text, this.type});

 ForeignData.fromJson(Map<String, dynamic> json) {
    flavorText = json['flavorText'] as String;
    language = json['language'] as String;
    name = json['name'] as String;
    text = json['text'] as String;
    type = json['type'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['flavorText'] = this.flavorText;
    data['language'] = this.language;
    data['name'] = this.name;
    data['text'] = this.text;
    data['type'] = this.type;
    return data;
  }
}