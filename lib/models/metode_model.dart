class MetodeModel {
  String responsecode = "";
  String responsemsg = "";
  List<Metode> metode = [];

  MetodeModel(
      {required this.responsecode,
      required this.responsemsg,
      required this.metode});

  MetodeModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['metode'] != null) {
      metode = <Metode>[];
      json['metode'].forEach((v) {
        metode.add(new Metode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['metode'] = this.metode.map((v) => v.toJson()).toList();
    return data;
  }
}

class Metode {
  int id = 0;
  String metode = "";

  Metode({required this.id, required this.metode});

  Metode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metode = json['metode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['metode'] = this.metode;
    return data;
  }
}
