import 'sapi_model.dart';

class PanenModel {
  String responsecode = "";
  String responsemsg = "";
  List<Panen>? panen = [];

  PanenModel(
      {required this.responsecode,
      required this.responsemsg,
      required this.panen});

  PanenModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['panen'] != null) {
      panen = <Panen>[];
      json['panen'].forEach((v) {
        panen!.add(new Panen.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    if (this.panen != null) {
      data['panen'] = this.panen!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Panen {
  int id = 0;
  int sapiId = 0;
  int peternakId = 0;
  int pendampingId = 0;
  int tsrId = 0;
  String status = "";
  String keterangan = "";
  String tanggal = "";
  String foto = "";
  Sapi? sapi;

  Panen(
      {required this.id,
      required this.sapiId,
      required this.peternakId,
      required this.pendampingId,
      required this.tsrId,
      required this.status,
      required this.keterangan,
      required this.tanggal,
      required this.foto,
      this.sapi});

  Panen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sapiId = json['sapi_id'];
    peternakId = json['peternak_id'];
    pendampingId = json['pendamping_id'];
    tsrId = json['tsr_id'];
    status = json['status'];
    keterangan = json['keterangan'];
    tanggal = json['tanggal'];
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
    data['status'] = this.status;
    data['keterangan'] = this.keterangan;
    data['tanggal'] = this.tanggal;
    data['foto'] = this.foto;
    if (this.sapi != null) {
      data['sapi'] = this.sapi!.toJson();
    }
    return data;
  }
}
