import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/perlakuan_bloc/perlakuan_bloc.dart';
import 'package:mbc_mobile/repositories/perlakuan_repo.dart';
import 'package:mbc_mobile/screens/perlakuan/perlakuan_body.dart';
import 'package:mbc_mobile/utils/constants.dart';

class PerlakuanScreen extends StatelessWidget {
  static String routeName = "perlakuan";
  final String userId;
  final String hakAkses;

  const PerlakuanScreen(
      {Key? key, required this.userId, required this.hakAkses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Perlakuan", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[kSecondaryColor, kPrimaryColor])),
        ),
      ),
      body: BlocProvider(
        create: (context) => PerlakuanBloc(PerlakuanRepositoryImpl()),
        child: Container(
            padding: EdgeInsets.all(8),
            child: PerlakuanBody(userId: userId, hakAkses: hakAkses)),
      ),
    );
  }
}
