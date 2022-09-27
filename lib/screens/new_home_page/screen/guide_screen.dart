import 'package:flutter/material.dart';
import 'package:mbc_mobile/screens/new_home_page/guide_screens/guide_cek_birahi.dart';
import 'package:mbc_mobile/screens/new_home_page/guide_screens/guide_ib.dart';
import 'package:mbc_mobile/screens/new_home_page/guide_screens/guide_menu_home.dart';
import 'package:mbc_mobile/screens/new_home_page/guide_screens/guide_menu_utama.dart';
import 'package:mbc_mobile/screens/new_home_page/guide_screens/guide_panen.dart';
import 'package:mbc_mobile/screens/new_home_page/guide_screens/guide_performa.dart';
import 'package:mbc_mobile/screens/new_home_page/guide_screens/guide_perlakuan.dart';
import 'package:mbc_mobile/screens/new_home_page/guide_screens/guide_pkb.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class GuideScreen extends StatefulWidget {
  final String userId;

  const GuideScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _GuideScreenState createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final listItem = [
      Item('Menu Utama', GuideMenuUtama()),
      Item('Menu Home', GuideMenuHome()),
      Item('Cek Birahi', GuideCekBirahi()),
      Item('Insiminasi Buatan', GuideIB()),
      Item('Periksa Kebuntingan', GuidePKB()),
      Item('Performa/Recording', GuidePerforma()),
      Item('Perlakuan Kesehatan', GuidePerlakuan()),
      Item('Panen', GuidePanen()),
    ];

    return Container(
      height: size.height,
      child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(Icons.search, color: kSecondaryColor),
              ),
              Expanded(
                  child: Container(
                child: Text('What are you looking for ?'),
              ))
            ],
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(8)),
        MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: listItem.length,
              itemBuilder: (context, index) {
                Item item = listItem[index];
                return GestureDetector(
                  onTap: () {
                    gotoAnotherPage(item.screen, context);
                  },
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(Icons.file_copy, color: kSecondaryColor),
                        ),
                        Expanded(
                            child: Container(
                          child:
                              Text(item.name, style: TextStyle(fontSize: 20)),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child:
                              Icon(Icons.chevron_right, color: kSecondaryColor),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
        SizedBox(height: getProportionateScreenHeight(80)),
      ])),
    );
  }

  void gotoAnotherPage(Widget landingPage, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return landingPage;
    })).then((value) => setState(() {}));
  }
}

class Item {
  final String name;
  final Widget screen;
  Item(this.name, this.screen);
}
