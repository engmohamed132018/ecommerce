// ignore_for_file: must_be_immutable

import 'package:ecommerce/controller/contrroler_auth/auth.dart';
import 'package:ecommerce/main_nav_bar.dart';
import 'package:ecommerce/utilits/fonts.dart';
import 'package:ecommerce/widgets/custome_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_text.dart';
import '../../widgets/custome_button.dart';
import '../../widgets/custome_social_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'regist.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  late AppFonts appFonts;
  final _formKey = GlobalKey<FormState>();
  late String email, password;
  @override
  Widget build(BuildContext context) {
    appFonts = AppFonts(context: context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                gradient: LinearGradient(colors: [
                  Colors.black12.withOpacity(0.004),
                  Colors.black12.withOpacity(0.05),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              height: MediaQuery.of(context).size.height * .8,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .49,
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: buildCard(context),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomeText(font: appFonts.font18, text: '-OR-'),
                  buildfacebutton(),
                  const SizedBox(
                    height: 24,
                  ),
                  builGmailButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            CustomeText(
              font: appFonts.font14,
              text: 'Sign in to Continue',
              color: const Color.fromARGB(255, 172, 171, 171),
            ),
            const SizedBox(
              height: 40,
            ),
            buildEmailTextField(),
            const SizedBox(
              height: 24,
            ),
            buildPasswordTextField(),
            const SizedBox(
              height: 24,
            ),
            Align(
              alignment: Alignment.centerRight,
              child:
                  CustomeText(font: appFonts.font18, text: 'forget password?'),
            ),
            const SizedBox(
              height: 24,
            ),
            buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return CustomeButton(
      appFonts: appFonts.font14,
      text: 'SIGN IN',
      onClicked: () async {
        final valid = _formKey.currentState!.validate();
        if (valid) {
          _formKey.currentState!.save();
          try {
            final data = await Auth()
                .loginByEmailAndPassword(email: email, password: password);
            if (data.isEmpty) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MainBar()));
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(data)));
            }
          } catch (e) {
            debugPrint(e.toString());
          }
        }
      },
    );
  }

  CustomeTextField buildPasswordTextField() {
    return CustomeTextField(
      onSave: (value) => password = value,
      isHide: true,
      hintText: '...........',
      borderColor: Colors.green,
      labelColor: Colors.grey,
      text: 'password',
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
      validate: (value) {
        if (value != null && value.length < 6) {
          return 'password must be great than 6 letter?';
        } else {
          return null;
        }
      },
    );
  }

  CustomeTextField buildEmailTextField() {
    return CustomeTextField(
      onSave: (value) => email = value,
      hintText: 'Example.123@gmail.com',
      borderColor: Colors.green,
      text: 'Email',
      labelColor: Colors.grey,
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
      validate: (value) {
        final exp = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
        if (!exp.hasMatch(value!)) {
          return 'Enter correct Email?';
        } else {
          return null;
        }
      },
    );
  }

  Row _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // mainAxisSize: MainAxisSize.min,
      children: [
        CustomeText(
          font: appFonts.font30,
          fontWeight: FontWeight.bold,
          text: 'Welcome,',
        ),
        Builder(builder: (context) {
          return TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SignUpScreen()));
              },
              child: CustomeText(
                text: 'Sign',
                font: appFonts.font18,
                color: const Color.fromARGB(255, 89, 193, 92),
                fontWeight: FontWeight.bold,
              ));
        }),
      ],
    );
  }

  Widget buildfacebutton() {
    return CustomeSocialButton(
      appFonts: appFonts.font14,
      text: 'Sign In with Facebook',
      imgurl: 'assets/icons/ic3.png',
    );
  }

  builGmailButton() {
    return CustomeSocialButton(
      appFonts: appFonts.font14,
      text: 'Sign In with Google',
      imgurl: 'assets/icons/ic8.png',
      onclicked: () async {
        try {
          GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
          GoogleSignInAuthentication? gAuth = await gUser!.authentication;
          final credential = GoogleAuthProvider.credential(
              accessToken: gAuth.accessToken, idToken: gAuth.idToken);
          final user =
              await FirebaseAuth.instance.signInWithCredential(credential);
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );
  }
}
