import 'package:mbc_mobile/models/sapi_model.dart';

class MasterSapiModel {
  String responsecode = "";
  String responsemsg = "";
  List<JenisSapi> jenisSapi = [];

  MasterSapiModel(
      {required this.responsecode,
      required this.responsemsg,
      required this.jenisSapi});

  MasterSapiModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['jenis_sapi'] != null) {
      jenisSapi = <JenisSapi>[];
      json['jenis_sapi'].forEach((v) {
        jenisSapi.add(new JenisSapi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['jenis_sapi'] = this.jenisSapi.map((v) => v.toJson()).toList();

    return data;
  }
}
