import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mbc_mobile/bloc/auth_bloc/authentication_bloc.dart';
import 'package:mbc_mobile/components/custom_surfix_icon.dart';
import 'package:mbc_mobile/components/default_button.dart';
import 'package:mbc_mobile/config/shared_info.dart';
import 'package:mbc_mobile/helper/keyboard.dart';
import 'package:mbc_mobile/screens/new_home_page/home_page.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class SignForm extends StatefulWidget {
  final AuthenticationBloc authenticationBloc;

  const SignForm({Key? key, required this.authenticationBloc})
      : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final _userEmail = TextEditingController();
  final _userPass = TextEditingController();

  bool remember = false;

  late SharedInfo _sharedInfo;

  String resToken = "";

  bool _passwordVisible = false;

  String? validatePass(value) {
    if (value.isEmpty) {
      return kPassNullError;
    } else if (value.length < 8) {
      return kShortPassError;
    } else {
      return null;
    }
  }

  String? validateEmail(value) {
    if (value.isEmpty) {
      return kEmailNullError;
    } else if (!emailValidatorRegExp.hasMatch(value)) {
      return kInvalidEmailError;
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _sharedInfo = SharedInfo();

    FirebaseMessaging.instance.getInitialMessage();
    getMessagingToken();
  }

  Future<String> getMessagingToken() async {
    String token = "";

    await FirebaseMessaging.instance
        .requestPermission()
        .timeout(Duration(seconds: 5))
        .then((value) {
      print(
          'SignForm.getMessagingToken() requestPermission result is ${value.authorizationStatus}');
    }).catchError((e) {
      print(
          'SignForm.getMessagingToken() requestPermission error: ${e.toString()}');
      EasyLoading.showError(e.toString());
    });

    await FirebaseMessaging.instance.getToken().then((value) {
      print(value);
      print(' SignForm.getMessagingToken() token is $value');
      token = value!;
      resToken = token;
    }).catchError((e) {
      print('SignForm.getMessagingToken() getToken error: $e');
      EasyLoading.showError(e.toString());
    });

    return token;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        print("State $state");
        if (state is AuthGetFailureState) {
          print("State ${state.error}");
          EasyLoading.dismiss();
          EasyLoading.showError(state.error);
        } else if (state is AuthGetSuccess) {
          EasyLoading.dismiss();
          print("State ${state.user.responsecode}");
          // ignore: unrelated_type_equality_checks
          if (state.user.responsecode == "1") {
            EasyLoading.showSuccess("Welcome");
            _sharedInfo.sharedLoginInfo(
                state.user.user!.id,
                state.user.user!.email,
                state.user.user!.name,
                state.user.user!.hakAkses);
            gotoAnotherPage(HomePage(
                userId: state.user.user!.id.toString(),
                bloc: widget.authenticationBloc,
                hakAkses: state.user.user!.hakAkses));
          } else {
            EasyLoading.showError(state.user.responsemsg);
          }
        } else if (state is AuthLoadingState ||
            state is AuthenticationInitialState) {
          EasyLoading.show(status: 'wait a second');
        } else if (state is AuthLoggedInState)
          gotoAnotherPage(HomePage(
              userId: state.userId.toString(),
              bloc: widget.authenticationBloc,
              hakAkses: state.hakAkses));
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _userEmail,
              validator: validateEmail,
              cursorColor: kSecondaryColor,
              decoration:
                  buildInputDecoration("assets/icons/User.svg", "Email"),
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            passwordField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // if all are valid then go to success screen

                  var email = _userEmail.text.trim();
                  var password = _userPass.text.trim();

                  KeyboardUtil.hideKeyboard(context);

                  print("Email $email, Password $password, token $resToken");

                  if (resToken != "") {
                    widget.authenticationBloc.add(LoginEvent(
                        email: email, password: password, token: resToken));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Wait until token generate')),
                    );
                  }
                }
              },
              child: DefaultButton(
                text: "Continue",
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField passwordField() {
    return TextFormField(
      controller: _userPass,
      validator: validatePass,
      cursorColor: kSecondaryColor,
      keyboardType: TextInputType.text,
      obscureText: !_passwordVisible, //This will obscure text dynamically
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: const TextStyle(color: Colors.black),

        hintText: 'Enter your password',
        // Here is key idea
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: kSecondaryColor,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),

        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.green, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: kSecondaryColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: kHintTextColor,
            width: 1,
          ),
        ),
      ),
    );
  }

  void gotoAnotherPage(Widget widget) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}
