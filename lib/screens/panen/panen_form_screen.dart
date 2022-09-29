import 'dart:io';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mbc_mobile/bloc/auth_bloc/authentication_bloc.dart';
import 'package:mbc_mobile/bloc/panen_bloc/panen_bloc.dart';
import 'package:mbc_mobile/bloc/sapi_bloc/sapi_bloc.dart';
import 'package:mbc_mobile/components/default_button.dart';
import 'package:mbc_mobile/helper/keyboard.dart';
import 'package:mbc_mobile/models/panen_model.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:mbc_mobile/repositories/panen_repo.dart';
import 'package:mbc_mobile/repositories/sapi_repo.dart';
import 'package:mbc_mobile/screens/new_home_page/home_page.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class PanenFormScreen extends StatelessWidget {
  final String userId;
  final String notifId;
  final Sapi? sapi;
  final String hakAkses;

  const PanenFormScreen(
      Key? key, this.userId, this.sapi, this.notifId, this.hakAkses)
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Data Panen", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[kSecondaryColor, kPrimaryColor])),
        ),
      ),
      body: BlocProvider(
          create: (context) => PanenBloc(PanenRepositoryImpl()),
          child: BlocProvider(
            create: (context) => SapiBloc(SapiRepositoryImpl()),
            child: Container(
              padding: EdgeInsets.all(8),
              child: PanenFormScreenBody(null, userId, sapi, notifId, hakAkses),
            ),
          )),
    );
  }
}

class PanenFormScreenBody extends StatefulWidget {
  final String userId;
  final String notifId;
  final Sapi? sapi;
  final String hakAkses;

  const PanenFormScreenBody(
      Key? key, this.userId, this.sapi, this.notifId, this.hakAkses)
      : super(key: key);

  @override
  _PanenFormScreenBodyState createState() => _PanenFormScreenBodyState();
}

class _PanenFormScreenBodyState extends State<PanenFormScreenBody> {
  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  File? resFile;

  late SapiBloc sapiBloc;
  late PanenBloc panenBloc;

  int resSapiId = 0;
  String resSapi = "Pilih Eartag Sapi";
  String resKetPanen = "Pilih Status Panen";

  @override
  void initState() {
    if (widget.sapi != null) {
      print(widget.sapi!.eartag);
      resSapi =
          'MBC-${widget.sapi!.generasi}.${widget.sapi!.anakKe}-${widget.sapi!.eartagInduk}-${widget.sapi!.eartag}';
      resSapiId = widget.sapi!.id;
    }

    sapiBloc = BlocProvider.of<SapiBloc>(context);
    panenBloc = BlocProvider.of<PanenBloc>(context);
    sapiBloc.add(SapiFetchDataEvent(widget.userId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PanenBloc, PanenState>(
      listener: (context, state) {
        print(state);
        if (state is PanenInitial || state is PanenLoadingState) {
          EasyLoading.show(status: 'loading');
        } else if (state is PanenErrorState) {
          EasyLoading.showError(state.msg);
          EasyLoading.dismiss();
        } else if (state is PanenSuccessState) {
          EasyLoading.showSuccess(state.msg);
          EasyLoading.dismiss();
          // Navigator.pop(context);
          gotoHomePage(widget.userId, widget.hakAkses);
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
                      child: resFile == null
                          ? Image.asset(Images.plaeholderImage,
                              fit: BoxFit.cover)
                          : Image.file(File(resFile!.path)),
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
                              title: Text("Pilih Status Panen"),
                            ),
                            body: WillPopScope(
                              onWillPop: () async {
                                Navigator.pop(context, false);
                                return false;
                              },
                              child: listKetPanen(),
                            ),
                          );
                        },
                      ));
                    },
                    child: ketPanenField()),
                SizedBox(height: getProportionateScreenHeight(16)),
                Divider(),
                SizedBox(height: getProportionateScreenHeight(32)),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      KeyboardUtil.hideKeyboard(context);
                      if (resFile != null) {
                        if (resSapiId != 0) {
                          alertConfirm();
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
    return BlocBuilder<SapiBloc, SapiState>(builder: (context, state) {
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
    });
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

  Container listKetPanen() {
    var list = ["Jual", "Beli"];
    return Container(
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(),
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    resKetPanen = list[index];
                  });
                  Navigator.pop(context, false);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      list[index],
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

  Container ketPanenField() {
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
            '$resKetPanen',
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
        resFile = cropped!;
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
      var panen = Panen(
          foto: "",
          id: 0,
          sapiId: resSapiId,
          peternakId: 0,
          pendampingId: 0,
          tsrId: 0,
          status: resKetPanen,
          keterangan: resKetPanen,
          tanggal: "");
      panenBloc.add(PanenStoreEvent(
          file: resFile, panen: panen, notifId: widget.notifId));
      return;
    }
  }

  void gotoHomePage(String userId, String hakAkses) {
    AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => HomePage(
                userId: userId, bloc: authenticationBloc, hakAkses: hakAkses)),
        (Route<dynamic> route) => false);
  }
}
