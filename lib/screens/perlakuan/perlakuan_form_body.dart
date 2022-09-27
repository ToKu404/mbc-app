import 'dart:io';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mbc_mobile/bloc/auth_bloc/authentication_bloc.dart';
import 'package:mbc_mobile/bloc/hormon_bloc/hormon_bloc.dart';
import 'package:mbc_mobile/bloc/obat_bloc/obat_bloc.dart';
import 'package:mbc_mobile/bloc/perlakuan_bloc/perlakuan_bloc.dart';
import 'package:mbc_mobile/bloc/sapi_bloc/sapi_bloc.dart';
import 'package:mbc_mobile/bloc/vaksin_bloc/vaksin_bloc.dart';
import 'package:mbc_mobile/bloc/vitamin_bloc/vitamin_bloc.dart';
import 'package:mbc_mobile/components/default_button.dart';
import 'package:mbc_mobile/helper/keyboard.dart';
import 'package:mbc_mobile/models/hormon_model.dart';
import 'package:mbc_mobile/models/obat_model.dart';
import 'package:mbc_mobile/models/perlakuan_model.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:mbc_mobile/models/vaksin_model.dart';
import 'package:mbc_mobile/models/vitamin_model.dart';
import 'package:mbc_mobile/screens/new_home_page/home_page.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:mbc_mobile/utils/theme.dart';

class PerlakuanFormBody extends StatefulWidget {
  final String userId;
  final String notifikasiId;
  final Sapi? sapi;
  final String hakAkses;

  const PerlakuanFormBody(
      Key? key, this.userId, this.notifikasiId, this.sapi, this.hakAkses)
      : super(key: key);

  @override
  _PerlakuanFormBodyState createState() => _PerlakuanFormBodyState();
}

class _PerlakuanFormBodyState extends State<PerlakuanFormBody> {
  final _formKey = GlobalKey<FormState>();

  late SapiBloc sapiBloc;
  late PerlakuanBloc perlakuanBloc;
  late ObatBloc obatBloc;
  late VitaminBloc vitaminBloc;
  late VaksinBloc vaksinBloc;
  late HormonBloc hormonBloc;

  int resSapiId = 0;
  String resSapi = "Pilih Eartag Sapi";
  int resObatId = 0;
  String resObat = "Pilih Jenis Obat";
  int resVitaminId = 0;
  String resVitamin = "Pilih Jenis Vitamin";
  int resVaksinId = 0;
  String resVaksin = "Pilih Jenis Vaksin";
  int resHormonId = 0;
  String resHormon = "Pilih Jenis Hormon";
  int resId = 0;

  final _resObatDosis = new TextEditingController();
  final _resVaksinDosis = new TextEditingController();
  final _resVitaminDosis = new TextEditingController();
  final _resHormonDosis = new TextEditingController();
  final _resKeterangan = new TextEditingController();

  late File? _imageFile = null;
  final ImagePicker _picker = ImagePicker();
  late File? resFile;

