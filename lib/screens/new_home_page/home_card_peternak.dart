import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/peternak_bloc/peternak_bloc.dart';
import 'package:mbc_mobile/bloc/peternak_bloc/peternak_event.dart';
import 'package:mbc_mobile/bloc/peternak_bloc/peternak_state.dart';
import 'package:mbc_mobile/models/peternak_model.dart';
import 'package:mbc_mobile/repositories/peternak_repo.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class HomeCardPeternak extends StatefulWidget {
  final String userId;
  const HomeCardPeternak({Key? key, required this.userId}) : super(key: key);

  @override
  _HomeCardPeternakState createState() => _HomeCardPeternakState();
}

class _HomeCardPeternakState extends State<HomeCardPeternak> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PeternakBloc(PeternakRepositoryImpl()),
      child: HomeCardPeternakBody(userId: widget.userId),
    );
  }
}

class HomeCardPeternakBody extends StatefulWidget {
  final String userId;

  const HomeCardPeternakBody({Key? key, required this.userId})
      : super(key: key);

  @override
  _HomeCardPeternakBodyState createState() => _HomeCardPeternakBodyState();
}

class _HomeCardPeternakBodyState extends State<HomeCardPeternakBody> {
  static const TAG = "HomeCardPeternak";
  late PeternakBloc peternakBloc;

  @override
  void initState() {
    peternakBloc = BlocProvider.of(context);
    peternakBloc.add(PeternakFetchDataEvent(userId: widget.userId.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocBuilder<PeternakBloc, PeternakState>(
      builder: (context, state) {
        print("$TAG $state");
        if (state is PeternakLoadedState) {
          return buildList(state.datas, size);
        } else if (state is PeternakErrorState) {
          return buildError(state.msg);
        } else {
          return buildLoading();
        }
      },
    );
  }

  Container buildList(List<Peternak> list, Size size) {
    return Container(
      height: 250,
      child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var data = list[index];
            return Container(
              margin: EdgeInsets.all(8),
              height: 250,
              width: size.width * 0.40,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.green.shade100,
                        kPrimaryColor,
                      ]),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: kSecondaryColor)),
              child: Column(
                children: [
                  Expanded(child: Image.asset(Images.farmImage)),
                  Text(data.namaPeternak,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  Text(data.noHp,
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  SizedBox(height: getProportionateScreenHeight(16)),
                ],
              ),
            );
          }),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildError(String msg) {
    return Center(
      child: Text(msg,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    );
  }
}
