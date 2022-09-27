import 'package:flutter/material.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';

class GuideMenuHome extends StatelessWidget {
  const GuideMenuHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Petunjuk Menu Perlakuan",
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
                SizedBox(height: 8),
                Image.asset(Images.menuHomeImage, height: 500),
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
                              "Menu Performa/Recording berisikan informasi mengenai semua data perlakuan Performa/Recording yang telah dilakukan.",
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
                        Text("2. ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                              "Menu Perlakuan Kesehatan berisikan informasi mengenai semua data perlakuan Kesehatan yang telah dilakukan.",
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
                              "Menu Periksa Kebuntingan berisikan informasi mengenai semua data perlakuan Periksa Kebuntingan yang telah dilakukan.",
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
                          child: Text(
                              "Menu Insiminasi Buatan berisikan informasi mengenai semua data perlakuan Insiminasi Buatan yang telah dilakukan.",
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
                              "Menu Panen berisikan informasi mengenai semua data perlakuan Panen yang telah dilakukan.",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
