import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mbc_mobile/bloc/sapi_bloc/sapi_bloc.dart';
import 'package:mbc_mobile/bloc/sapi_master/sapi_master_bloc.dart';
import 'package:mbc_mobile/components/default_button.dart';
import 'package:mbc_mobile/helper/keyboard.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:mbc_mobile/repositories/sapi_master_repo.dart';
import 'package:mbc_mobile/repositories/sapi_repo.dart';
import 'package:mbc_mobile/screens/performa/performa_form_screen.dart';
import 'package:mbc_mobile/screens/sapi/data_result_sapi.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SapiFormScreen extends StatelessWidget {
  final Sapi sapi;
  final String userId;
  final String hakAkses;

  const SapiFormScreen(
      {Key? key,
      required this.sapi,
      required this.userId,
      required this.hakAkses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Form Input Sapi", style: TextStyle(color: Colors.white)),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[kSecondaryColor, kPrimaryColor])),
          ),
        ),
        body: BlocProvider(
          create: (context) => SapiBloc(SapiRepositoryImpl()),
          child: BlocProvider(
            create: (context) => SapiMasterBloc(SapiMasterRepositoryImpl()),
            child: SapiFormBody(sapi: sapi, userId: userId, hakAkses: hakAkses),
          ),
        ));
  }
}

class SapiFormBody extends StatefulWidget {
  final Sapi sapi;
  final String userId;
  final String hakAkses;

  const SapiFormBody(
      {Key? key,
      required this.sapi,
      required this.userId,
      required this.hakAkses})
      : super(key: key);

  @override
  _SapiFormBodyState createState() => _SapiFormBodyState();
}

class _SapiFormBodyState extends State<SapiFormBody> {
  final _formKey = GlobalKey<FormState>();

  late File? resFileFotoDepan = null;
  late File? resFileFotoSamping = null;
  late File? resFileFotoPeternak = null;
  late File? resFileFotoRUmah = null;
  final ImagePicker _picker = ImagePicker();

  String resJenisSapi = "Pilih Jenis Sapi";
  String resStatusSapi = "Pilih Status Sapi";
  String resKondisiLahir = "Pilih Kondisi Lahir";
  int resJenisSapiId = 0;
  int resStatusSapiId = 0;

  int statusFile = 1;
  bool isJantan = true;

  late SapiMasterBloc sapiMasterBloc;
  late SapiBloc sapiBloc;

  final _namaSapi = TextEditingController();

  String? validateField(value) {
    if (value.isEmpty) {
      return kFieldNullError;
    } else {
      return null;
    }
  }

