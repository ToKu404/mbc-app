import 'package:flutter/material.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';

class GuidePKB extends StatelessWidget {
  const GuidePKB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Petunjuk Periksa Kebuntingan",
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
                              "Pastikan Terdapat Notif untuk melakukan Periksa Kebuntingan, Notif ini bisa anda dapatkan dalam menu dashboard ataupun menu Notif Timeline",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Image.asset(Images.pkbNotifImage, height: 500),
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
                              "Silahkan Foto dokumentasi dari perlakuan.",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("3. ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                              "Silahkan memilih EARTAG sapi dan pastikan sesuai dengan notifikasi.",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("4. ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text("Silahkan memilih metode perlakuan.",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("5. ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                              "Silahkan memilih hasil daripada perlakuan, apabila hasilnya adalah BUNTING, maka harap memilih jenis kebuntingan, apakah karena alami ataupun IB.",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("6. ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text("Silahkan memilih jenis reproduksi.",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("7. ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                              "Apabila semua kolom telah terisi, harap pastikan kesesuaiannya terlebih dahulu, kemudian tekan SUBMIT.",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Image.asset(Images.pkbFormImage, height: 500),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
