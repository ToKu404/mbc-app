import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mbc_mobile/bloc/auth_bloc/authentication_bloc.dart';
import 'package:mbc_mobile/bloc/laporan_bloc/laporan_bloc.dart';
import 'package:mbc_mobile/bloc/user_bloc/user_bloc.dart';
import 'package:mbc_mobile/screens/new_home_page/screen/guide_screen.dart';
import 'package:mbc_mobile/screens/new_home_page/screen/home_screen.dart';
import 'package:mbc_mobile/screens/new_home_page/screen/setting_screen.dart';
import 'package:mbc_mobile/screens/new_home_page/screen/todo_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class HomePage extends StatefulWidget {
  final String userId;
  final String hakAkses;
  final AuthenticationBloc bloc;

  const HomePage(
      {Key? key,
      required this.userId,
      required this.bloc,
      required this.hakAkses})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  var containerRadius = const Radius.circular(30.0);

  late UserBloc userBloc;
  late LaporanBloc laporanBloc;

  @override
  void initState() {
    userBloc = BlocProvider.of(context);
    laporanBloc = BlocProvider.of(context);

    userBloc.add(UserFetchSingleData(id: widget.userId));
    laporanBloc.add(LaporanFetchDataEvent(widget.userId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(16),
                        right: getProportionateScreenWidth(16)),
                    height: size.height * 0.30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                                if (state is UserSingleLoadedState) {
                                  return RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: "Hello\n",
                                        style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: '${state.user.name}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ]));
                                } else {
                                  return Text(". . .",
                                      style: TextStyle(
                                          fontSize: 26,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold));
                                }
                              },
                            ),
                            SizedBox(height: getProportionateScreenHeight(16)),
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/Cash.svg",
                                    color: Colors.white),
                                SizedBox(width: 16),
                                cardKinerja(),
                              ],
                            )
                          ],
                        )),
                        Image.asset(
                          Images.farmerImage,
                          width: 200,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(16),
                        right: getProportionateScreenWidth(16),
                        top: getProportionateScreenHeight(16)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: containerRadius,
                            topRight: containerRadius)),
                    child: _index == 0
                        ? HomeScreen(
                            userId: widget.userId, hakAkses: widget.hakAkses)
                        : _index == 1
                            ? TodoScreen(
                                userId: widget.userId,
                                hakAkses: widget.hakAkses)
                            : _index == 2
                                ? GuideScreen(userId: widget.userId)
                                : SettingScreen(
                                    userId: widget.userId, bloc: widget.bloc),
                  ))
                ],
              ),
              Positioned(
                bottom: getProportionateScreenHeight(16),
                left: getProportionateScreenWidth(30),
                right: getProportionateScreenWidth(30),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: _listMenu("assets/icons/home-filled.svg", 0)),
                      Expanded(
                          flex: 1,
                          child:
                              _listMenu("assets/icons/bookmark-filled.svg", 1)),
                      Expanded(
                          flex: 1,
                          child:
                              _listMenu("assets/icons/Question mark.svg", 2)),
                      Expanded(
                          flex: 1,
                          child: _listMenu("assets/icons/Settings.svg", 3)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listMenu(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _index = index;
        });
      },
      child: Container(
        height: getProportionateScreenHeight(70),
        decoration: BoxDecoration(
            color: _index == index ? kSecondaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Center(
            child: SvgPicture.asset(
              title,
              color: _index == index ? Colors.white : kSecondaryColor,
              height: 30,
            ),
          ),
        ),
      ),
    );
  }

  BlocBuilder<LaporanBloc, LaporanState> cardKinerja() {
    return BlocBuilder<LaporanBloc, LaporanState>(
      builder: (context, state) {
        if (state is LaporanLoadedState) {
          var total = 0;
          state.model.laporan.forEach((e) {
            total += int.parse(e.upah);
          });
          return Center(
            child: Text(
                "Rp. " +
                    NumberFormat("#,##0", "en_US")
                        .format(int.parse(total.toString())),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          );
        }
        if (state is LaporanErrorState) {
          return Center(child: Text(state.errorMsg));
        } else {
          return Center(
              child: Text('. . .',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold)));
        }
      },
    );
  }
}
