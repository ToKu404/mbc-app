import 'dart:convert';

import 'package:mbc_mobile/config/api.dart';
import 'package:http/http.dart' as http;
import 'package:mbc_mobile/models/laporan_model.dart';

abstract class LaporanRepository {
  Future<LaporanModel> laporanFetchByUserId(String id);
}

class LaporanRepositoryImpl implements LaporanRepository {
  static const String TAG = "LaporanRepositoryImpl";

  @override
  Future<LaporanModel> laporanFetchByUserId(String id) async {
    var _response = await http
        .get(Uri.parse(Api.instance.laporanURL + "/" + id.toString()));
    print("$TAG, laporanFetchByUserId ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      LaporanModel model = LaporanModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
}
