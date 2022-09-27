import 'dart:io';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mbc_mobile/bloc/auth_bloc/authentication_bloc.dart';
import 'package:mbc_mobile/bloc/insiminasi_buatan_bloc/insiminasi_buatan_bloc.dart';
import 'package:mbc_mobile/bloc/sapi_bloc/sapi_bloc.dart';
import 'package:mbc_mobile/bloc/strow_bloc/strow_bloc.dart';
import 'package:mbc_mobile/components/default_button.dart';
import 'package:mbc_mobile/helper/keyboard.dart';
import 'package:mbc_mobile/models/insiminasi_buatan_model.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:mbc_mobile/models/strow_model.dart';
import 'package:mbc_mobile/screens/new_home_page/home_page.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:mbc_mobile/utils/theme.dart';

class InsiminasiBuatanFormBody extends StatefulWidget {
  final String userId;
  final String notifId;
  final Sapi? sapi;
  final String hakAkses;

  const InsiminasiBuatanFormBody(
      Key? key, this.userId, this.notifId, this.sapi, this.hakAkses)
      : super(key: key);

  @override
  _InsiminasiBuatanFormBodyState createState() =>
      _InsiminasiBuatanFormBodyState();
}

class _InsiminasiBuatanFormBodyState extends State<InsiminasiBuatanFormBody> {
  final _formKey = GlobalKey<FormState>();

  late SapiBloc sapiBloc;
  late StrowBloc strowBloc;
  late InsiminasiBuatanBloc insiminasiBuatanBloc;

  int resSapiId = 0;
  String resSapi = "Pilih Eartag Sapi";
  int resStrowId = 0;
  String resStrow = "Pilih Straw";
  int resId = 0;
  String resTgl = "";

  late File? _imageFile = null;
  final ImagePicker _picker = ImagePicker();
  late File? resFile;

  @override
  void initState() {
    super.initState();

    sapiBloc = BlocProvider.of<SapiBloc>(context);
    strowBloc = BlocProvider.of<StrowBloc>(context);
    insiminasiBuatanBloc = BlocProvider.of<InsiminasiBuatanBloc>(context);

    sapiBloc.add(SapiFetchDataEvent(widget.userId));
    strowBloc.add(StrowFetchDataEvent());

    if (widget.sapi != null) {
      print(widget.sapi!.eartag);
      resSapi =
          'MBC-${widget.sapi!.generasi}.${widget.sapi!.anakKe}-${widget.sapi!.eartagInduk}-${widget.sapi!.eartag}';
      resSapiId = widget.sapi!.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InsiminasiBuatanBloc, InsiminasiBuatanState>(
      listener: (context, state) {
        print(state);
        if (state is InsiminasiBuatanInitialState ||
            state is InsiminasiBuatanLoadingState) {
          EasyLoading.show(status: 'loading');
        } else if (state is InsiminasiBuatanErrorState) {
          EasyLoading.showError(state.msg);
          EasyLoading.dismiss();
        } else if (state is InsiminasiBuatanSuccessState) {
          EasyLoading.showSuccess(state.msg);
          EasyLoading.dismiss();
          // Navigator.pop(context, true);

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
                loadStrow(),
                SizedBox(height: getProportionateScreenHeight(8)),
                Divider(),
                SizedBox(height: getProportionateScreenHeight(36)),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      KeyboardUtil.hideKeyboard(context);
                      if (resFile != null) {
                        if (resSapiId != 0) {
                          InsiminasiBuatan insiminasiBuatan = InsiminasiBuatan(
                              id: resId,
                              waktuIb: resTgl,
                              sapiId: resSapiId,
                              strowId: resStrowId,
                              peternakId: 0,
                              pendampingId: 0,
                              tsrId: 0,
                              foto: "",
                              dosisIb: 0);

                          alertConfirm(insiminasiBuatan);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Pilih sapi dulu')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Pilih Foto Dokumentasi')));
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

  Widget loadStrow() {
    return BlocBuilder<StrowBloc, StrowState>(builder: (context, state) {
      print('strow $state');

      if (state is StrowInitialState || state is StrowLoadingState) {
        return buildLoading();
      } else if (state is StrowLoadedState) {
        return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<bool>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("Pilih Straw"),
                    ),
                    body: WillPopScope(
                      onWillPop: () async {
                        Navigator.pop(context, false);
                        return false;
                      },
                      child: listStrawNew(state.datas),
                    ),
                  );
                },
              ));
            },
            child: strawField());
      } else {
        return buildError(state.toString());
      }
    });
  }

  Container listStrawNew(List<Strow> list) {
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
                    resStrowId = data.id;
                    resStrow = data.kodeBatch;
                  });
                  Navigator.pop(context, false);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.kodeBatch,
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

  Container strawField() {
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
            '$resStrow',
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

  void alertConfirm(InsiminasiBuatan insiminasiBuatan) async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
            denyButtonText: "Cancel",
            title: "Are you sure?",
            text: "You won't be able to revert this!",
            confirmButtonText: "Yes, submit it",
            type: ArtSweetAlertType.warning));

    // ignore: unnecessary_null_comparison
    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      insiminasiBuatanBloc.add(InsiminasiBuatanStoreEvent(
          file: resFile,
          insiminasiBuatan: insiminasiBuatan,
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
