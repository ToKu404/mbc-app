import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/perlakuan_model.dart';
import 'package:mbc_mobile/models/response_model.dart';

abstract class PerlakuanRepository {
  Future<PerlakuanModel> perlakuanFetchData(String id);
  Future<ResponseModel> perlakuanStore(
      File? file, Perlakuan perlakuan, String notifikasiId);
  Future<PerlakuanModel> perlakuanDelete(Perlakuan perlakuan);
}

class PerlakuanRepositoryImpl implements PerlakuanRepository {
  static const String TAG = "PerlakuanRepositoryImpl";

  @override
  Future<PerlakuanModel> perlakuanFetchData(String id) async {
    var _response =
        await http.get(Uri.parse(Api.instance.perlakuanURL + "/" + id));
    print("$TAG, PerlakuanFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("PerlakuanFetchData $data");
      PerlakuanModel model = PerlakuanModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<ResponseModel> perlakuanStore(
      File? file, Perlakuan perlakuan, String notifikasiId) async {
    var request =
        new http.MultipartRequest("POST", Uri.parse(Api.instance.perlakuanURL));

    print(perlakuan.ketPerlakuan);

    request.fields['id'] = perlakuan.id.toString();
    request.fields['sapi_id'] = perlakuan.sapiId.toString();
    request.fields['obat_id'] = perlakuan.obatId.toString();
    request.fields['obat_dosis'] = perlakuan.dosisObat.toString();
    request.fields['vitamin_id'] = perlakuan.vitaminId.toString();
    request.fields['vitamin_dosis'] = perlakuan.dosisVitamin.toString();
    request.fields['vaksin_id'] = perlakuan.vaksinId.toString();
    request.fields['vaksin_dosis'] = perlakuan.dosisVaksin.toString();
    request.fields['hormon_id'] = perlakuan.hormonId.toString();
    request.fields['hormon_dosis'] = perlakuan.dosisHormon.toString();
    request.fields['ket_perlakuan'] = perlakuan.ketPerlakuan.toString();
    request.fields['foto'] = perlakuan.foto.toString();

    request.fields['notifikasi_id'] = notifikasiId;

    if (file != null) {
      final resFile = await http.MultipartFile.fromPath('image', file.path,
          contentType: new MediaType('application', 'x-tar'));
      request.files.add(resFile);
    } else {
      request.fields['image'] = "";
    }

    final data = await request.send();
    final response = await http.Response.fromStream(data);
    print("response ${request.fields}");
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
  Future<PerlakuanModel> perlakuanDelete(Perlakuan perlakuan) async {
    var _response = await http.delete(
        Uri.parse(Api.instance.perlakuanURL + "/" + perlakuan.id.toString()));
    print("$TAG, PerlakuanDelete ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("Data $data");
      PerlakuanModel model = PerlakuanModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
}
