import 'sapi_model.dart';

class NotifikasiModel {
  String responsecode = "";
  String responsemsg = "";
  List<Notifikasi> notifikasi = [];

  NotifikasiModel(
      {required this.responsecode,
      required this.responsemsg,
      required this.notifikasi});

  NotifikasiModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['notifikasi'] != null) {
      notifikasi = <Notifikasi>[];
      json['notifikasi'].forEach((v) {
        notifikasi.add(new Notifikasi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['notifikasi'] = this.notifikasi.map((v) => v.toJson()).toList();
    return data;
  }
}

class Notifikasi {
  int id = 0;
  int sapiId = 0;
  String tanggal = "";
  String pesan = "";
  String role = "";
  String status = "";
  Sapi? sapi;

  Notifikasi(
      {required this.id,
      required this.sapiId,
      required this.tanggal,
      required this.pesan,
      required this.role,
      required this.status,
      this.sapi});

  Notifikasi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sapiId = json['sapi_id'];
    tanggal = json['tanggal'];
    pesan = json['pesan'];
    role = json['role'];
    status = json['status'];
    sapi = json['sapi'] != null ? new Sapi.fromJson(json['sapi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sapi_id'] = this.sapiId;
    data['tanggal'] = this.tanggal;
    data['pesan'] = this.pesan;
    data['role'] = this.role;
    data['status'] = this.status;
    if (this.sapi != null) {
      data['sapi'] = this.sapi!.toJson();
    }
    return data;
  }
}
