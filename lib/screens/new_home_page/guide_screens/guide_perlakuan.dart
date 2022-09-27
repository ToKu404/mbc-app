import 'package:flutter/material.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';

class GuidePerlakuan extends StatelessWidget {
  const GuidePerlakuan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Petunjuk Perlakuan Kesehatan",
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
                    Text(
                        "Pastikan Terdapat Notif untuk melakukan Perlakuan Kesehatan, Notifikasi ini bisa anda dapatkan dalam menu dashboard ataupun menu Notifikasi Timeline",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    SizedBox(height: 8),
                    Image.asset(Images.perlakuanNotifImage, height: 500),
                  ],
                ),
                SizedBox(height: 16),
                Divider(),
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
                              "Silahkan Foto dokumentasi dari perlakuan.",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("2. ", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                              "Silahkan memilih EARTAG sapi dan pastikan sesuai dengan notifikasi.",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("3. ", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                              "Silahkan Memilih Jenis Obat yang diberikan kepada sapi ternak.",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("4. ", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                              "Silahkan Memilih Jenis Vitamin yang diberikan kepada sapi ternak.",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("5. ", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                              "Silahkan Memilih Jenis Vaksin yang diberikan kepada sapi ternak.",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("6. ", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                              "Silahkan Memilih Jenis Hormon yang diberikan kepada sapi ternak.",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("7. ", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                              "Silahkan masukan Dosis Obat yang diberikan kepada sapi ternak.",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("8. ", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                              "Silahkan masukan Dosis Vaksin yang diberikan kepada sapi ternak.",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("9. ", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                              "Silahkan masukan Dosis Vitamin yang diberikan kepada sapi ternak.",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("10. ", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                              "Silahkan masukan Dosis Hormon yang diberikan kepada sapi ternak.",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("11. ", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                              "(Optional) Silahkan masukan keterangan perlakuan yang diberikan kepada sapi ternak, bila diperlukan.",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("12. ", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                              "Apabila semua kolom telah terisi, harap pastikan kesesuaiannya terlebih dahulu, kemudian tekan SUBMIT.",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Image.asset(Images.perlakuanFormAImage, height: 500),
                    Image.asset(Images.perlakuanFormBImage, height: 500),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
