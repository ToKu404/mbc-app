class LaporanModel {
  String responsecode = "";
  String responsemsg = "";
  List<Laporan> laporan = [];

  LaporanModel(
      {required this.responsecode,
      required this.responsemsg,
      required this.laporan});

  LaporanModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    if (json['laporan'] != null) {
      laporan = <Laporan>[];
      json['laporan'].forEach((v) {
        laporan.add(new Laporan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    data['laporan'] = this.laporan.map((v) => v.toJson()).toList();
    return data;
  }
}

class Laporan {
  int id = 0;
  int sapiId = 0;
  int peternakId = 0;
  int pendampingId = 0;
  int tsrId = 0;
  String tanggal = "";
  String perlakuan = "";
  String upah = "";

  Laporan(
      {required this.id,
      required this.sapiId,
      required this.peternakId,
      required this.pendampingId,
      required this.tsrId,
      required this.tanggal,
      required this.perlakuan,
      required this.upah});

  Laporan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sapiId = json['sapi_id'];
    peternakId = json['peternak_id'];
    pendampingId = json['pendamping_id'];
    tsrId = json['tsr_id'];
    tanggal = json['tanggal'];
    perlakuan = json['perlakuan'];
    upah = json['upah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sapi_id'] = this.sapiId;
    data['peternak_id'] = this.peternakId;
    data['pendamping_id'] = this.pendampingId;
    data['tsr_id'] = this.tsrId;
    data['tanggal'] = this.tanggal;
    data['perlakuan'] = this.perlakuan;
    data['upah'] = this.upah;
    return data;
  }
}
