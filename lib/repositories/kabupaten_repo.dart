import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/kabupaten_model.dart';

abstract class KabupatenRepository {
  Future<KabupatenModel> kabupatenFetchData();
  
}

class KabupatenRepositoryImpl implements KabupatenRepository {

  static const String TAG = "KabupatenRepositoryImpl";

  @override
  Future<KabupatenModel> kabupatenFetchData() async{
    var _response = await http.get(Uri.parse(Api.instance.getKabupatens));
    // print("$TAG, kabupatenFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("kabupatenFetchData $data");
      KabupatenModel model = KabupatenModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
  
}