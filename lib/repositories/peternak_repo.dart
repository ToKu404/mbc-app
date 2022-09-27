import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/peternak_model.dart';

abstract class PeternakRepository {
  Future<PeternakModel> peternakFetchData(String id);
  Future<PeternakModel> peternakStore(Peternak peternak);
  Future<PeternakModel> peternakUpdate(Peternak peternak);
}

class PeternakRepositoryImpl implements PeternakRepository {
  static const String TAG = "PeternakRepositoryImpl";

  @override
  Future<PeternakModel> peternakFetchData(String id) async {
    var _response = await http
        .get(Uri.parse(Api.instance.peternakURL + "/" + id.toString()));
    print("$TAG, PeternakFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("PeternakFetchData $data");
      PeternakModel model = PeternakModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PeternakModel> peternakStore(Peternak peternak) async {
    var _response = await http.post(Uri.parse(Api.instance.peternakURL), body: {
      "desa_id": peternak.desaId.toString(),
      "kode_peternak": peternak.kodePeternak,
      "nama_peternak": peternak.namaPeternak,
      "no_hp": peternak.noHp,
      "tgl_lahir": peternak.jumlahAnggota,
      "jumlah_anggota": peternak.jumlahAnggota,
      "luas_lahan": peternak.luasLahan,
      "kelompok": peternak.kelompokId,
    });
    print("$TAG, PeternakStore ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("Data $data");
      PeternakModel model = PeternakModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PeternakModel> peternakUpdate(Peternak peternak) async {
    var url = Api.instance.peternakURL + "/" + peternak.id.toString();

    var _response = await http.put(Uri.parse(url), body: {
      "desa_id": peternak.desaId.toString(),
      "kode_peternak": peternak.kodePeternak,
      "nama_peternak": peternak.namaPeternak,
      "no_hp": peternak.noHp,
      "tgl_lahir": peternak.jumlahAnggota,
      "jumlah_anggota": peternak.jumlahAnggota,
      "luas_lahan": peternak.luasLahan,
      "kelompok": peternak.kelompokId,
    });
    print("$TAG, peternakUpdate ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("Data $data");
      PeternakModel model = PeternakModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
}
