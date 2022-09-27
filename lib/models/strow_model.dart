import 'package:mbc_mobile/models/sapi_model.dart';

class StrowModel {
  String responsecode = "";
  String responsemsg = "";
  List<Strow> strow = [];

  StrowModel({required this.responsecode, required this.responsemsg, required this.strow});

  StrowModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['strow'] != null) {
      json['strow'].forEach((v) {
        strow.add(new Strow.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['strow'] = this.strow.map((v) => v.toJson()).toList();
    return data;
  }
}

class Strow {
  int id = 0;
  int sapiId = 0;
  String kodeBatch = "";
  String batch = "";
  Sapi? sapi;

  Strow(
      {required this.id,
      required this.sapiId,
      required this.kodeBatch,
      required this.batch,
      this.sapi});

  Strow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sapiId = json['sapi_id'];
    kodeBatch = json['kode_batch'];
    batch = json['batch'];
    sapi = json['sapi'] != null ? new Sapi.fromJson(json['sapi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sapi_id'] = this.sapiId;
    data['kode_batch'] = this.kodeBatch;
    data['batch'] = this.batch;
    if (this.sapi != null) {
      data['sapi'] = this.sapi!.toJson();
    }
    return data;
  }
}