  @override
  void initState() {
    sapiMasterBloc = BlocProvider.of(context);
    sapiBloc = BlocProvider.of(context);
    sapiMasterBloc.add(SapiMasterFetchDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("status file $statusFile");
    return BlocListener<SapiBloc, SapiState>(
      listener: (context, state) {
        if (state is SapiInitialState || state is SapiLoadingState) {
          EasyLoading.show(status: 'loading');
        } else if (state is SapiErrorState) {
          EasyLoading.showError(state.msg);
          EasyLoading.dismiss();
        } else if (state is SapiSuccessState) {
          EasyLoading.showSuccess(state.msg);
          EasyLoading.dismiss();
          Navigator.pop(context, true);
        }
      },
      child: Container(
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(18),
                        bottomLeft: Radius.circular(18),
                      ),
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: validateField,
                          controller: _namaSapi,
                          cursorColor: kSecondaryColor,
                          decoration: buildInputDecoration(
                              "assets/icons/receipt.svg", "Nama Sapi"),
                        ),
                        SizedBox(height: getProportionateScreenHeight(16)),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute<bool>(
                                builder: (BuildContext context) {
                                  return Scaffold(
                                    appBar: AppBar(
                                      title: Text("Status Sapi"),
                                    ),
                                    body: WillPopScope(
                                      onWillPop: () async {
                                        Navigator.pop(context, false);
                                        return false;
                                      },
                                      child: listKondisLahir(),
                                    ),
                                  );
                                },
                              ));
                            },
                            child: kondisiLahirField()),
                        SizedBox(height: getProportionateScreenHeight(16)),
                        switchTogle(),
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(16)),
                  Divider(),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Keterangan Sapi",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        listKeteranganSapi(),
                        SizedBox(height: getProportionateScreenHeight(16)),
                        Divider(),
                        Text("Foto Dokumentasi",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        listDokumentasi(context),
                        SizedBox(height: getProportionateScreenHeight(18)),
                        GestureDetector(
                          onTap: () {
                            KeyboardUtil.hideKeyboard(context);

                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              // if all are valid then go to success screen

                              if (resFileFotoDepan != null) {
                                if (resFileFotoSamping != null) {
                                  if (resFileFotoPeternak != null) {
                                    if (resFileFotoRUmah != null) {
                                      var namaSapi = _namaSapi.text.trim();

                                      var eartagInduk = widget.sapi.eartag;
                                      Sapi resultSapi = Sapi(
                                          id: widget.sapi.id,
                                          jenisSapiId: resJenisSapiId,
                                          eartag: "",
                                          eartagInduk: eartagInduk,
                                          namaSapi: namaSapi,
                                          tanggalLahir: "",
                                          kelamin:
                                              isJantan ? 'Jantan' : 'Betina',
                                          kondisiLahir: resKondisiLahir,
                                          anakKe: "0",
                                          generasi: "0",
                                          fotoDepan: "",
                                          fotoSamping: "",
                                          fotoPeternak: "",
                                          fotoRumah: "",
                                          peternakId: widget.sapi.peternakId);

                                      var dataResulSapi = DataResultSapi(
                                          resultSapi,
                                          resFileFotoDepan,
                                          resFileFotoSamping,
                                          resFileFotoPeternak,
                                          resFileFotoRUmah);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PerformaFormScreen(
                                                      null,
                                                      widget.userId,
                                                      dataResulSapi,
                                                      null,
                                                      widget.hakAkses)));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Pilih Foto Rumah')),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Pilih Foto Peternak')),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Pilih Foto Samping')),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Pilih Foto Depan')),
                                );
                              }
                            }
                          },
                          child: DefaultButton(
                            text: "Next",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Container listDokumentasi(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: ((builder) => _bottomSheet()));
            },
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: resFileFotoDepan == null
                                ? Colors.red
                                : kSecondaryColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Icon(resFileFotoDepan == null
                          ? FontAwesomeIcons.camera
                          : FontAwesomeIcons.image),
                    ),
                  ),
                ),
                Text("Depan"),
              ],
            ),
          )),
          SizedBox(width: getProportionateScreenWidth(8)),
          Expanded(
              child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: ((builder) => _bottomSheet()));
            },
            child: Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: resFileFotoDepan == null ? false : true,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: resFileFotoSamping == null
                                  ? Colors.red
                                  : kSecondaryColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Icon(resFileFotoSamping == null
                            ? FontAwesomeIcons.camera
                            : FontAwesomeIcons.image),
                      ),
                    ),
                  ),
                  Text("Samping"),
                ],
              ),
            ),
          )),
          SizedBox(width: getProportionateScreenWidth(8)),
          Expanded(
              child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: ((builder) => _bottomSheet()));
            },
            child: Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: resFileFotoSamping == null ? false : true,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: resFileFotoPeternak == null
                                  ? Colors.red
                                  : kSecondaryColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Icon(resFileFotoPeternak == null
                            ? FontAwesomeIcons.camera
                            : FontAwesomeIcons.image),
                      ),
                    ),
                  ),
                  Text("Peternak"),
                ],
              ),
            ),
          )),
          SizedBox(width: getProportionateScreenWidth(8)),
          Expanded(
              child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: ((builder) => _bottomSheet()));
            },
            child: Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: resFileFotoPeternak == null ? false : true,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: resFileFotoRUmah == null
                                  ? Colors.red
                                  : kSecondaryColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Icon(resFileFotoRUmah == null
                            ? FontAwesomeIcons.camera
                            : FontAwesomeIcons.image),
                      ),
                    ),
                  ),
                  Text("Rumah"),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  BlocBuilder<SapiMasterBloc, SapiMasterState> listKeteranganSapi() {
    return BlocBuilder<SapiMasterBloc, SapiMasterState>(
      builder: (context, state) {
        if (state is SapiMasterErrorState) {
          return Center(
              child: Text(state.errorMsg, style: TextStyle(color: Colors.red)));
        } else if (state is SapiMasterLoadedState) {
          return Column(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute<bool>(
                      builder: (BuildContext context) {
                        return Scaffold(
                          appBar: AppBar(
                            title: Text("Jenis Sapi"),
                          ),
                          body: WillPopScope(
                            onWillPop: () async {
                              Navigator.pop(context, false);
                              return false;
                            },
                            child: listJenisSapi(state.model.jenisSapi),
                          ),
                        );
                      },
                    ));
                  },
                  child: jenisSapiField()),
              SizedBox(height: getProportionateScreenHeight(8)),
            ],
          );
        } else {
          return _buildLoading();
        }
      },
    );
  }

  Container jenisSapiField() {
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
            '$resJenisSapi',
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

  Container listJenisSapi(List<JenisSapi> list) {
    return Container(
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            var data = list[index];
            return Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    resJenisSapiId = data.id;
                    resJenisSapi = data.jenis;
                  });
                  Navigator.pop(context, false);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.jenis,
                      style: TextStyle(fontSize: 18),
                    ),
                    Divider(),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Container listKondisLahir() {
    var list = ["Normal", "Operasi Sesar", "Mati"];
    return Container(
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            var data = list[index];
            return Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    resKondisiLahir = data;
                  });
                  Navigator.pop(context, false);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data,
                      style: TextStyle(fontSize: 18),
                    ),
                    Divider(),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Container kondisiLahirField() {
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
            '$resKondisiLahir',
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

  Container _bottomSheet() {
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
      File cropped = File(cropFile!.path);

      setState(() {
        if (statusFile == 1) {
          statusFile = 2;
          resFileFotoDepan = cropped!;
        } else if (statusFile == 2) {
          statusFile = 3;
          resFileFotoSamping = cropped!;
        } else if (statusFile == 3) {
          statusFile = 4;
          resFileFotoPeternak = cropped!;
        } else {
          resFileFotoRUmah = cropped!;
        }
      });
    }
  }

  ToggleSwitch switchTogle() {
    return ToggleSwitch(
      minWidth: 120,
      minHeight: 60,
      cornerRadius: 8.0,
      activeBgColors: [
        [Colors.green[800]!],
        [Colors.red[800]!]
      ],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.white,
      initialLabelIndex: isJantan ? 0 : 1,
      totalSwitches: 2,
      labels: const ['Jantan', 'Betina'],
      radiusStyle: true,
      onToggle: (index) {
        print('switched to: $index');
        setState(() {
          if (index == 0) {
            isJantan = true;
          } else {
            isJantan = false;
          }
        });
      },
    );
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
}
