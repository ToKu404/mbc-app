class VaksinModel {
  String responsecode = "";
  String responsemsg = "";
  List<Vaksin> vaksin = [];

  VaksinModel(
      {required this.responsecode,
      required this.responsemsg,
      required this.vaksin});

  VaksinModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['vaksin'] != null) {
      vaksin = <Vaksin>[];
      json['vaksin'].forEach((v) {
        vaksin.add(new Vaksin.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['vaksin'] = this.vaksin.map((v) => v.toJson()).toList();
    return data;
  }
}

class Vaksin {
  int id = 0;
  String name = "";
  String detail = "";

  Vaksin({required this.id, required this.name, required this.detail});

  Vaksin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['detail'] = this.detail;
    return data;
  }
}
