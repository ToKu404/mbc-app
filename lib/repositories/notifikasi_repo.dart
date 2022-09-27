import 'dart:convert';

import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/notifikasi_model.dart';
import 'package:http/http.dart' as http;


abstract class NotifikasiRepository {
  Future<NotifikasiModel> notifFetchByUserId(int id);
}

class NotifikasiRepositoryImpl implements NotifikasiRepository {

  static const String TAG = "NotifikasiRepositoryImpl";

  
  @override
  Future<NotifikasiModel> notifFetchByUserId(int id) async {

    var _response = await http.get(Uri.parse(Api.instance.notifURL+"/"+id.toString()));
    print("$TAG, notifFetchByUserId ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      NotifikasiModel model = NotifikasiModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
}
