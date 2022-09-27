import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mbc_mobile/bloc/auth_bloc/authentication_bloc.dart';
import 'package:mbc_mobile/bloc/hasil_bloc/hasil_bloc.dart';
import 'package:mbc_mobile/bloc/metode_bloc/metode_bloc.dart';
import 'package:mbc_mobile/bloc/periksa_kebuntingan_bloc/periksa_kebuntingan_bloc.dart';
import 'package:mbc_mobile/bloc/sapi_bloc/sapi_bloc.dart';
import 'package:mbc_mobile/components/default_button.dart';
import 'package:mbc_mobile/helper/keyboard.dart';
import 'package:mbc_mobile/models/hasil_model.dart';
import 'package:mbc_mobile/models/metode_model.dart';
import 'package:mbc_mobile/models/periksa_kebuntingan_model.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:mbc_mobile/screens/new_home_page/home_page.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:mbc_mobile/utils/theme.dart';

import 'dart:io';

import 'package:toggle_switch/toggle_switch.dart';

class PeriksaKebuntinganFormBody extends StatefulWidget {
  final String userId;
  final String notifId;
  final Sapi? sapi;
  final String hakAkses;

  const PeriksaKebuntinganFormBody(
      Key? key, this.userId, this.sapi, this.notifId, this.hakAkses)
      : super(key: key);

  @override
  _PeriksaKebuntinganFormBodyState createState() =>
      _PeriksaKebuntinganFormBodyState();
}

