import 'peternak_model.dart';
import 'sapi_model.dart';

class PeternakSapiModel {
  String responsecode = "";
  String responsemsg = "";
  List<PeternakSapi> peternakSapi = [];

  PeternakSapiModel(
      {required this.responsecode,
      required this.responsemsg,
      required this.peternakSapi});

  PeternakSapiModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['peternak_sapi'] != null) {
      peternakSapi = <PeternakSapi>[];
      json['peternak_sapi'].forEach((v) {
        peternakSapi.add(new PeternakSapi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['peternak_sapi'] = this.peternakSapi.map((v) => v.toJson()).toList();
    return data;
  }
}

class PeternakSapi {
  int id = 0;
  String date = "";
  int tsrId = 0;
  int pendampingId = 0;
  int peternakId = 0;
  int sapiId = 0;
  Tsr? tsr;
  Tsr? pendamping;
  Peternak? peternak;
  Sapi? sapi;

  PeternakSapi(
      {required this.id,
      required this.date,
      required this.tsrId,
      required this.pendampingId,
      required this.peternakId,
      required this.sapiId,
      this.tsr,
      this.pendamping,
      this.peternak,
      this.sapi});

  PeternakSapi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    tsrId = json['tsr_id'];
    pendampingId = json['pendamping_id'];
    peternakId = json['peternak_id'];
    sapiId = json['sapi_id'];
    tsr = json['tsr'] != null ? new Tsr.fromJson(json['tsr']) : null;
    pendamping = json['pendamping'] != null
        ? new Tsr.fromJson(json['pendamping'])
        : null;
    peternak = json['peternak'] != null
        ? new Peternak.fromJson(json['peternak'])
        : null;
    sapi = json['sapi'] != null ? new Sapi.fromJson(json['sapi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['tsr_id'] = this.tsrId;
    data['pendamping_id'] = this.pendampingId;
    data['peternak_id'] = this.peternakId;
    data['sapi_id'] = this.sapiId;
    if (this.tsr != null) {
      data['tsr'] = this.tsr!.toJson();
    }
    if (this.pendamping != null) {
      data['pendamping'] = this.pendamping!.toJson();
    }
    if (this.peternak != null) {
      data['peternak'] = this.peternak!.toJson();
    }
    if (this.sapi != null) {
      data['sapi'] = this.sapi!.toJson();
    }
    return data;
  }
}

class Tsr {
  int id = 0;
  int userId = 0;

  Tsr({required this.id, required this.userId});

  Tsr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    return data;
  }
}
