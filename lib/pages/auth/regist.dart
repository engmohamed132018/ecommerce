// ignore_for_file: must_be_immutable

import 'package:ecommerce/controller/contrroler_auth/auth.dart';
import 'package:ecommerce/pages/auth/login.dart';
import 'package:ecommerce/widgets/custome_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utilits/fonts.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custome_button.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  late AppFonts appFonts;
  final _formKey = GlobalKey<FormState>();
  late String name, email, password;
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
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                ),
              ),
            ),
            buildCantainerShadow(context),
          ],
        ),
      ),
    );
  }

  Container buildCantainerShadow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        gradient: LinearGradient(
          colors: [
            Colors.black12.withOpacity(0.004),
            Colors.black12.withOpacity(0.05),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      height: MediaQuery.of(context).size.height * .8,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .56,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: buildCard(context),
              ),
            ),
          ),
        ],
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
            const SizedBox(
              height: 40,
            ),
            buildNameTextField(),
            const SizedBox(
              height: 24,
            ),
            buildEmailTextField(),
            const SizedBox(
              height: 24,
            ),
            buildPasswordTextField(),
            const SizedBox(
              height: 24,
            ),
            const SizedBox(
              height: 40,
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
      text: 'SIGN UP',
      onClicked: () async {
        final valid = _formKey.currentState!.validate();
        if (valid) {
          try {
            _formKey.currentState!.save();
            Auth().registerByEmailAndPassword(
                email: email, password: password, name: name);

            Navigator.push(
                context, MaterialPageRoute(builder: (_) => LoginScreen()));
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              print('The password provided is too weak.');
            } else if (e.code == 'email-already-in-use') {
              debugPrint('The account already exists for that email.');
            }
          } catch (e) {
            debugPrint(e.toString());
          }
          // ignore: use_build_context_synchronously
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
          text: 'Sign Up',
        ),
      ],
    );
  }

  buildNameTextField() {
    return CustomeTextField(
      onSave: (value) => name = value,
      hintText: 'Mohamed abd ellah',
      borderColor: Colors.green,
      labelColor: Colors.grey,
      text: 'name',
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
      validate: (value) {
        if (value == null || value.isEmpty) {
          return 'please Enter your name!';
        } else {
          return null;
        }
      },
    );
  }
}
