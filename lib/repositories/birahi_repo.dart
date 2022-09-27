import 'dart:convert';

import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/response_model.dart';

import 'package:http/http.dart' as http;

abstract class BirahiRepository {
  Future<ResponseModel> birahiStore(
      String notifId, String result, String tanggal);
}

class BirahiRepositoryImpl implements BirahiRepository {
  static const String TAG = "BirahiRepositoryImpl";

  @override
  Future<ResponseModel> birahiStore(
      String notifId, String result, String tanggal) async {
    var _response = await http.post(Uri.parse(Api.instance.birahiURL), body: {
      "result": result,
      "notif_id": notifId,
      "tanggal": tanggal,
    });
    print("$TAG, birahiStore ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("Data $data");
      ResponseModel model = ResponseModel.fromJson(data);

      return model;
    } else {
      throw Exception();
    }
  }
}
