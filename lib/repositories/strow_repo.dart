import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/strow_model.dart';

abstract class StrowRepository {
  Future<StrowModel> strowFetchData();
  Future<StrowModel> strowStore(Strow strow);
  Future<StrowModel> strowUpdate(Strow strow);
  Future<StrowModel> strowDelete(Strow strow);
}

class StrowRepositoryImpl implements StrowRepository {
  static const String TAG = "StrowRepositoryImpl";

  @override
  Future<StrowModel> strowFetchData() async {
    var _response = await http.get(Uri.parse(Api.instance.strowURL));
    print("$TAG, StrowFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("StrowFetchData $data");
      StrowModel model = StrowModel.fromJson(data);

      print(model);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<StrowModel> strowStore(Strow strow) async {
    var _response = await http.post(Uri.parse(Api.instance.strowURL), body: {
      "sapiId": strow.sapiId.toString(),
      "kode": strow.kodeBatch,
      "batch": strow.batch,
    });
    print("$TAG, StrowStore ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("Data $data");
      StrowModel model = StrowModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<StrowModel> strowUpdate(Strow strow) async {
    var url = Api.instance.strowURL + "/" + strow.id.toString();

    var _response = await http.put(Uri.parse(url), body: {
      "sapiId": strow.sapiId.toString(),
      "kode": strow.kodeBatch,
      "batch": strow.batch,
    });
    print("$TAG, StrowUpdate ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("Data $data");
      StrowModel model = StrowModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<StrowModel> strowDelete(Strow strow) async {
    var _response = await http
        .delete(Uri.parse(Api.instance.strowURL + "/" + strow.id.toString()));
    print("$TAG, StrowDelete ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("Data $data");
      StrowModel model = StrowModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
}
