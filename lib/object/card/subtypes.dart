class Subtypes {
  String name;

  Subtypes();

  Subtypes.fromJson(String json){
    name = json;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    return data;
  }
}