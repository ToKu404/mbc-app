import 'package:flutter/material.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [kSecondaryColor, kPrimaryColor],
            )),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
