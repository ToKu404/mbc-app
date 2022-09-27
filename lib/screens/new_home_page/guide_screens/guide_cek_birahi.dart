import 'package:flutter/material.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';

class GuideCekBirahi extends StatelessWidget {
  const GuideCekBirahi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Petunjuk Cek Birahi",
              style: TextStyle(color: Colors.white)),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[kSecondaryColor, kPrimaryColor])),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("1. ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                              "Pastikan Terdapat Notif untuk mlakukan Cek Birahi, Notif ini bisa anda dapatkan dalam menu dashboard ataupun menu Notif Timeline",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Image.asset(Images.birahiNotifImage, height: 500),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("2. ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                              "Silahkan inputkan hasil cek birahi yang sesuai, apabila terdapat perbedaan hari pastikan anda memilih tanggal yang sesuai dengan hari anda melakukan cek birahi.",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Image.asset(Images.birahiFormImage, height: 500),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
