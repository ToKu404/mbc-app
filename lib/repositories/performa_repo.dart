import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/performa_model.dart';
import 'package:mbc_mobile/models/response_model.dart';

abstract class PerformaRepository {
  Future<PerformaModel> performaFetchData(String id);
  Future<ResponseModel> performaStore(File? file, Performa performa);
  Future<PerformaModel> performaUpdate(Performa performa);
  Future<PerformaModel> performaDelete(Performa performa);
}

class PerformaRepositoryImpl implements PerformaRepository {
  static const String TAG = "PerformaRepositoryImpl";

  @override
  Future<PerformaModel> performaFetchData(String id) async {
    var _response =
        await http.get(Uri.parse(Api.instance.performaURL + "/" + id));
    print("$TAG, PerformaFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("PerformaFetchData $data");
      PerformaModel model = PerformaModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<ResponseModel> performaStore(File? file, Performa performa) async {
    var request =
        new http.MultipartRequest("POST", Uri.parse(Api.instance.performaURL));

    request.fields['tinggi_badan'] = performa.tinggiBadan.toString();
    request.fields['berat_badan'] = performa.beratBadan.toString();
    request.fields['panjang_badan'] = performa.panjangBadan.toString();
    request.fields['lingkar_dada'] = performa.lingkarDada.toString();
    request.fields['bsc'] = performa.bsc.toString();
    request.fields['sapi_id'] = performa.sapiId.toString();

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
      // print("Data $data");
      ResponseModel model = ResponseModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PerformaModel> performaUpdate(Performa performa) async {
    var url = Api.instance.performaURL + "/" + performa.id.toString();

    var _response = await http.put(Uri.parse(url), body: {
      "tanggal": performa.tanggalPerforma,
      "tinggi": performa.tinggiBadan.toString(),
      "berat": performa.beratBadan.toString(),
      "panjang": performa.panjangBadan.toString(),
      "lingkar": performa.lingkarDada.toString(),
      "bsc": performa.bsc.toString(),
      "sapiId": performa.sapiId.toString(),
    });
    print("$TAG, PerformaUpdate ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("Data $data");
      PerformaModel model = PerformaModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PerformaModel> performaDelete(Performa performa) async {
    var _response = await http.delete(
        Uri.parse(Api.instance.performaURL + "/" + performa.id.toString()));
    print("$TAG, PerformaDelete ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("Data $data");
      PerformaModel model = PerformaModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
}
