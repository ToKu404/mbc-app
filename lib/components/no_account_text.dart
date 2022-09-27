import 'package:flutter/material.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';


class NoAccountText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        Text(
          "Sign Up",
          style: TextStyle(
              fontSize: getProportionateScreenWidth(16),
              color: kSecondaryColor),
        ),
      ],
    );
  }
}
