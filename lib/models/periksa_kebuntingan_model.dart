import 'hasil_model.dart';
import 'metode_model.dart';
import 'sapi_model.dart';

class PeriksaKebuntinganModel {
  String responsecode = "";
  String responsemsg = "";
  List<PeriksaKebuntingan> periksaKebuntingan = [];

  PeriksaKebuntinganModel(
      {required this.responsecode,
      required this.responsemsg,
      required this.periksaKebuntingan});

  PeriksaKebuntinganModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['periksa_kebuntingan'] != null) {
      periksaKebuntingan = <PeriksaKebuntingan>[];
      json['periksa_kebuntingan'].forEach((v) {
        periksaKebuntingan.add(new PeriksaKebuntingan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['periksa_kebuntingan'] =
        this.periksaKebuntingan.map((v) => v.toJson()).toList();
    return data;
  }
}

class PeriksaKebuntingan {
  int id = 0;
  int sapiId = 0;
  int peternakId = 0;
  int pendampingId = 0;
  int tsrId = 0;
  String waktuPk = "";
  int status = 0;
  int reproduksi = 0;
  int metodeId = 0;
  int hasilId = 0;
  String foto = "";
  Sapi? sapi;
  Hasil? hasil;
  Metode? metode;

  PeriksaKebuntingan(
      {required this.id,
      required this.sapiId,
      required this.peternakId,
      required this.pendampingId,
      required this.tsrId,
      required this.waktuPk,
      required this.status,
      required this.reproduksi,
      required this.metodeId,
      required this.hasilId,
      required this.foto,
      this.sapi,
      this.hasil,
      this.metode});

  PeriksaKebuntingan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sapiId = json['sapi_id'];
    peternakId = json['peternak_id'];
    pendampingId = json['pendamping_id'];
    tsrId = json['tsr_id'];
    waktuPk = json['waktu_pk'];
    status = json['status'];
    reproduksi = json['reproduksi'];
    metodeId = json['metode_id'];
    hasilId = json['hasil_id'];
    foto = json['foto'];
    sapi = json['sapi'] != null ? new Sapi.fromJson(json['sapi']) : null;
    hasil = json['hasil'] != null ? new Hasil.fromJson(json['hasil']) : null;
    metode =
        json['metode'] != null ? new Metode.fromJson(json['metode']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sapi_id'] = this.sapiId;
    data['peternak_id'] = this.peternakId;
    data['pendamping_id'] = this.pendampingId;
    data['tsr_id'] = this.tsrId;
    data['waktu_pk'] = this.waktuPk;
    data['status'] = this.status;
    data['reproduksi'] = this.reproduksi;
    data['metode_id'] = this.metodeId;
    data['hasil_id'] = this.hasilId;
    data['foto'] = this.foto;
    if (this.sapi != null) {
      data['sapi'] = this.sapi!.toJson();
    }
    if (this.hasil != null) {
      data['hasil'] = this.hasil!.toJson();
    }
    if (this.metode != null) {
      data['metode'] = this.metode!.toJson();
    }
    return data;
  }
}
