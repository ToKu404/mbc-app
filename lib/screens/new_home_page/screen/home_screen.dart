import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mbc_mobile/bloc/notif_bloc/notifikasi_bloc.dart';
import 'package:mbc_mobile/models/notifikasi_model.dart';
import 'package:mbc_mobile/screens/birahi/form_birahi_screen.dart';
import 'package:mbc_mobile/screens/insiminasi_buatan/insiminasi_buatan_form_screen.dart';
import 'package:mbc_mobile/screens/insiminasi_buatan/insiminasi_buatan_screen.dart';
import 'package:mbc_mobile/screens/new_home_page/home_card_peternak.dart';
import 'package:mbc_mobile/screens/new_home_page/home_card_sapi.dart';
import 'package:mbc_mobile/screens/panen/panen_form_screen.dart';
import 'package:mbc_mobile/screens/panen/panen_screen.dart';
import 'package:mbc_mobile/screens/performa/performa_form_screen.dart';
import 'package:mbc_mobile/screens/performa/performa_screen.dart';
import 'package:mbc_mobile/screens/periksa_kebuntingan/form/periksa_kebuntingan_form_screen.dart';
import 'package:mbc_mobile/screens/periksa_kebuntingan/periksa_kebuntingan_screen.dart';
import 'package:mbc_mobile/screens/perlakuan/perlakuan_form_screen.dart';
import 'package:mbc_mobile/screens/perlakuan/perlakuan_screen.dart';
import 'package:mbc_mobile/screens/sapi/form_sapi_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  final String userId;
  final String hakAkses;

  const HomeScreen({Key? key, required this.userId, required this.hakAkses})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NotifikasiBloc notifikasiBloc;

  List<Notifikasi> listNotif = [];

  String dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    notifikasiBloc = BlocProvider.of(context);

    notifikasiBloc.add(NotifFetchByUserId(id: int.parse(widget.userId)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Container(
      child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 16),
        BlocBuilder<NotifikasiBloc, NotifikasiState>(
          builder: (context, state) {
            if (state is NotifikasiSuccessState) {
              listNotif = [];
              state.datas.notifikasi.forEach((e) {
                if (e.status == "no") {
                  var date1 =
                      DateTime.parse(e.tanggal).millisecondsSinceEpoch.toInt();
                  var date2 =
                      DateTime.parse(dateNow).millisecondsSinceEpoch.toInt();

                  if (e.role == "0" || e.role == "6") {
                    if (date1 <= date2) {
                      listNotif.add(e);
                    }
                  } else {
                    if (e.tanggal == dateNow) {
                      listNotif.add(e);
                    }
                  }
                }
              });
              return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: (listNotif.isNotEmpty)
                    ? ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        leading: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green[100]),
                          child: Icon(
                            FontAwesomeIcons.bell,
                            color: kSecondaryColor,
                          ),
                        ),
                        initiallyExpanded: false,
                        title: Text('Notifikasi (${listNotif.length})',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54)),
                        children: [
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: listNotif.length,
                              itemBuilder: (context, index) {
                                var data = listNotif[index];
                                return notifCard(data);
                              }),
                        ],
                      )
                    : Center(),
              );

              //
            } else if (state is NotifikasiErrorState) {
              return buildError(state.error);
            } else {
              return buildLoading();
            }
          },
        ),

        Padding(
          padding: EdgeInsets.only(bottom: 16, top: 16),
          child: Text("Menu Perlakuan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        // HomeMenuCard(),
        menuList(),

        Visibility(
          visible: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text("Ongoing Promo",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              SizedBox(height: getProportionateScreenHeight(8)),
              Container(
                width: SizeConfig.screenWidth,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(colors: [
                    Colors.green.shade100,
                    kPrimaryColor,
                  ]),
                ),
                child: Row(
                  children: [
                    Expanded(child: Image.asset(Images.farmImage)),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text("Have u done your progress today ?",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Text("Sapi Ternak",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        HomeCardSapi(
            userId: widget.userId.toString(), hakAkses: widget.hakAkses),

        SizedBox(height: getProportionateScreenHeight(16)),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text("Peternak",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        HomeCardPeternak(userId: widget.userId.toString()),

        SizedBox(height: getProportionateScreenHeight(80)),
      ])),
    );
  }

  GestureDetector notifCard(Notifikasi data) {
    return GestureDetector(
      onTap: () {
        if (widget.hakAkses == "3") {
          if (data.role == "4") {
            gotoAnotherPage(
                PerlakuanFormScreen(
                    userId: widget.userId,
                    notifikasiId: data.id.toString(),
                    sapi: data.sapi,
                    hakAkses: widget.hakAkses),
                context);
          } else if (data.role == "2") {
            gotoAnotherPage(
                PerformaFormScreen(
                    null, widget.userId, null, data.sapi, widget.hakAkses),
                context);
          } else if (data.role == "1") {
            gotoAnotherPage(
                PeriksaKebuntinganFormScreen(null, widget.userId, data.sapi,
                    data.id.toString(), widget.hakAkses),
                context);
          } else if (data.role == "0") {
            gotoAnotherPage(
                FormBirahiScreen(
                    notif: data,
                    userId: widget.userId,
                    hakAkses: widget.hakAkses),
                context);
          } else if (data.role == "3") {
            gotoAnotherPage(
                InsiminasiBuatanFormScreen(null, widget.userId,
                    data.id.toString(), data.sapi, widget.hakAkses),
                context);
          } else if (data.role == "5") {
            gotoAnotherPage(
                PanenFormScreen(null, widget.userId, data.sapi,
                    data.id.toString(), widget.hakAkses),
                context);
          } else if (data.role == "6") {
            gotoAnotherPage(
                SapiFormScreen(
                    sapi: data.sapi!,
                    userId: widget.userId,
                    hakAkses: widget.hakAkses),
                context);
          }
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        height: 40,
        decoration: BoxDecoration(
            color: kSecondaryColor, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Expanded(
              child: Text(
                  "${data.pesan} ke sapi MBC-${data.sapi!.generasi}.${data.sapi!.anakKe}-${data.sapi!.eartagInduk}-${data.sapi!.eartag}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 8),
            SvgPicture.asset("assets/icons/Bell.svg", color: Colors.white),
          ],
        ),
      ),
    );
  }

  Column menuList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: GestureDetector(
                    onTap: () => gotoAnotherPage(
                        PerformaScreen(
                            userId: widget.userId.toString(),
                            hakAkses: widget.hakAkses),
                        context),
                    child: homeMenu(Icons.insert_chart, "Performa"))),
            Expanded(
                child: GestureDetector(
                    onTap: () => gotoAnotherPage(
                        PerlakuanScreen(
                            userId: widget.userId.toString(),
                            hakAkses: widget.hakAkses),
                        context),
                    child: homeMenu(FontAwesomeIcons.bookReader, "Perlakuan"))),
            Expanded(
                child: GestureDetector(
                    onTap: () => gotoAnotherPage(
                        PeriksaKebuntinganScreen(
                            id: widget.userId.toString(),
                            hakAkses: widget.hakAkses),
                        context),
                    child: homeMenu(FontAwesomeIcons.box, "PKB"))),
            Expanded(
                child: GestureDetector(
                    onTap: () => gotoAnotherPage(
                        InsiminasiBuatanScreen(
                            userId: widget.userId.toString(),
                            hakAkses: widget.hakAkses),
                        context),
                    child: homeMenu(Icons.archive, "IB"))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: GestureDetector(
                    onTap: () => gotoAnotherPage(
                        PanenScreen(
                            null, widget.userId.toString(), widget.hakAkses),
                        context),
                    child:
                        homeMenu(Icons.home_repair_service_rounded, "Panen"))),
            Expanded(child: Container()),
            Expanded(child: Container()),
            Expanded(child: Container()),
          ],
        ),
      ],
    );
  }

  Widget homeMenu(IconData icon, String title) {
    return Container(
      height: 80,
      child: Container(
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green[100]),
              child: Icon(
                icon,
                color: kSecondaryColor,
              ),
            ),
            Text(title,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  void gotoAnotherPage(Widget landingPage, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return landingPage;
    })).then((value) => setState(() {}));
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
