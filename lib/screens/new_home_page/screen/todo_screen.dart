import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mbc_mobile/bloc/notif_bloc/notifikasi_bloc.dart';
import 'package:mbc_mobile/models/notifikasi_model.dart';
import 'package:mbc_mobile/screens/birahi/form_birahi_screen.dart';
import 'package:mbc_mobile/screens/insiminasi_buatan/insiminasi_buatan_form_screen.dart';
import 'package:mbc_mobile/screens/panen/panen_form_screen.dart';
import 'package:mbc_mobile/screens/performa/performa_form_screen.dart';
import 'package:mbc_mobile/screens/periksa_kebuntingan/form/periksa_kebuntingan_form_screen.dart';
import 'package:mbc_mobile/screens/perlakuan/perlakuan_form_screen.dart';
import 'package:mbc_mobile/screens/sapi/form_sapi_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class TodoScreen extends StatefulWidget {
  final String userId;
  final String hakAkses;
  const TodoScreen({Key? key, required this.userId, required this.hakAkses})
      : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotifikasiBloc, NotifikasiState>(
      builder: (context, state) {
        if (state is NotifikasiSuccessState) {
          return BuildBody(
            dataNotifikasi: state.datas.notifikasi,
            hakAkses: widget.hakAkses,
            userId: widget.userId,
          );
        } else if (state is NotifikasiErrorState) {
          return buildError(state.error);
        } else {
          return buildLoading();
        }
      },
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

class BuildBody extends StatefulWidget {
  final String userId;
  final String hakAkses;
  final List<Notifikasi> dataNotifikasi;
  const BuildBody(
      {Key? key,
      required this.dataNotifikasi,
      required this.hakAkses,
      required this.userId})
      : super(key: key);

  @override
  State<BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  String dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final ValueNotifier<List<Notifikasi>> dataNotif =
      ValueNotifier<List<Notifikasi>>([]);

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dataNotif.value = widget.dataNotifikasi;
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void searchTodo(String query) {
    final temp1 = dataNotif.value
        .where((data) =>
            ('MBC-${data.sapi!.generasi}.${data.sapi!.anakKe}-${data.sapi!.eartagInduk}-${data.sapi!.eartag}'
                .toLowerCase()
                .contains(query.toLowerCase())))
        .toList();
    final temp2 = dataNotif.value
        .where((data) => data.pesan.toLowerCase().contains(query.toLowerCase()))
        .toList();
    dataNotif.value = (temp1 + temp2).toSet().toList();
    setState(() {});
  }

  void gotoAnotherPage(Widget landingPage, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return landingPage;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final size = MediaQuery.of(context).size;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(16)),
            child: TextField(
              autofocus: false,
              controller: searchController,
              onChanged: (c) {
                if (c.isEmpty) {
                  dataNotif.value = widget.dataNotifikasi;
                } else {
                  searchTodo(c);
                }
                setState(() {});
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                icon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Cari Notifikasi',
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ValueListenableBuilder(
                  valueListenable: dataNotif,
                  builder: (context, List<Notifikasi> datas, _) {
                    return Column(
                      children: [
                        SizedBox(height: getProportionateScreenHeight(8)),
                        Container(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: datas.length,
                                itemBuilder: (context, index) {
                                  var data = datas[index];
                                  return GestureDetector(
                                    onTap: () {
                                      if (data.status == "no" &&
                                          widget.hakAkses == "3") {
                                        var date1 = DateTime.parse(data.tanggal)
                                            .millisecondsSinceEpoch
                                            .toInt();
                                        var date2 = DateTime.parse(dateNow)
                                            .millisecondsSinceEpoch
                                            .toInt();

                                        if (date1 <= date2) {
                                          if (data.role == "4") {
                                            gotoAnotherPage(
                                                PerlakuanFormScreen(
                                                    userId: widget.userId,
                                                    notifikasiId:
                                                        data.id.toString(),
                                                    sapi: data.sapi,
                                                    hakAkses: widget.hakAkses),
                                                context);
                                          } else if (data.role == "2") {
                                            gotoAnotherPage(
                                                PerformaFormScreen(
                                                    null,
                                                    widget.userId,
                                                    null,
                                                    data.sapi,
                                                    widget.hakAkses),
                                                context);
                                          } else if (data.role == "0") {
                                            gotoAnotherPage(
                                                FormBirahiScreen(
                                                    notif: data,
                                                    userId: widget.userId,
                                                    hakAkses: widget.hakAkses),
                                                context);
                                          } else if (data.role == "1") {
                                            gotoAnotherPage(
                                                PeriksaKebuntinganFormScreen(
                                                    null,
                                                    widget.userId,
                                                    data.sapi,
                                                    data.id.toString(),
                                                    widget.hakAkses),
                                                context);
                                          } else if (data.role == "3") {
                                            gotoAnotherPage(
                                                InsiminasiBuatanFormScreen(
                                                    null,
                                                    widget.userId,
                                                    data.id.toString(),
                                                    data.sapi,
                                                    widget.hakAkses),
                                                context);
                                          } else if (data.role == "5") {
                                            gotoAnotherPage(
                                                PanenFormScreen(
                                                    null,
                                                    widget.userId,
                                                    data.sapi,
                                                    data.id.toString(),
                                                    widget.hakAkses),
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
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      width: size.width,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                child: Icon(
                                                    FontAwesomeIcons.circle,
                                                    color: kPrimaryColor),
                                              ),
                                              Container(
                                                width: 3,
                                                height: 100,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                              child: Container(
                                            // height: getProportionateScreenHeight(130),
                                            margin: EdgeInsets.only(left: 5),
                                            padding: EdgeInsets.only(left: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    'MBC-${data.sapi!.generasi}.${data.sapi!.anakKe}-${data.sapi!.eartagInduk}-${data.sapi!.eartag}',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(
                                                    height:
                                                        getProportionateScreenHeight(
                                                            16)),
                                                Text(data.tanggal,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(data.pesan,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 8),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 26,
                                                      vertical: 8),
                                                  decoration: BoxDecoration(
                                                      color: data.status != 'no'
                                                          ? kSecondaryColor
                                                          : Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: Text(
                                                      data.status == 'no'
                                                          ? "Belum"
                                                          : "Sudah",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              ],
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(80)),
                      ],
                    );
                  }),
            ),
          ),
        ],
      );
    });
  }
}
