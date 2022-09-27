import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbc_mobile/bloc/perlakuan_bloc/perlakuan_bloc.dart';
import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/perlakuan_model.dart';
import 'package:mbc_mobile/screens/perlakuan/perlakuan_form_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class PerlakuanBody extends StatefulWidget {
  final String userId;
  final String hakAkses;

  const PerlakuanBody({Key? key, required this.userId, required this.hakAkses})
      : super(key: key);
  @override
  _PerlakuanBodyState createState() => _PerlakuanBodyState();
}

class _PerlakuanBodyState extends State<PerlakuanBody> {
  late PerlakuanBloc perlakuanBloc;

  @override
  void initState() {
    super.initState();

    perlakuanBloc = BlocProvider.of<PerlakuanBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    perlakuanBloc.add(PerlakuanFetchDataEvent(widget.userId));

    return Stack(
      children: [
        BlocListener<PerlakuanBloc, PerlakuanState>(
          listener: (context, state) {
            if (state is PerlakuanErrorState) {
              EasyLoading.showError(state.msg);
              EasyLoading.dismiss();
            } else if (state is PerlakuanSuccessState) {
              EasyLoading.showSuccess(state.msg);
              EasyLoading.dismiss();
            }
          },
          child: BlocBuilder<PerlakuanBloc, PerlakuanState>(
              builder: (context, state) {
            EasyLoading.dismiss();

            if (state is PerlakuanInitialState ||
                state is PerlakuanLoadingState) {
              return _buildLoading();
            } else if (state is PerlakuanLoadedState) {
              return body(state.datas);
            } else if (state is PerlakuanErrorState) {
              return buildError(state.msg);
            } else {
              return _buildLoading();
            }
          }),
        ),
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
                        builder: (context) => PerlakuanFormScreen(
                              userId: widget.userId,
                              notifikasiId: "0",
                              hakAkses: '',
                            ))).then((value) => setState(() {}));
              },
              backgroundColor: kSecondaryColor,
              child: Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }

  Widget body(List<Perlakuan> list) {
    if (list.length == 0) {
      return Center(
        child: Text("Data not yet"),
      );
    }
    return Container(
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
                    _launchURL(Api().exportURL + "/4/" + data.id.toString());
                  },
                ),
              ],
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                Api.imageURL + '/' + list[index].foto)),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'MBC-${data.sapi!.generasi}.${data.sapi!.anakKe}-${data.sapi!.eartagInduk}-${data.sapi!.eartag}',
                                style: TextStyle(
                                    fontSize: 18, color: kSecondaryColor),
                              ),
                              Text(data.tglPerlakuan,
                                  style: TextStyle(
                                      fontSize: 14, color: kHintTextColor)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${data.obat!.name}",
                                  style: TextStyle(fontSize: 14)),
                              Text("${data.dosisObat}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${data.vitamin!.name}",
                                  style: TextStyle(fontSize: 14)),
                              Text("${data.dosisVitamin}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${data.vaksin!.name}",
                                  style: TextStyle(fontSize: 14)),
                              Text("${data.dosisVaksin}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${data.hormon!.name}",
                                  style: TextStyle(fontSize: 14)),
                              Text("${data.dosisHormon}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red)),
                            ],
                          ),
                          Divider(),
                          Text("Keterangan Perlakuan",
                              style: TextStyle(fontSize: 14)),
                          Text(data.ketPerlakuan,
                              style: TextStyle(
                                  fontSize: 14, color: kHintTextColor)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void alertConfirm(Perlakuan perlakuan) async {
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
      perlakuanBloc.add(PerlakuanDeleteEvent(perlakuan: perlakuan));
      return;
    }
  }

  Widget _buildLoading() {
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

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
