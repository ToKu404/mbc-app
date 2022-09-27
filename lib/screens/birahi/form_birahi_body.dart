import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:mbc_mobile/bloc/auth_bloc/authentication_bloc.dart';
import 'package:mbc_mobile/bloc/birahi_bloc/birahi_bloc.dart';
import 'package:mbc_mobile/components/default_button.dart';
import 'package:mbc_mobile/models/notifikasi_model.dart';
import 'package:mbc_mobile/screens/new_home_page/home_page.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:toggle_switch/toggle_switch.dart';

class FormBirahiBody extends StatefulWidget {
  final Notifikasi notif;
  final String userId;
  final String hakAkses;

  const FormBirahiBody(
      {Key? key,
      required this.notif,
      required this.userId,
      required this.hakAkses})
      : super(key: key);

  @override
  _FormBirahiBodyState createState() => _FormBirahiBodyState();
}

class _FormBirahiBodyState extends State<FormBirahiBody> {
  bool isResult = true;
  late BirahiBloc birahiBloc;
  late AuthenticationBloc authenticationBloc;

  String resTgl = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    birahiBloc = BlocProvider.of(context);
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: BlocListener<BirahiBloc, BirahiState>(
        listener: (context, state) {
          print(state);
          if (state is BirahiInitial || state is BirahiLoadingState) {
            EasyLoading.show(status: 'loading');
          } else if (state is BirahiSuccessState) {
            EasyLoading.showSuccess(state.msg);
            EasyLoading.dismiss();

            gotoAnotherPage(HomePage(
              userId: widget.userId.toString(),
              bloc: authenticationBloc,
              hakAkses: widget.hakAkses,
            ));
            // Navigator.pop(context);
          } else if (state is BirahiErrorState) {
            EasyLoading.dismiss();
            EasyLoading.showError(state.msg);
          }
        },
        child: Column(
          children: [
            Text("Keterangan Cek Birahi",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: getProportionateScreenHeight(16)),
            Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    pickDate(context);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: kHintTextColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.date_range),
                        SizedBox(width: 8),
                        Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Tanggal Birahi"),
                            Text(resTgl,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              switchTogle(),
            ]),
            SizedBox(height: getProportionateScreenHeight(16)),
            GestureDetector(
                onTap: () {
                  alertConfirm();
                },
                child: DefaultButton(text: "Submit")),
          ],
        ),
      ),
    );
  }

  ToggleSwitch switchTogle() {
    return ToggleSwitch(
      minHeight: 50,
      cornerRadius: 8.0,
      activeBgColors: [
        [Colors.green[800]!],
        [Colors.red[800]!]
      ],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.white,
      initialLabelIndex: isResult ? 0 : 1,
      totalSwitches: 2,
      labels: const ['YA', 'TIDAK'],
      radiusStyle: true,
      onToggle: (index) {
        print('switched to: $index');
        setState(() {
          if (index == 0) {
            isResult = true;
          } else {
            isResult = false;
          }
        });
      },
    );
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (newDate == null) return;

    setState(() {
      resTgl = DateFormat('yyyy-MM-dd').format(newDate);
      print(newDate);
    });
  }

  void alertConfirm() async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
            denyButtonText: "Cancel",
            title: "Are you sure?",
            text: "You won't be able to revert this!",
            confirmButtonText: "Yes, Submit",
            type: ArtSweetAlertType.warning));

    // ignore: unnecessary_null_comparison
    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      var result = isResult ? 'yes' : 'no';
      birahiBloc
          .add(BirahiStoreEvent(result, widget.notif.id.toString(), resTgl));
      return;
    }
  }

  void gotoAnotherPage(Widget widget) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}
