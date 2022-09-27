import 'package:flutter/material.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';

class GuideMenuUtama extends StatelessWidget {
  const GuideMenuUtama({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Petunjuk Menu Utama",
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Pada aplikasi ini terdapat menu utama, yaitu Dashboard, Notifikasi, Petunjuk, dan Pengaturan.",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("1.",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    SizedBox(width: 16),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Menu Dashboard",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        Text("Menu ini berisikan informasi mengenai ;",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.start),
                        Text("- Jumlah updah kinerja,",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.start),
                        Text("- List notifikasi perlakuan,",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.start),
                        Text("- List menu perlakuan,",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.start),
                        Text("- List sapi ternak,",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.start),
                        Text("- dan List peternak.",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.start),
                        SizedBox(height: 8),
                        Image.asset(Images.homeDashboardImage, height: 500),
                      ],
                    ))
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("2.",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    SizedBox(width: 16),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Menu Notifikasi",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        Text(
                            "Menu ini berisikan informasi mengenai semua list notifikasi perlakuan.",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.start),
                        SizedBox(height: 8),
                        Image.asset(Images.homeNotifImage, height: 500),
                      ],
                    ))
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("3.",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    SizedBox(width: 16),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Menu Petunjuk",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        Text(
                            "Menu ini berisikan informasi mengenai semua petunjuk penggunaan aplikasi.",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.start),
                        SizedBox(height: 8),
                        Image.asset(Images.homeGuideImage, height: 500),
                      ],
                    ))
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("4.",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    SizedBox(width: 16),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Menu Pengaturan",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        Text(
                            "Menu ini berisikan informasi mengenai data diri pendamping dan pendamping dapat memperbaharui informasi tersebut.",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.left),
                        SizedBox(height: 8),
                        Image.asset(Images.homeSettingImage, height: 500),
                      ],
                    ))
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ));
  }
}
