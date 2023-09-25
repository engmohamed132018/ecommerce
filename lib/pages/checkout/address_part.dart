import 'package:ecommerce/pages/checkout/summer_part.dart';
import 'package:ecommerce/utilits/fonts.dart';
import 'package:ecommerce/widgets/custom_text.dart';
import 'package:ecommerce/widgets/custome_button.dart';
import 'package:ecommerce/widgets/custome_textfield.dart';
import 'package:flutter/material.dart';

import '../../widgets/custome_out_line_button.dart';

class AddressPart extends StatefulWidget {
  const AddressPart({super.key});

  @override
  State<AddressPart> createState() => _AddressPartState();
}

class _AddressPartState extends State<AddressPart> {
  AppFonts? appFonts;
  @override
  Widget build(BuildContext context) {
    appFonts = AppFonts(context: context);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomeText(
                    font: appFonts!.font14,
                    text: 'Billing address is the same as delivery address'),
                const SizedBox(
                  height: 24,
                ),
                buildAddressPartItem(
                  text: "streat2",
                  hintText: "21, Alex Davidson Avenue",
                ),
                const SizedBox(
                  height: 24,
                ),
                buildAddressPartItem(
                  text: "streat1",
                  hintText: "Opposite Omegatron, Vicent Quarters",
                ),
                const SizedBox(
                  height: 24,
                ),
                buildAddressPartItem(
                  text: "City",
                  hintText: "Victoria Island",
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 165,
                      child: buildAddressPartItem(
                        text: "State",
                        hintText: "Lagos State",
                      ),
                    ),
                    SizedBox(
                      width: 165,
                      child: buildAddressPartItem(
                        text: "Country",
                        hintText: "Nigeria",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              height: 50,
              child: CustomOutLineButton(
                onClicked: () {},
              ),
            ),
            CustomeButton(
              appFonts: appFonts!.font16,
              text: 'Next',
              size: const Size(150, 50),
              onClicked: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SummerPart()));
              },
            ),
          ],
        ),
      ],
    );
  }

  buildAddressPartItem({required String text, required String hintText}) {
    return CustomeTextField(
      borderColor: Colors.green,
      labelColor: Colors.grey,
      text: text,
      hintText: hintText,
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
    );
  }
}
