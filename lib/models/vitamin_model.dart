class VitaminModel {
  String responsecode = "";
  String responsemsg = "";
  List<Vitamin> vitamin = [];

  VitaminModel(
      {required this.responsecode,
      required this.responsemsg,
      required this.vitamin});

  VitaminModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['vitamin'] != null) {
      vitamin = <Vitamin>[];
      json['vitamin'].forEach((v) {
        vitamin.add(new Vitamin.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['vitamin'] = this.vitamin.map((v) => v.toJson()).toList();
    return data;
  }
}

class Vitamin {
  int id = 0;
  String name = "";
  String detail = "";

  Vitamin({required this.id, required this.name, required this.detail});

  Vitamin.fromJson(Map<String, dynamic> json) {
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
