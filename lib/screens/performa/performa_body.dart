import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbc_mobile/bloc/performa_bloc/performa_bloc.dart';
import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/performa_model.dart';
import 'package:mbc_mobile/screens/performa/performa_form_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class PerformaBody extends StatefulWidget {
  final String userId;
  final String hakAkses;

  const PerformaBody({Key? key, required this.userId, required this.hakAkses})
      : super(key: key);

  @override
  _PerformaBodyState createState() => _PerformaBodyState();
}

class _PerformaBodyState extends State<PerformaBody> {
  late PerformaBloc performaBloc;

  @override
  void initState() {
    super.initState();

    performaBloc = BlocProvider.of<PerformaBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    performaBloc.add(PerformaFetchDataEvent(id: widget.userId));

    return Stack(
      children: [
        BlocListener<PerformaBloc, PerformaState>(
          listener: (context, state) {
            print(state);
            if (state is PerformaErrorState) {
              EasyLoading.showError(state.msg);
              EasyLoading.dismiss();
            } else if (state is PerformaSuccessState) {
              EasyLoading.showSuccess(state.msg);
              EasyLoading.dismiss();
            }
          },
          child: BlocBuilder<PerformaBloc, PerformaState>(
              builder: (context, state) {
            EasyLoading.dismiss();

            if (state is PerformaInitialState ||
                state is PerformaLoadingState) {
              return _buildLoading();
            } else if (state is PerformaLoadedState) {
              return body(state.datas);
            } else if (state is PerformaErrorState) {
              return Center(
                  child: Text(state.msg, style: TextStyle(color: Colors.red)));
            } else {
              return Container(child: Center(child: Text(state.toString())));
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
                              builder: (context) => PerformaFormScreen(null,
                                  widget.userId, null, null, widget.hakAkses)))
                      .then((value) => setState(() {}));
                },
                backgroundColor: kSecondaryColor,
                child: Icon(Icons.add),
              )),
        ),
      ],
    );
  }

  Widget body(List<Performa> list) {
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
                    _launchURL(Api().exportURL + "/2/" + data.id.toString());
                  },
                ),
              ],
              child: Container(
                height: 350,
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 200,
                      right: 0,
                      left: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  Api.imageURL + '/' + list[index].foto)),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Padding(
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
                                Text(data.tanggalPerforma,
                                    style: TextStyle(
                                        fontSize: 14, color: kHintTextColor)),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(8)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Tinggi Badan",
                                    style: TextStyle(fontSize: 14)),
                                Text("${data.tinggiBadan} cm",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red)),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Berat Badan",
                                    style: TextStyle(fontSize: 14)),
                                Text("${data.beratBadan} kg",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red)),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Panjang Badan",
                                    style: TextStyle(fontSize: 14)),
                                Text("${data.panjangBadan} cm",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red)),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Lingkar Dada",
                                    style: TextStyle(fontSize: 14)),
                                Text("${data.lingkarDada} cm",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red)),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("BCS", style: TextStyle(fontSize: 14)),
                                Text("${data.bsc}",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void alertConfirm(Performa performa) async {
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
      performaBloc.add(PerformaDeleteEvent(performa: performa));
      return;
    }
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
