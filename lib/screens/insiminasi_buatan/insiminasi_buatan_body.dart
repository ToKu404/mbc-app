import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbc_mobile/bloc/insiminasi_buatan_bloc/insiminasi_buatan_bloc.dart';
import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/insiminasi_buatan_model.dart';
import 'package:mbc_mobile/screens/insiminasi_buatan/insiminasi_buatan_form_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class InsiminasiBuatanBody extends StatefulWidget {
  final String userId;
  final String hakAkses;

  const InsiminasiBuatanBody(
      {Key? key, required this.userId, required this.hakAkses})
      : super(key: key);

  @override
  _InsiminasiBuatanBodyState createState() => _InsiminasiBuatanBodyState();
}

class _InsiminasiBuatanBodyState extends State<InsiminasiBuatanBody> {
  late InsiminasiBuatanBloc insiminasiBuatanBloc;

  @override
  void initState() {
    super.initState();

    insiminasiBuatanBloc = BlocProvider.of<InsiminasiBuatanBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    insiminasiBuatanBloc
        .add(InsiminasiBuatanFetchDataEvent(userId: widget.userId));

    print("InsiminasiBuatanBody");
    return Stack(
      children: [
        BlocListener<InsiminasiBuatanBloc, InsiminasiBuatanState>(
          listener: (context, state) {
            if (state is InsiminasiBuatanErrorState) {
              EasyLoading.showError(state.msg);
              EasyLoading.dismiss();
            } else if (state is InsiminasiBuatanSuccessState) {
              EasyLoading.showSuccess(state.msg);
              EasyLoading.dismiss();
            }
          },
          child: BlocBuilder<InsiminasiBuatanBloc, InsiminasiBuatanState>(
              builder: (context, state) {
            EasyLoading.dismiss();

            if (state is InsiminasiBuatanInitialState ||
                state is InsiminasiBuatanLoadingState) {
              return _buildLoading();
            } else if (state is InsiminasiBuatanLoadedState) {
              return body(state.datas);
            } else if (state is InsiminasiBuatanErrorState) {
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
                        builder: (context) => InsiminasiBuatanFormScreen(
                            null,
                            widget.userId,
                            "",
                            null,
                            widget.hakAkses))).then((value) => setState(() {}));
              },
              backgroundColor: kSecondaryColor,
              child: Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }

  Widget body(List<InsiminasiBuatan> list) {
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
                    _launchURL(Api().exportURL + "/3/" + data.id.toString());
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
                              Text(data.waktuIb,
                                  style: TextStyle(
                                      fontSize: 14, color: kHintTextColor)),
                            ],
                          ),
                          Text(
                            "KODE BATCH ${data.strow!.kodeBatch}",
                            style:
                                TextStyle(fontSize: 14, color: kHintTextColor),
                          ),
                          SizedBox(height: getProportionateScreenHeight(8)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("IB ke - ", style: titleDarkStyle),
                              Text("${data.dosisIb}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Divider(),
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

  void alertConfirm(InsiminasiBuatan insiminasiBuatan) async {
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
      insiminasiBuatanBloc
          .add(InsiminasiBuatanDeleteEvent(insiminasiBuatan: insiminasiBuatan));
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
