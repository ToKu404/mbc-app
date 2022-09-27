import 'package:mbc_mobile/models/hormon_model.dart';
import 'package:mbc_mobile/models/obat_model.dart';
import 'package:mbc_mobile/models/vaksin_model.dart';
import 'package:mbc_mobile/models/vitamin_model.dart';

import 'sapi_model.dart';

class PerlakuanModel {
  String responsecode = "";
  String responsemsg = "";
  List<Perlakuan> perlakuan = [];

  PerlakuanModel(
      {required this.responsecode,
      required this.responsemsg,
      required this.perlakuan});

  PerlakuanModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['perlakuan'] != null) {
      perlakuan = <Perlakuan>[];
      json['perlakuan'].forEach((v) {
        perlakuan.add(new Perlakuan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['perlakuan'] = this.perlakuan.map((v) => v.toJson()).toList();
    return data;
  }
}

class Perlakuan {
  int id = 0;
  int sapiId = 0;
  int peternakId = 0;
  int pendampingId = 0;
  int tsrId = 0;
  String tglPerlakuan = "";
  int obatId = 0;
  int dosisObat = 0;
  int vaksinId = 0;
  int dosisVaksin = 0;
  int vitaminId = 0;
  int dosisVitamin = 0;
  int hormonId = 0;
  int dosisHormon = 0;
  String ketPerlakuan = "";
  String foto = "";
  Sapi? sapi;
  Obat? obat;
  Vitamin? vitamin;
  Vaksin? vaksin;
  Hormon? hormon;

  Perlakuan({
    required this.id,
    required this.sapiId,
    required this.peternakId,
    required this.pendampingId,
    required this.tsrId,
    required this.tglPerlakuan,
    required this.obatId,
    required this.dosisObat,
    required this.vaksinId,
    required this.dosisVaksin,
    required this.vitaminId,
    required this.dosisVitamin,
    required this.hormonId,
    required this.dosisHormon,
    required this.ketPerlakuan,
    required this.foto,
    this.sapi,
    this.obat,
    this.vitamin,
    this.vaksin,
    this.hormon,
  });

  Perlakuan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sapiId = json['sapi_id'];
    peternakId = json['peternak_id'];
    pendampingId = json['pendamping_id'];
    tsrId = json['tsr_id'];
    tglPerlakuan = json['tgl_perlakuan'];
    obatId = json['obat_id'];
    dosisObat = json['dosis_obat'];
    vaksinId = json['vaksin_id'];
    dosisVaksin = json['dosis_vaksin'];
    vitaminId = json['vitamin_id'];
    dosisVitamin = json['dosis_vitamin'];
    hormonId = json['hormon_id'];
    dosisHormon = json['dosis_hormon'];
    ketPerlakuan = json['ket_perlakuan'];
    foto = json['foto'];
    sapi = json['sapi'] != null ? new Sapi.fromJson(json['sapi']) : null;
    obat = json['obat'] != null ? new Obat.fromJson(json['obat']) : null;
    vitamin =
        json['vitamin'] != null ? new Vitamin.fromJson(json['vitamin']) : null;
    vaksin =
        json['vaksin'] != null ? new Vaksin.fromJson(json['vaksin']) : null;
    hormon =
        json['hormon'] != null ? new Hormon.fromJson(json['hormon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sapi_id'] = this.sapiId;
    data['peternak_id'] = this.peternakId;
    data['pendamping_id'] = this.pendampingId;
    data['tsr_id'] = this.tsrId;
    data['tgl_perlakuan'] = this.tglPerlakuan;
    data['obat_id'] = this.obatId;
    data['dosis_obat'] = this.dosisObat;
    data['vaksin_id'] = this.vaksinId;
    data['dosis_vaksin'] = this.dosisVaksin;
    data['vitamin_id'] = this.vitaminId;
    data['dosis_vitamin'] = this.dosisVitamin;
    data['hormon_id'] = this.hormonId;
    data['dosis_hormon'] = this.dosisHormon;
    data['ket_perlakuan'] = this.ketPerlakuan;
    data['foto'] = this.foto;
    if (this.sapi != null) {
      data['sapi'] = this.sapi!.toJson();
    }
    if (this.obat != null) {
      data['obat'] = this.obat!.toJson();
    }
    if (this.vitamin != null) {
      data['vitamin'] = this.vitamin!.toJson();
    }
    if (this.vaksin != null) {
      data['vaksin'] = this.vaksin!.toJson();
    }
    if (this.hormon != null) {
      data['hormon'] = this.hormon!.toJson();
    }
    return data;
  }
}
