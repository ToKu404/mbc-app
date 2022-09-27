import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:mbc_mobile/utils/AppColor.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class DetailSapiScreen extends StatefulWidget {
  final Sapi sapi;
  const DetailSapiScreen({Key? key, required this.sapi}) : super(key: key);

  @override
  _DetailSapiScreenState createState() => _DetailSapiScreenState();
}

class _DetailSapiScreenState extends State<DetailSapiScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            width: size.width,
            height: size.height * 0.5,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        Api.imageURL + '/' + widget.sapi.fotoDepan),
                    fit: BoxFit.cover)),
            child: Container(
              decoration: BoxDecoration(gradient: AppColor.linearBlackTop),
              height: size.height * 0.5,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
              top: 60,
              right: 16,
              left: 16,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset("assets/icons/Back ICon.svg",
                          color: Colors.white, width: 16),
                    ),
                    SizedBox(width: getProportionateScreenWidth(16)),
                    Text(
                        'MBC-${widget.sapi.generasi}.${widget.sapi.anakKe}-${widget.sapi.eartagInduk}-${widget.sapi.eartag}',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ])),
          Container(
            width: size.width,
            height: size.height,
            margin: EdgeInsets.only(top: size.height * 0.30),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                )),
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'MBC-${widget.sapi.generasi}.${widget.sapi.anakKe}-${widget.sapi.eartagInduk}-${widget.sapi.eartag}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    Row(
                      children: [
                        Icon(Icons.date_range, color: kTextColor, size: 20),
                        Text(widget.sapi.tanggalLahir,
                            style: TextStyle(color: kTextColor)),
                        SizedBox(width: getProportionateScreenWidth(36)),
                        Icon(Icons.child_friendly_rounded,
                            color: kTextColor, size: 20),
                        Text(widget.sapi.anakKe,
                            style: TextStyle(color: kTextColor)),
                      ],
                    ),
                    Divider(),
                    Text("Dokumentasi",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    dokumentasi(),
                    SizedBox(height: getProportionateScreenHeight(16)),
                    Divider(),
                    SizedBox(height: getProportionateScreenHeight(16)),
                    Text("Detail Sapi",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Nama Sapi", style: TextStyle(fontSize: 16)),
                          Text(widget.sapi.namaSapi,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Jenis Kelamin", style: TextStyle(fontSize: 16)),
                          Text(widget.sapi.kelamin,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Jenis Sapi", style: TextStyle(fontSize: 16)),
                          Text(widget.sapi.jenisSapi!.jenis,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                        ]),
                    Divider(),
                    Text("Peternak",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    Text(widget.sapi.peternak!.namaPeternak,
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                  ],
                )),
          ),
        ]),
      ),
    );
  }

  Row dokumentasi() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        Api.imageURL + '/' + widget.sapi.fotoSamping),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(8)),
        Expanded(
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      Api.imageURL + '/' + widget.sapi.fotoPeternak),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(8)),
        Expanded(
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                      NetworkImage(Api.imageURL + '/' + widget.sapi.fotoRumah),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
        ),
      ],
    );
  }
}
