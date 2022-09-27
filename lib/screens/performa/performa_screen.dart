import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/performa_bloc/performa_bloc.dart';
import 'package:mbc_mobile/repositories/performa_repo.dart';
import 'package:mbc_mobile/screens/performa/performa_body.dart';
import 'package:mbc_mobile/utils/constants.dart';

class PerformaScreen extends StatelessWidget {
  static String routeName = "performa";
  final String userId;
  final String hakAkses;

  const PerformaScreen({Key? key, required this.userId, required this.hakAkses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Performa", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[kSecondaryColor, kPrimaryColor])),
        ),
      ),
      body: BlocProvider(
        create: (context) => PerformaBloc(PerformaRepositoryImpl()),
        child: Container(
            padding: EdgeInsets.all(8),
            child: PerformaBody(userId: userId, hakAkses: hakAkses)),
      ),
    );
  }
}
