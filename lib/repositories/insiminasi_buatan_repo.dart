import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/insiminasi_buatan_model.dart';
import 'package:mbc_mobile/models/response_model.dart';

abstract class InsiminasiBuatanRepository {
  Future<InsiminasiBuatanModel> insiminasiBuatanFetchData(String id);
  Future<ResponseModel> insiminasiBuatanStore(
      File? file, InsiminasiBuatan insiminasiBuatan, String notifId);
  Future<InsiminasiBuatanModel> insiminasiBuatanUpdate(
      InsiminasiBuatan insiminasiBuatan);
  Future<InsiminasiBuatanModel> insiminasiBuatanDelete(
      InsiminasiBuatan insiminasiBuatan);
}

class InsiminasiBuatanRepositoryImpl implements InsiminasiBuatanRepository {
  static const String TAG = "InsiminasiBuatanRepositoryImpl";

  @override
  Future<InsiminasiBuatanModel> insiminasiBuatanFetchData(String id) async {
    var _response = await http.get(Uri.parse(Api.instance.ibURL + "/" + id));
    print("$TAG, InsiminasiBuatanFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("InsiminasiBuatanFetchData $data");
      InsiminasiBuatanModel model = InsiminasiBuatanModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<ResponseModel> insiminasiBuatanStore(
      File? file, InsiminasiBuatan insiminasiBuatan, String notifId) async {
    var request =
        new http.MultipartRequest("POST", Uri.parse(Api.instance.ibURL));

    request.fields['dosis_ib'] = insiminasiBuatan.dosisIb.toString();
    request.fields['strow_id'] = insiminasiBuatan.strowId.toString();
    request.fields['sapi_id'] = insiminasiBuatan.sapiId.toString();
    request.fields['notifikasi_id'] = notifId;

    if (file != null) {
      final resFile = await http.MultipartFile.fromPath('image', file.path,
          contentType: new MediaType('application', 'x-tar'));
      request.files.add(resFile);
    } else {
      request.fields['image'] = "";
    }

    final data = await request.send();
    final response = await http.Response.fromStream(data);
    print("response ${response.statusCode}");
    if (response.statusCode == 201) {
      var data = json.decode(response.body);
      print("Data $data");
      ResponseModel model = ResponseModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<InsiminasiBuatanModel> insiminasiBuatanUpdate(
      InsiminasiBuatan insiminasiBuatan) async {
    var url = Api.instance.ibURL + "/" + insiminasiBuatan.id.toString();

    var _response = await http.put(Uri.parse(url), body: {
      "sapiId": insiminasiBuatan.sapiId.toString(),
      "strowId": insiminasiBuatan.strowId.toString(),
      "waktu": insiminasiBuatan.waktuIb,
      "dosis": insiminasiBuatan.dosisIb.toString(),
    });
    print("$TAG, InsiminasiBuatanUpdate ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("Data $data");
      InsiminasiBuatanModel model = InsiminasiBuatanModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<InsiminasiBuatanModel> insiminasiBuatanDelete(
      InsiminasiBuatan insiminasiBuatan) async {
    var _response = await http.delete(
        Uri.parse(Api.instance.ibURL + "/" + insiminasiBuatan.id.toString()));
    print("$TAG, InsiminasiBuatanDelete ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("Data $data");
      InsiminasiBuatanModel model = InsiminasiBuatanModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
}
