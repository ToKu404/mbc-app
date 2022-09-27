import 'package:flutter/material.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';

class GuidePerforma extends StatelessWidget {
  const GuidePerforma({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Petunjuk Performa/Recording",
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
                        "Pastikan Terdapat Notif untuk melakukan Performa / Recording, Notif ini bisa anda dapatkan dalam menu dashboard ataupun menu Notifikasi Timeline",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    SizedBox(height: 8),
                    Image.asset(Images.performaNotifImage, height: 500),
                  ],
                ),
                SizedBox(height: 16),
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
                          child: Text("Silahkan Memilih BCS.",
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
                              "Silahkan Masukkan tinggi badan sapi ternak.",
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
                              "Silahkan Masukkan berat badan sapi ternak.",
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
                              "Silahkan Masukkan panjang badan sapi ternak.",
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
                              "Silahkan Masukkan lingkar dada sapi ternak.",
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
                              "Apabila semua kolom telah terisi, harap pastikan kesesuaiannya terlebih dahulu, kemudian tekan SUBMIT.",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Image.asset(Images.performaFormImage, height: 500),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
