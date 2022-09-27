import 'dart:io';

import 'package:mbc_mobile/models/sapi_model.dart';

class DataResultSapi {
  final Sapi sapi;
  final File? fotoDepan;
  final File? fotoSamping;
  final File? fotoPeternak;
  final File? fotoRumah;

  DataResultSapi(this.sapi, this.fotoDepan, this.fotoSamping, this.fotoPeternak,
      this.fotoRumah);
}
