import 'package:mbc_mobile/models/peternak_model.dart';

class SapiModel {
  String responsecode = "";
  String responsemsg = "";
  List<Sapi> sapi = [];

  SapiModel(
      {required this.responsecode,
      required this.responsemsg,
      required this.sapi});

  SapiModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['sapi'] != null) {
      sapi = <Sapi>[];
      json['sapi'].forEach((v) {
        sapi.add(new Sapi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['sapi'] = this.sapi.map((v) => v.toJson()).toList();
    return data;
  }
}

class Sapi {
  int id = 0;
  int jenisSapiId = 0;
  String eartag = "";
  String eartagInduk = "";
  String namaSapi = "";
  String tanggalLahir = "";
  String kelamin = "";
  String kondisiLahir = "";
  String anakKe = "";
  String generasi = "";
  String fotoDepan = "";
  String fotoSamping = "";
  String fotoPeternak = "";
  String fotoRumah = "";
  int peternakId = 0;
  JenisSapi? jenisSapi;
  Peternak? peternak;

  Sapi(
      {required this.id,
      required this.jenisSapiId,
      required this.eartag,
      required this.eartagInduk,
      required this.namaSapi,
      required this.tanggalLahir,
      required this.kelamin,
      required this.kondisiLahir,
      required this.anakKe,
      required this.generasi,
      required this.fotoDepan,
      required this.fotoSamping,
      required this.fotoPeternak,
      required this.fotoRumah,
      required this.peternakId,
      this.jenisSapi,
      this.peternak});

  Sapi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jenisSapiId = json['jenis_sapi_id'];
    eartag = json['eartag'];
    eartagInduk = json['eartag_induk'];
    namaSapi = json['nama_sapi'];
    tanggalLahir = json['tanggal_lahir'];
    kelamin = json['kelamin'];
    kondisiLahir = json['kondisi_lahir'];
    anakKe = json['anak_ke'];
    generasi = json['generasi'];
    fotoDepan = json['foto_depan'];
    fotoSamping = json['foto_samping'];
    fotoPeternak = json['foto_peternak'];
    fotoRumah = json['foto_rumah'];
    peternakId = json['peternak_id'];
    jenisSapi = json['jenis_sapi'] != null
        ? new JenisSapi.fromJson(json['jenis_sapi'])
        : null;

    peternak = json['peternak'] != null
        ? new Peternak.fromJson(json['peternak'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jenis_sapi_id'] = this.jenisSapiId;
    data['eartag'] = this.eartag;
    data['eartag_induk'] = this.eartagInduk;
    data['nama_sapi'] = this.namaSapi;
    data['tanggal_lahir'] = this.tanggalLahir;
    data['kelamin'] = this.kelamin;
    data['kondisi_lahir'] = this.kondisiLahir;
    data['anak_ke'] = this.anakKe;
    data['generasi'] = this.generasi;
    data['foto_depan'] = this.fotoDepan;
    data['foto_samping'] = this.fotoSamping;
    data['foto_peternak'] = this.fotoPeternak;
    data['foto_rumah'] = this.fotoRumah;
    data['peternak_id'] = this.peternakId;
    if (this.jenisSapi != null) {
      data['jenis_sapi'] = this.jenisSapi!.toJson();
    }

    if (this.peternak != null) {
      data['peternak'] = this.peternak!.toJson();
    }
    return data;
  }
}

class JenisSapi {
  int id = 0;
  String jenis = "";
  String ketJenis = "";

  JenisSapi({required this.id, required this.jenis, required this.ketJenis});

  JenisSapi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jenis = json['jenis'];
    ketJenis = json['ket_jenis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jenis'] = this.jenis;
    data['ket_jenis'] = this.ketJenis;
    return data;
  }
}
