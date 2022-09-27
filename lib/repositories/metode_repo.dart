import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/metode_model.dart';

abstract class MetodeRepository {
  Future<MetodeModel> metodeFetchData();
}

class MetodeRepositoryImpl implements MetodeRepository {
  static const String TAG = "MetodeRepositoryImpl";

  @override
  Future<MetodeModel> metodeFetchData() async {
    var _response = await http.get(Uri.parse(Api.instance.metodeURL));
    print("$TAG, MetodeFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("MetodeFetchData $data");
      MetodeModel model = MetodeModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
}
