import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/insiminasi_buatan_bloc/insiminasi_buatan_bloc.dart';
import 'package:mbc_mobile/repositories/insiminasi_buatan_repo.dart';
import 'package:mbc_mobile/screens/insiminasi_buatan/insiminasi_buatan_body.dart';
import 'package:mbc_mobile/utils/constants.dart';

class InsiminasiBuatanScreen extends StatelessWidget {
  static String routeName = "insiminasi_buatan";
  final String userId;
  final String hakAkses;

  const InsiminasiBuatanScreen(
      {Key? key, required this.userId, required this.hakAkses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Insiminasi Buatan",
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
            InsiminasiBuatanBloc(InsiminasiBuatanRepositoryImpl()),
        child: Container(
            padding: EdgeInsets.all(16),
            child: InsiminasiBuatanBody(userId: userId, hakAkses: hakAkses)),
      ),
    );
  }
}
