import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/birahi_bloc/birahi_bloc.dart';
import 'package:mbc_mobile/models/notifikasi_model.dart';
import 'package:mbc_mobile/repositories/birahi_repo.dart';
import 'package:mbc_mobile/screens/birahi/form_birahi_body.dart';
import 'package:mbc_mobile/utils/constants.dart';

class FormBirahiScreen extends StatelessWidget {
  final Notifikasi notif;
  final String userId;
  final String hakAkses;

  const FormBirahiScreen(
      {Key? key,
      required this.notif,
      required this.userId,
      required this.hakAkses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Form Birahi", style: TextStyle(color: Colors.white)),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[kSecondaryColor, kPrimaryColor])),
          ),
        ),
        body: BlocProvider(
          create: (context) => BirahiBloc(BirahiRepositoryImpl()),
          child:
              FormBirahiBody(notif: notif, userId: userId, hakAkses: hakAkses),
        ));
  }
}
