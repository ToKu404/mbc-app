import 'dart:io';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mbc_mobile/bloc/auth_bloc/authentication_bloc.dart';
import 'package:mbc_mobile/bloc/performa_bloc/performa_bloc.dart';
import 'package:mbc_mobile/bloc/sapi_bloc/sapi_bloc.dart';
import 'package:mbc_mobile/components/default_button.dart';
import 'package:mbc_mobile/helper/keyboard.dart';
import 'package:mbc_mobile/models/performa_model.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:mbc_mobile/screens/new_home_page/home_page.dart';
import 'package:mbc_mobile/screens/sapi/data_result_sapi.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:mbc_mobile/utils/theme.dart';

class PerformaFormBody extends StatefulWidget {
  final String userId;
  final String hakAkses;

  final DataResultSapi? resultSapi;
  final Sapi? sapi;

  const PerformaFormBody(
      Key? key, this.userId, this.resultSapi, this.sapi, this.hakAkses)
      : super(key: key);

  @override
  _PerformaFormBodyState createState() => _PerformaFormBodyState();
}

class _PerformaFormBodyState extends State<PerformaFormBody> {
  final _formKey = GlobalKey<FormState>();
  late SapiBloc sapiBloc;
  late PerformaBloc performaBloc;

  List<Sapi> listSapi = [];

  int resSapiId = 0;
  String resSapi = "Pilih Eartag Sapi";
  String resBSC = "Pilih BCS";

  int resId = 0;
  String resTgl = "";

  late DateTime date;

  final _resTinggi = new TextEditingController();
  final _resBerat = new TextEditingController();
  final _resPanjang = new TextEditingController();
  final _resLingkar = new TextEditingController();

  late File? _imageFile = null;
  final ImagePicker _picker = ImagePicker();
  late File? resFile;

