import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/periksa_kebuntingan_bloc/periksa_kebuntingan_bloc.dart';
import 'package:mbc_mobile/repositories/periksa_kebuntingan_repo.dart';
import 'package:mbc_mobile/screens/periksa_kebuntingan/periksa_kebuntingan_body.dart';
import 'package:mbc_mobile/utils/constants.dart';

class PeriksaKebuntinganScreen extends StatelessWidget {
  static String routeName = "periksa_kebuntingan";
  final String id;
  final String hakAkses;

  const PeriksaKebuntinganScreen(
      {Key? key, required this.id, required this.hakAkses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Periksa Kebuntingan",
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
        create: (context) =>
            PeriksaKebuntinganBloc(PeriksaKebuntinganRepositoryImpl()),
        child: Container(
            padding: EdgeInsets.all(8),
            child: PeriksaKebuntinganBody(id: id, hakAkses: hakAkses)),
      ),
    );
  }
}
