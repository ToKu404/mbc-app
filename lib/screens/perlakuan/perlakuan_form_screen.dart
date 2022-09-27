import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/hormon_bloc/hormon_bloc.dart';
import 'package:mbc_mobile/bloc/obat_bloc/obat_bloc.dart';
import 'package:mbc_mobile/bloc/perlakuan_bloc/perlakuan_bloc.dart';
import 'package:mbc_mobile/bloc/sapi_bloc/sapi_bloc.dart';
import 'package:mbc_mobile/bloc/vaksin_bloc/vaksin_bloc.dart';
import 'package:mbc_mobile/bloc/vitamin_bloc/vitamin_bloc.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:mbc_mobile/repositories/perlakuan_master_repo.dart';
import 'package:mbc_mobile/repositories/perlakuan_repo.dart';
import 'package:mbc_mobile/repositories/sapi_repo.dart';
import 'package:mbc_mobile/screens/perlakuan/perlakuan_form_body.dart';
import 'package:mbc_mobile/utils/constants.dart';

class PerlakuanFormScreen extends StatelessWidget {
  final String userId;
  final String notifikasiId;
  final Sapi? sapi;
  final String hakAkses;

  const PerlakuanFormScreen(
      {Key? key,
      required this.userId,
      required this.notifikasiId,
      this.sapi,
      required this.hakAkses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Perlakuan Kesehatan",
            style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[kSecondaryColor, kPrimaryColor])),
        ),
      ),
      body: BlocProvider(
        create: (context) => ObatBloc(PerlakuanMasterRepositoryImpl()),
        child: BlocProvider(
          create: (context) => VitaminBloc(PerlakuanMasterRepositoryImpl()),
          child: BlocProvider(
            create: (context) => VaksinBloc(PerlakuanMasterRepositoryImpl()),
            child: BlocProvider(
              create: (context) => HormonBloc(PerlakuanMasterRepositoryImpl()),
              child: BlocProvider(
                create: (context) => PerlakuanBloc(PerlakuanRepositoryImpl()),
                child: BlocProvider(
                    create: (context) => SapiBloc(SapiRepositoryImpl()),
                    child: PerlakuanFormBody(
                        null, userId, notifikasiId, sapi, hakAkses)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
