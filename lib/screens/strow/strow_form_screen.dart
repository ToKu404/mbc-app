import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/sapi_bloc/sapi_bloc.dart';
import 'package:mbc_mobile/bloc/strow_bloc/strow_bloc.dart';
import 'package:mbc_mobile/models/strow_model.dart';
import 'package:mbc_mobile/repositories/sapi_repo.dart';
import 'package:mbc_mobile/repositories/strow_repo.dart';
import 'package:mbc_mobile/screens/strow/strow_form_body.dart';
import 'package:mbc_mobile/utils/constants.dart';

class StrowFormScreen extends StatelessWidget {
  final Strow strow;
  final String userId;

  const StrowFormScreen({Key? key, required this.strow, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Strow", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[kSecondaryColor, kPrimaryColor])),
        ),
      ),
      body: BlocProvider(
        create: (context) => StrowBloc(StrowRepositoryImpl()),
        child: BlocProvider(
            create: (context) => SapiBloc(SapiRepositoryImpl()),
            child: StrowFormBody(strow: strow, userId: userId)),
      ),
    );
  }
}
