import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/peternak_sapi_model.dart';

abstract class PeternakSapiRepository {
  Future<PeternakSapiModel> peternakSapiFetchData(String id);
}

class PeternakSapiRepositoryImpl implements PeternakSapiRepository {
  static const String TAG = "PeternakSapiRepositoryImpl";

  @override
  Future<PeternakSapiModel> peternakSapiFetchData(String id) async {
    var _response =
        await http.get(Uri.parse(Api.instance.peternakSapiURL + "/" + id));
    print("$TAG, PeternakSapiFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("PeternakSapiFetchData $data");
      PeternakSapiModel model = PeternakSapiModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
}
