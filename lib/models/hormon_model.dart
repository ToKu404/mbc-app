class HormonModel {
  String responsecode = "";
  String responsemsg = "";
  List<Hormon> hormon = [];

  HormonModel(
      {required this.responsecode,
      required this.responsemsg,
      required this.hormon});

  HormonModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['hormon'] != null) {
      hormon = <Hormon>[];
      json['hormon'].forEach((v) {
        hormon.add(new Hormon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['hormon'] = this.hormon.map((v) => v.toJson()).toList();
    return data;
  }
}

class Hormon {
  int id = 0;
  String name = "";
  String detail = "";

  Hormon({required this.id, required this.name, required this.detail});

  Hormon.fromJson(Map<String, dynamic> json) {
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