class _PeriksaKebuntinganFormBodyState
    extends State<PeriksaKebuntinganFormBody> {
  final _formKey = GlobalKey<FormState>();

  late SapiBloc sapiBloc;
  late PeriksaKebuntinganBloc periksaKebuntinganBloc;
  late MetodeBloc metodeBloc;
  late HasilBloc hasilBloc;
  late AuthenticationBloc authenticationBloc;

  String resTgl = "";
  String resFoto = "";

  String resSapi = "Pilih Eartag Sapi";
  String resMetode = "Pilih Jenis Metode";
  String resHasil = "Pilih Hasil";

  int resSapiId = 0;
  int resMetodeId = 0;
  int resHasilId = 0;
  int resId = 0;

  late DateTime date;

  final _resMetode = new TextEditingController();
  final _resHasil = new TextEditingController();

  late File? _imageFile = null;
  final ImagePicker _picker = ImagePicker();
  late File? resFile;

  bool isResult = true;
  bool isReproduksi = true;

  @override
  void initState() {
    super.initState();

    metodeBloc = BlocProvider.of(context);
    hasilBloc = BlocProvider.of(context);
    sapiBloc = BlocProvider.of(context);
    periksaKebuntinganBloc = BlocProvider.of<PeriksaKebuntinganBloc>(context);
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    sapiBloc.add(SapiFetchDataEvent(widget.userId));
    metodeBloc.add(MetodeFetchDataEvent());
    hasilBloc.add(HasilFetchDataEvent());

    if (widget.sapi != null) {
      print(widget.sapi!.eartag);
      resSapi =
          'MBC-${widget.sapi!.generasi}.${widget.sapi!.anakKe}-${widget.sapi!.eartagInduk}-${widget.sapi!.eartag}';

      resSapiId = widget.sapi!.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PeriksaKebuntinganBloc, PeriksaKebuntinganState>(
      listener: (context, state) {
        print(state);
        if (state is PeriksaKebuntinganInitialState ||
            state is PeriksaKebuntinganLoadingState) {
          EasyLoading.show(status: 'loading');
        } else if (state is PeriksaKebuntinganErrorState) {
          EasyLoading.showError(state.msg);
          EasyLoading.dismiss();
        } else if (state is PeriksaKebuntinganSuccessState) {
          EasyLoading.showSuccess(state.msg);
          EasyLoading.dismiss();

          gotoHomePage(widget.userId);
        }

        reinitField();
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: ((builder) => _bottomSheet()));
                    },
                    child: Container(
                      height: 200,
                      width: SizeConfig.screenWidth,
                      decoration: BoxDecoration(
                        color: kHintTextColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: _imageFile == null
                            ? Image.asset(Images.plaeholderImage,
                                fit: BoxFit.cover)
                            : Image.file(File(_imageFile!.path)),
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(16)),
                  Divider(),
                  loadSapi(),
                  SizedBox(height: getProportionateScreenHeight(8)),
                  loadMetode(),
                  SizedBox(height: getProportionateScreenHeight(8)),
                  loadHasil(),
                  Divider(),
                  SizedBox(height: getProportionateScreenHeight(8)),
                  Text("Reproduksi Normal / Unnormal ? ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  switchTogleReproduksi(),
                  Visibility(
                      visible: resHasilId == 1 ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: getProportionateScreenHeight(8)),
                          Text("Status IB / Kawin Alam ? ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          switchTogle(),
                        ],
                      )),
                  SizedBox(height: getProportionateScreenHeight(16)),
                  SizedBox(height: getProportionateScreenHeight(16)),
                  GestureDetector(
                    onTap: () {
                      KeyboardUtil.hideKeyboard(context);

                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (resFile != null) {
                          if (resSapiId != 0) {
                            if (resMetodeId != 0) {
                              if (resHasilId != 0) {
                                var data = PeriksaKebuntingan(
                                    id: resId,
                                    sapiId: resSapiId,
                                    peternakId: 0,
                                    pendampingId: 0,
                                    tsrId: 0,
                                    waktuPk: "",
                                    status: isResult ? 1 : 0,
                                    reproduksi: isReproduksi ? 1 : 0,
                                    metodeId: resMetodeId,
                                    hasilId: resHasilId,
                                    foto: resFoto);

                                alertConfirm(data);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Harap Memilih Hasil')),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Harap Memilih Metode')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Harap Memilih Sapi')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Pilih Foto Dokumentasi Kegiatan')),
                          );
                        }
                      }
                    },
                    child: DefaultButton(
                      text: "Submit",
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  ToggleSwitch switchTogle() {
    return ToggleSwitch(
      minWidth: SizeConfig.screenWidth,
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
      labels: const ['IB', 'Kawin Alam'],
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

  ToggleSwitch switchTogleReproduksi() {
    return ToggleSwitch(
      minWidth: SizeConfig.screenWidth,
      minHeight: 50,
      cornerRadius: 8.0,
      activeBgColors: [
        [Colors.green[800]!],
        [Colors.red[800]!]
      ],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.white,
      initialLabelIndex: isReproduksi ? 0 : 1,
      totalSwitches: 2,
      labels: const ['Normal', 'Unnormal'],
      radiusStyle: true,
      onToggle: (index) {
        print('switched to: $index');
        setState(() {
          if (index == 0) {
            isReproduksi = true;
          } else {
            isReproduksi = false;
          }
        });
      },
    );
  }

  Widget loadMetode() {
    return BlocBuilder<MetodeBloc, MetodeState>(builder: (context, state) {
      print(state);
      if (state is MetodeInitialState || state is MetodeLoadingState) {
        return buildLoading();
      } else if (state is MetodeLoadedState) {
        return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<bool>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("Pilih Jenis Metode"),
                    ),
                    body: WillPopScope(
                      onWillPop: () async {
                        Navigator.pop(context, false);
                        return false;
                      },
                      child: listMetodeNew(state.metodeModel.metode),
                    ),
                  );
                },
              ));
            },
            child: metodeField());
      } else {
        return buildError(state.toString());
      }
    });
  }

  Container listMetodeNew(List<Metode> list) {
    return Container(
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            var data = list[index];
            return Container(
              decoration: BoxDecoration(),
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    resMetodeId = data.id;
                    resMetode = data.metode;
                  });
                  Navigator.pop(context, false);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.metode,
                        style: TextStyle(fontSize: 18),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Container metodeField() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: kHintTextColor, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          const Icon(
            FontAwesomeIcons.list,
            color: kHintTextColor,
            size: 16,
          ),
          const SizedBox(width: 16),
          Expanded(
              child: Text(
            '$resMetode',
            style: const TextStyle(fontSize: 16),
          )),
          const Icon(
            Icons.arrow_forward_ios,
            color: kHintTextColor,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget loadHasil() {
    return BlocBuilder<HasilBloc, HasilState>(builder: (context, state) {
      print(state);
      if (state is HasilInitialState || state is HasilLoadingState) {
        return buildLoading();
      } else if (state is HasilLoadedState) {
        return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<bool>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("Pilih Jenis Metode"),
                    ),
                    body: WillPopScope(
                      onWillPop: () async {
                        Navigator.pop(context, false);
                        return false;
                      },
                      child: listHasilNew(state.hasilModel.hasil),
                    ),
                  );
                },
              ));
            },
            child: hasilField());
      } else {
        return buildError(state.toString());
      }
    });
  }

  Container listHasilNew(List<Hasil> list) {
    return Container(
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            var data = list[index];
            return Container(
              decoration: BoxDecoration(),
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    resHasilId = data.id;
                    resHasil = data.hasil;
                  });
                  Navigator.pop(context, false);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.hasil,
                        style: TextStyle(fontSize: 18),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Container hasilField() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: kHintTextColor, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          const Icon(
            FontAwesomeIcons.list,
            color: kHintTextColor,
            size: 16,
          ),
          const SizedBox(width: 16),
          Expanded(
              child: Text(
            '$resHasil',
            style: const TextStyle(fontSize: 16),
          )),
          const Icon(
            Icons.arrow_forward_ios,
            color: kHintTextColor,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget loadSapi() {
    return BlocBuilder<SapiBloc, SapiState>(builder: (context, state) {
      if (state is SapiInitialState || state is SapiLoadingState) {
        return buildLoading();
      } else if (state is SapiLoadedState) {
        return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<bool>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("Pilih Eartag Sapi"),
                    ),
                    body: WillPopScope(
                      onWillPop: () async {
                        Navigator.pop(context, false);
                        return false;
                      },
                      child: listSapiNew(state.datas),
                    ),
                  );
                },
              ));
            },
            child: sapiField());
      } else {
        return buildError(state.toString());
      }
    });
  }

  Container listSapiNew(List<Sapi> list) {
    return Container(
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            var data = list[index];
            return Container(
              decoration: BoxDecoration(),
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    resSapiId = data.id;
                    resSapi =
                        'MBC-${data.generasi}.${data.anakKe}-${data.eartagInduk}-${data.eartag}';
                  });
                  Navigator.pop(context, false);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MBC-${data.generasi}.${data.anakKe}-${data.eartagInduk}-${data.eartag}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Container sapiField() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: kHintTextColor, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          const Icon(
            FontAwesomeIcons.list,
            color: kHintTextColor,
            size: 16,
          ),
          const SizedBox(width: 16),
          Expanded(
              child: Text(
            '$resSapi',
            style: const TextStyle(fontSize: 16),
          )),
          const Icon(
            Icons.arrow_forward_ios,
            color: kHintTextColor,
            size: 16,
          ),
        ],
      ),
    );
  }

  TextFormField buildFormFieldMetode(String hint) {
    return TextFormField(
        controller: _resMetode,
        onSaved: (newValue) => resMetode = newValue!,
        validator: (value) {
          if (value!.isEmpty) {
            return "gak boleh kosong bro";
          }
          return null;
        },
        decoration: inputForm(hint, hint));
  }

  TextFormField buildFormFieldHasil(String hint) {
    return TextFormField(
        controller: _resHasil,
        onSaved: (newValue) => resHasil = newValue!,
        validator: (value) {
          if (value!.isEmpty) {
            return "gak boleh kosong bro";
          }
          return null;
        },
        decoration: inputForm(hint, hint));
  }

  Widget _bottomSheet() {
    return Container(
      height: 100,
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          Text("Choose Profile Photo"),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    _takePhotos(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text("Camera")),
              ElevatedButton.icon(
                  onPressed: () {
                    _takePhotos(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text("Galery")),
            ],
          ),
        ],
      ),
    );
  }

  void _takePhotos(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      CroppedFile? cropFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(ratioX: 2, ratioY: 1),
          compressQuality: 70,
          compressFormat: ImageCompressFormat.jpg);
      File? cropped = File(cropFile!.path);

      setState(() {
        _imageFile = cropped!;
        resFile = _imageFile!;
      });
    }
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

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (newDate == null) return;

    setState(() {
      date = newDate;
      resTgl = DateFormat('yyyy/MM/dd').format(date);
      print(date);
    });
  }

  void reinitField() {
    setState(() {
      resId = 0;
      resSapiId = 0;
      resMetodeId = 0;
      resHasilId = 0;
      resHasil = "";
      resMetode = "";
      resTgl = "";
      _resMetode.text = "";
      _resHasil.text = "";
    });
  }

  void alertConfirm(PeriksaKebuntingan data) async {
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
      periksaKebuntinganBloc.add(PeriksaKebuntinganStoreEvent(
          file: _imageFile == null ? null : _imageFile!,
          periksaKebuntingan: data,
          notifId: widget.notifId));
      return;
    }
  }

  void gotoHomePage(String userId) {
    AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => HomePage(
                userId: userId,
                bloc: authenticationBloc,
                hakAkses: widget.hakAkses)),
        (Route<dynamic> route) => false);
  }
}
