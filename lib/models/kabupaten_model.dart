class KabupatenModel {
  String responsecode = "";
  String responsemsg = "";
  List<Kabupaten> kabupaten = [];

  KabupatenModel({required this.responsecode, required this.responsemsg, required this.kabupaten});

  KabupatenModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['kabupaten'] != null) {
      json['kabupaten'].forEach((v) {
        kabupaten.add(new Kabupaten.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['kabupaten'] = this.kabupaten.map((v) => v.toJson()).toList();
    return data;
  }
}

class Kabupaten {
  int id = 0;
  String name = "";
  List<Kecamatans> kecamatans = [];

  Kabupaten(
      {required this.id, required this.name, required this.kecamatans});

  Kabupaten.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['kecamatans'] != null) {
      json['kecamatans'].forEach((v) {
        kecamatans.add(new Kecamatans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['kecamatans'] = this.kecamatans.map((v) => v.toJson()).toList();
    return data;
  }
}

class Kecamatans {
  int id = 0;
  int kabupatenId = 0;
  String name = "";
  List<Desas> desas = [];

  Kecamatans(
      {required this.id,
      required this.kabupatenId,
      required this.name,
      required this.desas});

  Kecamatans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kabupatenId = json['kabupaten_id'];
    name = json['name'];
    if (json['desas'] != null) {
      json['desas'].forEach((v) {
        desas.add(new Desas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kabupaten_id'] = this.kabupatenId;
    data['name'] = this.name;
    data['desas'] = this.desas.map((v) => v.toJson()).toList();
    return data;
  }
}

class Desas {
  int id  = 0;
  int kecamatanId = 0;
  String name = "";

  Desas({required this.id, required this.kecamatanId, required this.name});

  Desas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kecamatanId = json['kecamatan_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kecamatan_id'] = this.kecamatanId;
    data['name'] = this.name;
    return data;
  }
}

