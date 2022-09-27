import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/panen_model.dart';
import 'package:mbc_mobile/models/response_model.dart';

abstract class PanenRepository {
  Future<PanenModel> panenFetchData(String id);
  Future<ResponseModel> panenStore(File? file, Panen panen, String notifId);
}

class PanenRepositoryImpl implements PanenRepository {
  static const String TAG = "PanenRepositoryImpl";

  @override
  Future<PanenModel> panenFetchData(String id) async {
    var _response = await http.get(Uri.parse(Api.instance.panenURL + "/" + id));
    print("$TAG, PanenFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("PanenFetchData $data");
      PanenModel model = PanenModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<ResponseModel> panenStore(
      File? file, Panen panen, String notifId) async {
    print("file $file,  Periksa Kebuntingan ${panen.foto}");
    var request =
        new http.MultipartRequest("POST", Uri.parse(Api.instance.panenURL));

    request.fields['status'] = panen.status.toString();
    request.fields['sapi_id'] = panen.sapiId.toString();
    request.fields['foto'] = panen.foto;
    request.fields['id'] = panen.id.toString();
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
}