  @override
  void initState() {
    super.initState();

    sapiBloc = BlocProvider.of<SapiBloc>(context);
    perlakuanBloc = BlocProvider.of<PerlakuanBloc>(context);
    obatBloc = BlocProvider.of<ObatBloc>(context);
    vitaminBloc = BlocProvider.of<VitaminBloc>(context);
    vaksinBloc = BlocProvider.of<VaksinBloc>(context);
    hormonBloc = BlocProvider.of<HormonBloc>(context);

    sapiBloc.add(SapiFetchDataEvent(widget.userId));
    obatBloc.add(ObatFetchDataEvent());
    vitaminBloc.add(VitaminFetchDataEvent());
    vaksinBloc.add(VaksinFetchDataEvent());
    hormonBloc.add(HormonFetchDataEvent());

    if (widget.sapi != null) {
      print(widget.sapi!.eartag);
      resSapi =
          'MBC-${widget.sapi!.generasi}.${widget.sapi!.anakKe}-${widget.sapi!.eartagInduk}-${widget.sapi!.eartag}';

      resSapiId = widget.sapi!.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PerlakuanBloc, PerlakuanState>(
      listener: (context, state) {
        print(state);
        if (state is PerlakuanInitialState || state is PerlakuanLoadingState) {
          EasyLoading.show(status: 'loading');
        } else if (state is PerlakuanErrorState) {
          EasyLoading.showError(state.msg);
          EasyLoading.dismiss();
        } else if (state is PerlakuanSuccessState) {
          EasyLoading.showSuccess(state.msg);
          EasyLoading.dismiss();

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
                Divider(),
                SizedBox(height: getProportionateScreenHeight(16)),
                loadSapi(),
                SizedBox(height: getProportionateScreenHeight(8)),
                loadObat(),
                SizedBox(height: getProportionateScreenHeight(8)),
                loadVitamin(),
                SizedBox(height: getProportionateScreenHeight(8)),
                loadVaksin(),
                SizedBox(height: getProportionateScreenHeight(8)),
                loadHormon(),
                SizedBox(height: getProportionateScreenHeight(16)),
                Divider(),
                SizedBox(height: getProportionateScreenHeight(16)),
                cardDosis(),
                SizedBox(height: getProportionateScreenHeight(16)),
                Divider(),
                Text("Keterangan Perlakuan ", style: titleDarkStyle),
                SizedBox(height: getProportionateScreenHeight(8)),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: kHintTextColor, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: _resKeterangan,
                        maxLines: 4,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "gak boleh kosong bro";
                          }
                          return null;
                        },
                        decoration: inputForm("Input Keterangan Perlakuan",
                            "Input Keterangan Perlakuan")),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(32)),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      KeyboardUtil.hideKeyboard(context);
                      if (resFile != null) {
                        if (resSapiId != 0) {
                          if (resObatId != 0) {
                            if (resVitaminId != 0) {
                              if (resVaksinId != 0) {
                                if (resHormonId != 0) {
                                  Perlakuan perlakuan = Perlakuan(
                                      id: resId,
                                      sapiId: resSapiId,
                                      peternakId: 0,
                                      pendampingId: 0,
                                      tsrId: 0,
                                      tglPerlakuan: "",
                                      obatId: resObatId,
                                      dosisObat:
                                          int.parse(_resObatDosis.text.trim()),
                                      vaksinId: resVaksinId,
                                      dosisVaksin: int.parse(
                                          _resVaksinDosis.text.trim()),
                                      vitaminId: resVitaminId,
                                      dosisVitamin: int.parse(
                                          _resVitaminDosis.text.trim()),
                                      hormonId: resHormonId,
                                      dosisHormon: int.parse(
                                          _resHormonDosis.text.trim()),
                                      ketPerlakuan: _resKeterangan.text.trim(),
                                      foto: "");

                                  alertConfirm(perlakuan);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Pilih Hormon dulu')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Pilih Vaksin dulu')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Pilih Vitamin dulu')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Pilih Obat dulu')));
                          }
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

  Container cardDosis() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Dosis Obat ", style: titleDarkStyle),
          buildFormField('ex : 100', _resObatDosis, TextInputType.number),
          SizedBox(height: getProportionateScreenHeight(16)),
          Text("Dosis Vaksin ", style: titleDarkStyle),
          buildFormField('ex : 100', _resVaksinDosis, TextInputType.number),
          SizedBox(height: getProportionateScreenHeight(16)),
          Text("Dosis Vitamin ", style: titleDarkStyle),
          buildFormField('ex : 100', _resVitaminDosis, TextInputType.number),
          SizedBox(height: getProportionateScreenHeight(16)),
          Text("Dosis Hormon ", style: titleDarkStyle),
          buildFormField('ex : 100', _resHormonDosis, TextInputType.number),
          SizedBox(height: getProportionateScreenHeight(16)),
        ],
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

  Widget loadObat() {
    return BlocBuilder<ObatBloc, ObatState>(builder: (context, state) {
      if (state is ObatInitialState || state is ObatLoadingState) {
        return buildLoading();
      } else if (state is ObatLoadedState) {
        return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<bool>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("Pilih Jenis Obat"),
                    ),
                    body: WillPopScope(
                      onWillPop: () async {
                        Navigator.pop(context, false);
                        return false;
                      },
                      child: listObatNew(state.model.obat),
                    ),
                  );
                },
              ));
            },
            child: obatField());
      }

      return buildLoading();
    });
  }

  Container listObatNew(List<Obat> list) {
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
                    resObatId = data.id;
                    resObat = data.name;
                  });
                  Navigator.pop(context, false);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
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

  Container obatField() {
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
            '$resObat',
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

  Widget loadVitamin() {
    return BlocBuilder<VitaminBloc, VitaminState>(builder: (context, state) {
      if (state is VitaminInitialState || state is VitaminLoadingState) {
        return buildLoading();
      } else if (state is VitaminLoadedState) {
        return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<bool>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("Pilih Jenis Vitamin"),
                    ),
                    body: WillPopScope(
                      onWillPop: () async {
                        Navigator.pop(context, false);
                        return false;
                      },
                      child: listVitaminNew(state.model.vitamin),
                    ),
                  );
                },
              ));
            },
            child: vitaminField());
      }

      return buildLoading();
    });
  }

  Container listVitaminNew(List<Vitamin> list) {
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
                    resVitaminId = data.id;
                    resVitamin = data.name;
                  });
                  Navigator.pop(context, false);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
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

  Container vitaminField() {
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
            '$resVitamin',
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

  Widget loadVaksin() {
    return BlocBuilder<VaksinBloc, VaksinState>(builder: (context, state) {
      if (state is VaksinInitialState || state is VaksinLoadingState) {
        return buildLoading();
      } else if (state is VaksinLoadedState) {
        return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<bool>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("Pilih Jenis Vaksin"),
                    ),
                    body: WillPopScope(
                      onWillPop: () async {
                        Navigator.pop(context, false);
                        return false;
                      },
                      child: listVaksinNew(state.model.vaksin),
                    ),
                  );
                },
              ));
            },
            child: vaksinField());
      } else {
        return buildLoading();
      }
    });
  }

  Container listVaksinNew(List<Vaksin> list) {
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
                    resVaksinId = data.id;
                    resVaksin = data.name;
                  });
                  Navigator.pop(context, false);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
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

  Container vaksinField() {
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
            '$resVaksin',
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

  Widget loadHormon() {
    return BlocBuilder<HormonBloc, HormonState>(builder: (context, state) {
      if (state is HormonInitialState || state is HormonLoadingState) {
        return buildLoading();
      } else if (state is HormonLoadedState) {
        return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<bool>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("Pilih Jenis Hormon"),
                    ),
                    body: WillPopScope(
                      onWillPop: () async {
                        Navigator.pop(context, false);
                        return false;
                      },
                      child: listHormonNew(state.model.hormon),
                    ),
                  );
                },
              ));
            },
            child: hormonField());
      } else {
        return buildLoading();
      }
    });
  }

  Container listHormonNew(List<Hormon> list) {
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
                    resHormonId = data.id;
                    resHormon = data.name;
                  });
                  Navigator.pop(context, false);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
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

  Container hormonField() {
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
            '$resHormon',
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

  TextFormField buildFormField(
      String hint, TextEditingController controller, TextInputType inputType) {
    return TextFormField(
        keyboardType: inputType,
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
      File cropped = File(cropFile!.path);

      setState(() {
        _imageFile = cropped;
        resFile = _imageFile!;
      });
    }
  }

  void alertConfirm(Perlakuan perlakuan) async {
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
      perlakuanBloc.add(PerlakuanStoreEvent(
          file: resFile,
          perlakuan: perlakuan,
          notifikasiId: widget.notifikasiId));
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
