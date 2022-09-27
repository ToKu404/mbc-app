import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mbc_mobile/bloc/sapi_bloc/sapi_bloc.dart';
import 'package:mbc_mobile/bloc/strow_bloc/strow_bloc.dart';
import 'package:mbc_mobile/components/default_button.dart';
import 'package:mbc_mobile/helper/keyboard.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:mbc_mobile/models/strow_model.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:mbc_mobile/utils/theme.dart';

class StrowFormBody extends StatefulWidget {
  final Strow strow;
  final String userId;

  const StrowFormBody({Key? key, required this.strow, required this.userId})
      : super(key: key);

  @override
  _StrowFormBodyState createState() => _StrowFormBodyState();
}

class _StrowFormBodyState extends State<StrowFormBody> {
  final _formKey = GlobalKey<FormState>();

  late SapiBloc sapiBloc;
  late StrowBloc strowBloc;

  List<Sapi> listSapi = [];
  int sapiDropdownValue = 0;

  int resSapiId = 0;
  int resId = 0;

  final _resKode = new TextEditingController();
  final _resBatch = new TextEditingController();

  @override
  void initState() {
    super.initState();

    sapiBloc = BlocProvider.of<SapiBloc>(context);
    strowBloc = BlocProvider.of<StrowBloc>(context);

    sapiBloc.add(SapiFetchDataEvent(widget.userId));

    if (widget.strow.id != 0) {
      resId = widget.strow.id;

      resSapiId = widget.strow.sapiId;
      sapiDropdownValue = resSapiId;

      _resKode.text = widget.strow.kodeBatch.toString();
      _resBatch.text = widget.strow.batch.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StrowBloc, StrowState>(
      listener: (context, state) {
        print(state);
        if (state is StrowInitialState || state is StrowLoadingState) {
          EasyLoading.show(status: 'loading');
        } else if (state is StrowErrorState) {
          EasyLoading.showError(state.msg);
          EasyLoading.dismiss();
        } else if (state is StrowSuccessState) {
          EasyLoading.showSuccess(state.msg);
          EasyLoading.dismiss();
          Navigator.pop(context, true);
        }
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Pilih Sapi"),
                loadSapi(),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text("Kode Batch "),
                buildFormField('Input Kode Batch', _resKode),
                SizedBox(width: getProportionateScreenWidth(16)),
                Text("Batch "),
                buildFormField('Input Batch', _resBatch),
                SizedBox(width: getProportionateScreenWidth(16)),
                SizedBox(height: getProportionateScreenHeight(32)),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      KeyboardUtil.hideKeyboard(context);
                      if (resSapiId != 0) {
                        Strow strow = Strow(
                            id: resId,
                            sapiId: resSapiId,
                            kodeBatch: _resKode.text.trim(),
                            batch: _resBatch.text.trim());

                        resId == 0
                            ? strowBloc.add(StrowStoreEvent(strow: strow))
                            : strowBloc.add(StrowUpdateEvent(strow: strow));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Pilih sapi dulu')));
                      }
                    }
                  },
                  child: DefaultButton(
                    text: "Submit",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loadSapi() {
    return BlocBuilder<SapiBloc, SapiState>(builder: (context, state) {
      if (state is SapiInitialState || state is SapiLoadingState) {
        return buildLoading();
      } else if (state is SapiLoadedState) {
        listSapi = [];
        listSapi.add(Sapi(
          id: 0,
          jenisSapiId: 0,
          eartag: "ertag",
          eartagInduk: "ertagInduk",
          namaSapi: "Nama Sapi",
          tanggalLahir: "tglLahir",
          kelamin: "kelamin",
          kondisiLahir: "kondisiLahir",
          anakKe: "anakKe",
          generasi: "generasi",
          fotoDepan: "photoDepan",
          fotoSamping: "photoBelakang",
          fotoPeternak: "photoKanan",
          fotoRumah: "photoKiri",
          peternakId: 0,
        ));

        listSapi.addAll(state.datas);
        return buildSapi(listSapi);
      } else {
        return buildError(state.toString());
      }
    });
  }

  Container buildSapi(List<Sapi> list) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: kSecondaryColor, width: 1),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButton<int>(
        value: sapiDropdownValue,
        hint: Text("Pilih Sapi"),
        items: list.map((Sapi value) {
          return DropdownMenuItem<int>(
            value: value.id,
            child: new Text(value.namaSapi),
          );
        }).toList(),
        onChanged: (newValue) {
          print(newValue);

          setState(() {
            sapiDropdownValue = newValue!;
            resSapiId = newValue;
          });
        },
      ),
    );
  }

  TextFormField buildFormField(String hint, TextEditingController controller) {
    return TextFormField(
        keyboardType: TextInputType.number,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "gak boleh kosong bro";
          }
          return null;
        },
        decoration: inputForm(hint, hint));
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
