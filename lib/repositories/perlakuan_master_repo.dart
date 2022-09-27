import 'dart:convert';

import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/hormon_model.dart';
import 'package:mbc_mobile/models/obat_model.dart';
import 'package:mbc_mobile/models/vaksin_model.dart';
import 'package:mbc_mobile/models/vitamin_model.dart';

import 'package:http/http.dart' as http;

abstract class PerlakuanMasterRepository {
  Future<ObatModel> obatFetchData();
  Future<VitaminModel> vitaminFetchData();
  Future<VaksinModel> vaksinFetchData();
  Future<HormonModel> hormonFetchData();
}

class PerlakuanMasterRepositoryImpl implements PerlakuanMasterRepository {
  @override
  Future<HormonModel> hormonFetchData() async {
    var _response =
        await http.get(Uri.parse(Api.instance.perlakuanURL + "/master/hormon"));
    print("PerlakuanMasterRepository, hormonFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("PerlakuanFetchData $data");
      HormonModel model = HormonModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<ObatModel> obatFetchData() async {
    var _response =
        await http.get(Uri.parse(Api.instance.perlakuanURL + "/master/obat"));
    print("PerlakuanMasterRepository, obatFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("PerlakuanFetchData $data");
      ObatModel model = ObatModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<VaksinModel> vaksinFetchData() async {
    var _response =
        await http.get(Uri.parse(Api.instance.perlakuanURL + "/master/vaksin"));
    print("PerlakuanMasterRepository, vaksinFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("PerlakuanFetchData $data");
      VaksinModel model = VaksinModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<VitaminModel> vitaminFetchData() async {
    var _response = await http
        .get(Uri.parse(Api.instance.perlakuanURL + "/master/vitamin"));
    print(
        "PerlakuanMasterRepository, vitaminFetchData ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      // print("PerlakuanFetchData $data");
      VitaminModel model = VitaminModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
}
