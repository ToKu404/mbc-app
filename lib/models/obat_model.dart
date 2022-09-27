class ObatModel {
  String responsecode = "";
  String responsemsg = "";
  List<Obat> obat = [];

  ObatModel(
      {required this.responsecode,
      required this.responsemsg,
      required this.obat});

  ObatModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['obat'] != null) {
      obat = <Obat>[];
      json['obat'].forEach((v) {
        obat.add(new Obat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['obat'] = this.obat.map((v) => v.toJson()).toList();
    return data;
  }
}

class Obat {
  int id = 0;
  String name = "";
  String detail = "";

  Obat({required this.id, required this.name, required this.detail});

  Obat.fromJson(Map<String, dynamic> json) {
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
