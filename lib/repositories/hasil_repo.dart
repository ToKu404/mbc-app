import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/hasil_model.dart';

abstract class HasilRepository {
  Future<HasilModel> hasilFetchData();
}

class HasilRepositoryImpl implements HasilRepository {
  static const String TAG = "HasilRepositoryImpl";

  @override
  Future<HasilModel> hasilFetchData() async {
    var _response = await http.get(Uri.parse(Api.instance.hasilURL));
    print("$TAG, HasilFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("HasilFetchData $data");
      HasilModel model = HasilModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
}
