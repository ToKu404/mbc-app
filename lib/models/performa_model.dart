import 'sapi_model.dart';

class PerformaModel {
  String responsecode = "";
  String responsemsg = "";
  List<Performa> performa = [];

  PerformaModel(
      {required this.responsecode,
      required this.responsemsg,
      required this.performa});

  PerformaModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['performa'] != null) {
      performa = <Performa>[];
      json['performa'].forEach((v) {
        performa.add(new Performa.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['performa'] = this.performa.map((v) => v.toJson()).toList();
    return data;
  }
}

class Performa {
  int id = 0;
  int sapiId = 0;
  int peternakId = 0;
  int pendampingId = 0;
  int tsrId = 0;
  String tanggalPerforma = "";
  int tinggiBadan = 0;
  int beratBadan = 0;
  int panjangBadan = 0;
  int lingkarDada = 0;
  int bsc = 0;
  String foto = "";
  Sapi? sapi;

  Performa(
      {required this.id,
      required this.sapiId,
      required this.peternakId,
      required this.pendampingId,
      required this.tsrId,
      required this.tanggalPerforma,
      required this.tinggiBadan,
      required this.beratBadan,
      required this.panjangBadan,
      required this.lingkarDada,
      required this.bsc,
      required this.foto,
      this.sapi});

  Performa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sapiId = json['sapi_id'];
    peternakId = json['peternak_id'];
    pendampingId = json['pendamping_id'];
    tsrId = json['tsr_id'];
    tanggalPerforma = json['tanggal_performa'];
    tinggiBadan = json['tinggi_badan'];
    beratBadan = json['berat_badan'];
    panjangBadan = json['panjang_badan'];
    lingkarDada = json['lingkar_dada'];
    bsc = json['bsc'];
    foto = json['foto'];
    sapi = json['sapi'] != null ? new Sapi.fromJson(json['sapi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sapi_id'] = this.sapiId;
    data['peternak_id'] = this.peternakId;
    data['pendamping_id'] = this.pendampingId;
    data['tsr_id'] = this.tsrId;
    data['tanggal_performa'] = this.tanggalPerforma;
    data['tinggi_badan'] = this.tinggiBadan;
    data['berat_badan'] = this.beratBadan;
    data['panjang_badan'] = this.panjangBadan;
    data['lingkar_dada'] = this.lingkarDada;
    data['bsc'] = this.bsc;
    data['foto'] = this.foto;
    if (this.sapi != null) {
      data['sapi'] = this.sapi!.toJson();
    }
    return data;
  }
}
