class HasilModel {
  String responsecode = "";
  String responsemsg = "";
  List<Hasil> hasil = [];

  HasilModel(
      {required this.responsecode,
      required this.responsemsg,
      required this.hasil});

  HasilModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['hasil'] != null) {
      hasil = <Hasil>[];
      json['hasil'].forEach((v) {
        hasil.add(new Hasil.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['hasil'] = this.hasil.map((v) => v.toJson()).toList();
    return data;
  }
}

class Hasil {
  int id = 0;
  String hasil = "";

  Hasil({required this.id, required this.hasil});

  Hasil.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hasil = json['hasil'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hasil'] = this.hasil;
    return data;
  }
}
