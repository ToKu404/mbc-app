import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbc_mobile/bloc/periksa_kebuntingan_bloc/periksa_kebuntingan_bloc.dart';
import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/periksa_kebuntingan_model.dart';
import 'package:mbc_mobile/screens/periksa_kebuntingan/form/periksa_kebuntingan_form_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class PeriksaKebuntinganBody extends StatefulWidget {
  final String id;
  final String hakAkses;

  const PeriksaKebuntinganBody(
      {Key? key, required this.id, required this.hakAkses})
      : super(key: key);
  @override
  _PeriksaKebuntinganBodyState createState() => _PeriksaKebuntinganBodyState();
}

class _PeriksaKebuntinganBodyState extends State<PeriksaKebuntinganBody> {
  late PeriksaKebuntinganBloc periksaKebuntinganBloc;

  @override
  void initState() {
    super.initState();

    periksaKebuntinganBloc = BlocProvider.of<PeriksaKebuntinganBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    periksaKebuntinganBloc.add(PeriksaKebuntinganFetchDataEvent(widget.id));

    return Stack(
      children: [
        BlocBuilder<PeriksaKebuntinganBloc, PeriksaKebuntinganState>(
            builder: (context, state) {
          EasyLoading.dismiss();

          print(state);

          if (state is PeriksaKebuntinganInitialState ||
              state is PeriksaKebuntinganLoadingState) {
            return _buildLoading();
          } else if (state is PeriksaKebuntinganLoadedState) {
            return newBody(state.datas);
          } else if (state is PeriksaKebuntinganErrorState) {
            return Center(child: Text(state.msg));
          } else {
            return Center(child: Text(state.toString()));
          }
        }),
        Visibility(
          visible: widget.hakAkses == "3" ? true : false,
          child: Positioned(
              right: 0,
              bottom: 0,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PeriksaKebuntinganFormScreen(
                              null,
                              widget.id,
                              null,
                              "0",
                              widget
                                  .hakAkses))).then((value) => setState(() {}));
                },
                backgroundColor: kSecondaryColor,
                child: Icon(Icons.add),
              )),
        ),
      ],
    );
  }

  Widget newBody(List<PeriksaKebuntingan> list) {
    if (list.length == 0) {
      return Center(
        child: Text("Data not yet"),
      );
    }

    return Stack(
      children: [
        Container(
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                var data = list[index];
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actions: [
                    IconSlideAction(
                      caption: 'Print',
                      icon: FontAwesomeIcons.fileExport,
                      foregroundColor: Colors.blueAccent,
                      color: Colors.transparent,
                      onTap: () {
                        _launchURL(
                            Api().exportURL + "/1/" + data.id.toString());
                      },
                    ),
                  ],
                  // secondaryActions: [
                  //   IconSlideAction(
                  //     caption: 'Delete',
                  //     icon: FontAwesomeIcons.trash,
                  //     foregroundColor: Colors.red,
                  //     color: Colors.transparent,
                  //     onTap: () {
                  //       alertConfirm(data);
                  //     },
                  //   ),
                  // ],
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>
                      //                 PeriksaKebuntinganFormScreen(
                      //                     periksaKebuntingan: data)))
                      //     .then((value) => setState(() {}));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Container(
                              height: 150,
                              width: double.infinity,
                              child: FadeInImage(
                                image: NetworkImage(list[index].foto == "images"
                                    ? "hahaha"
                                    : Api.imageURL + '/' + list[index].foto),
                                placeholder: AssetImage(Images.plaeholderImage),
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(Images.plaeholderImage,
                                      fit: BoxFit.fill);
                                },
                                fit: BoxFit.fill,
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'MBC-${data.sapi!.generasi}.${data.sapi!.anakKe}-${data.sapi!.eartagInduk}-${data.sapi!.eartag}',
                                      style: TextStyle(
                                          fontSize: 18, color: kSecondaryColor),
                                    ),
                                    Text(data.waktuPk,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: kHintTextColor)),
                                  ],
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(8)),
                                RichText(
                                  text: TextSpan(
                                    text: 'Dengan Menggunakan Metode ',
                                    style: TextStyle(
                                        fontSize: 12, color: kTextColor),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: data.metode!.metode,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(text: ' Mendapatkan Hasil '),
                                      TextSpan(
                                          text: data.hasil!.hasil,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  void alertConfirm(PeriksaKebuntingan periksaKebuntingan) async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
            denyButtonText: "Cancel",
            title: "Are you sure?",
            text: "You won't be able to revert this!",
            confirmButtonText: "Yes, delete it",
            type: ArtSweetAlertType.warning));

    // ignore: unnecessary_null_comparison
    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      periksaKebuntinganBloc.add(PeriksaKebuntinganDeleteEvent(
          periksaKebuntingan: periksaKebuntingan, userId: widget.id));
      return;
    }
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
