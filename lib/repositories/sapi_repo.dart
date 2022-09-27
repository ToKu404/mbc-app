import 'dart:convert';
import 'dart:io';

import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/performa_model.dart';
import 'package:mbc_mobile/models/response_model.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

abstract class SapiRepository {
  Future<SapiModel> sapiFetchData(String id);
  Future<ResponseModel> sapiStore(
      File? fotoDepan,
      File? fotoSamping,
      File? fotoPeternak,
      File? fotoRumah,
      Sapi sapi,
      File? fotoPerforma,
      Performa performa);
}

class SapiRepositoryImpl implements SapiRepository {
  static const String TAG = "SapiRepositoryImpl";

  @override
  Future<SapiModel> sapiFetchData(String id) async {
    var _response = await http.get(Uri.parse(Api.instance.sapiURL + "/" + id));
    print("$TAG, sapiFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("sapiFetchData $data");
      SapiModel model = SapiModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<ResponseModel> sapiStore(
      File? fotoDepan,
      File? fotoSamping,
      File? fotoPeternak,
      File? fotoRumah,
      Sapi sapi,
      File? fotoPerforma,
      Performa performa) async {
    var request =
        new http.MultipartRequest("POST", Uri.parse(Api.instance.sapiURL));

    request.fields['eartag_induk'] = sapi.eartagInduk;
    request.fields['anak_ke'] = sapi.anakKe.toString();
    request.fields['nama_sapi'] = sapi.namaSapi.toString();
    request.fields['kelamin'] = sapi.kelamin.toString();
    request.fields['kondisi_lahir'] = sapi.kondisiLahir.toString();
    request.fields['jenis_sapi_id'] = sapi.jenisSapiId.toString();
    request.fields['peternak_id'] = sapi.peternakId.toString();

    request.fields['tinggi_badan'] = performa.tinggiBadan.toString();
    request.fields['berat_badan'] = performa.beratBadan.toString();
    request.fields['panjang_badan'] = performa.panjangBadan.toString();
    request.fields['lingkar_dada'] = performa.lingkarDada.toString();
    request.fields['bsc'] = performa.bsc.toString();

    if (fotoDepan != null) {
      final resFile = await http.MultipartFile.fromPath(
          'foto_depan', fotoDepan.path,
          contentType: new MediaType('application', 'x-tar'));
      request.files.add(resFile);
    } else {
      request.fields['foto_depan'] = "";
    }

    if (fotoSamping != null) {
      final resFile = await http.MultipartFile.fromPath(
          'foto_samping', fotoSamping.path,
          contentType: new MediaType('application', 'x-tar'));
      request.files.add(resFile);
    } else {
      request.fields['foto_samping'] = "";
    }
    if (fotoPeternak != null) {
      final resFile = await http.MultipartFile.fromPath(
          'foto_peternak', fotoPeternak.path,
          contentType: new MediaType('application', 'x-tar'));
      request.files.add(resFile);
    } else {
      request.fields['foto_peternak'] = "";
    }
    if (fotoRumah != null) {
      final resFile = await http.MultipartFile.fromPath(
          'foto_rumah', fotoRumah.path,
          contentType: new MediaType('application', 'x-tar'));
      request.files.add(resFile);
    } else {
      request.fields['foto_rumah'] = "";
    }
    if (fotoPerforma != null) {
      final resFile = await http.MultipartFile.fromPath(
          'image', fotoPerforma.path,
          contentType: new MediaType('application', 'x-tar'));
      request.files.add(resFile);
    } else {
      request.fields['image'] = "";
    }

    // print(fotoRumah);
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
