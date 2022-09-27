import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/master_sapi_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class SapiMasterRepository {
  Future<MasterSapiModel> sapiMasterFetchData();
}

class SapiMasterRepositoryImpl implements SapiMasterRepository {
  @override
  Future<MasterSapiModel> sapiMasterFetchData() async {
    var _response = await http.get(Uri.parse(Api.instance.sapiMasterURL));
    print("SapiMasterRepositoryImpl${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("PerlakuanFetchData $data");
      MasterSapiModel model = MasterSapiModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
}