  @override
  void initState() {
    super.initState();

    sapiBloc = BlocProvider.of<SapiBloc>(context);
    performaBloc = BlocProvider.of<PerformaBloc>(context);

    sapiBloc.add(SapiFetchDataEvent(widget.userId));

    if (widget.resultSapi != null) {
      resSapiId = 10000;
    }
    if (widget.sapi != null) {
      print(widget.sapi!.eartag);
      resSapi =
          'MBC-${widget.sapi!.generasi}.${widget.sapi!.anakKe}-${widget.sapi!.eartagInduk}-${widget.sapi!.eartag}';
      resSapiId = widget.sapi!.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PerformaBloc, PerformaState>(
      listener: (context, state) {
        print(state);
        if (state is PerformaInitialState || state is PerformaLoadingState) {
          EasyLoading.show(status: 'loading');
        } else if (state is PerformaErrorState) {
          EasyLoading.showError(state.msg);
          EasyLoading.dismiss();
        } else if (state is PerformaSuccessState) {
          EasyLoading.showSuccess(state.msg);
          EasyLoading.dismiss();

          // Navigator.pop(context);
          gotoHomePage(widget.userId);
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
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute<bool>(
                        builder: (BuildContext context) {
                          return Scaffold(
                            appBar: AppBar(
                              title: Text("Pilih BCS"),
                            ),
                            body: WillPopScope(
                              onWillPop: () async {
                                Navigator.pop(context, false);
                                return false;
                              },
                              child: listBCS(),
                            ),
                          );
                        },
                      ));
                    },
                    child: bcsField()),
                SizedBox(height: getProportionateScreenHeight(16)),
                Divider(),
                Text("Tinggi Badan "),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(child: buildFormField('ex : 100', _resTinggi)),
                  SizedBox(width: getProportionateScreenWidth(16)),
                  Text("CM", style: TextStyle(fontSize: 20)),
                ]),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text("Berat Badan "),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(child: buildFormField('ex : 100', _resBerat)),
                  SizedBox(width: getProportionateScreenWidth(16)),
                  Text("KG", style: TextStyle(fontSize: 20)),
                ]),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text("Panjang Badan "),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(child: buildFormField('ex : 100', _resPanjang)),
                  SizedBox(width: getProportionateScreenWidth(16)),
                  Text("CM", style: TextStyle(fontSize: 20)),
                ]),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text("Lingkar Dada "),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(child: buildFormField('ex : 100', _resLingkar)),
                  SizedBox(width: getProportionateScreenWidth(16)),
                  Text("CM", style: TextStyle(fontSize: 20)),
                ]),
                SizedBox(height: getProportionateScreenHeight(16)),
                SizedBox(height: getProportionateScreenHeight(32)),
                GestureDetector(
                  onTap: () {
                    var berat = _resBerat.text.trim();
                    if (berat == "") {
                      berat = "0";
                    }
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      KeyboardUtil.hideKeyboard(context);
                      if (resFile != null) {
                        if (resSapiId != 0) {
                          var data = Performa(
                              id: resId,
                              sapiId: resSapiId,
                              peternakId: 0,
                              pendampingId: 0,
                              tsrId: 0,
                              tanggalPerforma: resTgl,
                              tinggiBadan: int.parse(_resTinggi.text.trim()),
                              beratBadan: int.parse(berat),
                              panjangBadan: int.parse(_resPanjang.text.trim()),
                              lingkarDada: int.parse(_resLingkar.text.trim()),
                              bsc: int.parse(resBSC),
                              foto: "");

                          alertConfirm(data);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Pilih sapi dulu')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Pilih Foto Dokumentasi Kegiatan')));
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
    return BlocListener<SapiBloc, SapiState>(
      listener: (context, state) {
        if (state is SapiInitialState || state is SapiLoadingState) {
          EasyLoading.show(status: 'loading');
        } else if (state is SapiSuccessState) {
          EasyLoading.showSuccess(state.msg);
          EasyLoading.dismiss();

          // Navigator.pop(context);
          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => HomePage(userId: widget.userId)));

          gotoHomePage(widget.userId);
        } else {
          EasyLoading.dismiss();
        }
      },
      child: Visibility(
        visible: widget.resultSapi != null ? false : true,
        child: BlocBuilder<SapiBloc, SapiState>(builder: (context, state) {
          if (state is SapiLoadedState) {
            EasyLoading.dismiss();

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
          } else if (state is SapiErrorState) {
            EasyLoading.dismiss();

            return buildError(state.msg);
          } else {
            return buildLoading();
          }
        }),
      ),
    );
  }

  Container listSapiNew(List<Sapi> list) {
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
                    resSapiId = data.id;
                    resSapi =
                        'MBC-${data.generasi}.${data.anakKe}-${data.eartagInduk}-${data.eartag}';
                  });
                  Navigator.pop(context, false);
                },
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
            );
          }),
    );
  }

  Container listBCS() {
    return Container(
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    resBSC = (index + 1).toString();
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
                        (index + 1).toString(),
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

  Container bcsField() {
    return Container(
      width: double.infinity,
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
            '$resBSC',
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

  TextFormField buildFormField(String hint, TextEditingController controller) {
    return TextFormField(
        keyboardType: TextInputType.number,
        controller: controller,
        validator: (value) {
          if (controller != _resBerat) {
            if (value!.isEmpty) {
              return "gak boleh kosong bro";
            }
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
    final pickedFile = await _picker.getImage(source: source);
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

  void alertConfirm(Performa data) async {
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
      if (widget.resultSapi != null) {
        sapiBloc.add(SapiStoreEvent(
            fotoDepan: widget.resultSapi!.fotoDepan,
            fotoSamping: widget.resultSapi!.fotoSamping,
            fotoPeternak: widget.resultSapi!.fotoPeternak,
            fotoRumah: widget.resultSapi!.fotoRumah,
            sapi: widget.resultSapi!.sapi,
            fotoPerforma: resFile,
            performa: data));
      } else {
        performaBloc.add(PerformaStoreEvent(
            file: _imageFile == null ? null : _imageFile!, performa: data));
      }

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
