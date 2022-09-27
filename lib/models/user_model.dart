class UserModel {
  String responsecode = "";
  String responsemsg = "";
  User? user;

  UserModel({required this.responsecode, required this.responsemsg, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    responsecode = json['responsecode'];
    responsemsg = json['responsemsg'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responsecode'] = this.responsecode;
    data['responsemsg'] = this.responsemsg;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int id = 0;
  String email = "";
  String name = "";
  String alamat = "";
  String noHp = "";
  String hakAkses = "";

  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.alamat,
      required this.noHp,
      required this.hakAkses,});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    alamat = json['alamat'];
    noHp = json['no_hp'];
    hakAkses = json['hak_akses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['alamat'] = this.alamat;
    data['no_hp'] = this.noHp;
    data['hak_akses'] = this.hakAkses;
    return data;
  }
}

