import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/periksa_kebuntingan_model.dart';
import 'package:mbc_mobile/models/response_model.dart';

abstract class PeriksaKebuntinganRepository {
  Future<PeriksaKebuntinganModel> periksaKebuntinganFetchData(String id);
  Future<ResponseModel> periksaKebuntinganStore(
      File? file, PeriksaKebuntingan periksaKebuntingan, String notifId);
  Future<PeriksaKebuntinganModel> periksaKebuntinganDelete(
      PeriksaKebuntingan periksaKebuntingan, String userId);
}

class PeriksaKebuntinganRepositoryImpl implements PeriksaKebuntinganRepository {
  static const String TAG = "PeriksaKebuntinganRepositoryImpl";

  @override
  Future<PeriksaKebuntinganModel> periksaKebuntinganFetchData(String id) async {
    var _response = await http
        .get(Uri.parse(Api.instance.periksaKebuntinganURL + "/" + id));
    print("$TAG, PeriksaKebuntinganFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("PeriksaKebuntinganFetchData $data");
      PeriksaKebuntinganModel model = PeriksaKebuntinganModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<ResponseModel> periksaKebuntinganStore(
      File? file, PeriksaKebuntingan periksaKebuntingan, String notifId) async {
    print("file $file,  Periksa Kebuntingan ${periksaKebuntingan.foto}");
    var request = new http.MultipartRequest(
        "POST", Uri.parse(Api.instance.periksaKebuntinganURL));

    request.fields['metode_id'] = periksaKebuntingan.metodeId.toString();
    request.fields['hasil_id'] = periksaKebuntingan.hasilId.toString();
    request.fields['sapi_id'] = periksaKebuntingan.sapiId.toString();
    request.fields['foto'] = periksaKebuntingan.foto;
    request.fields['status'] = periksaKebuntingan.status.toString();
    request.fields['reproduksi'] = periksaKebuntingan.reproduksi.toString();
    request.fields['id'] = periksaKebuntingan.id.toString();
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
  Future<PeriksaKebuntinganModel> periksaKebuntinganDelete(
      PeriksaKebuntingan periksaKebuntingan, String userId) async {
    var _response = await http.delete(Uri.parse(
        Api.instance.periksaKebuntinganURL +
            "/" +
            periksaKebuntingan.id.toString() +
            "/" +
            userId));
    print("$TAG, PeriksaKebuntinganDelete ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("Data $data");
      PeriksaKebuntinganModel model = PeriksaKebuntinganModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
}
