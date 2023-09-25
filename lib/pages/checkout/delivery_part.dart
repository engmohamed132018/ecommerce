import 'package:ecommerce/controller/cart_index_provider.dart';
import 'package:ecommerce/pages/checkout/summer_part.dart';
import 'package:ecommerce/widgets/custom_text.dart';
import 'package:ecommerce/widgets/custome_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utilits/fonts.dart';

class DeliveryPart extends StatefulWidget {
  DeliveryPart({
    super.key,
  });

  @override
  State<DeliveryPart> createState() => _DeliveryPartState();
}

class _DeliveryPartState extends State<DeliveryPart> {
  var vgroubValue;

  AppFonts? appFonts;

  @override
  Widget build(BuildContext context) {
    appFonts = AppFonts(context: context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        buildRadioListTile(
          value: 0,
          text: "Standard Delivery",
          subText: "Order will be delivered between 3 - 5 business days",
        ),
        const SizedBox(
          height: 24,
        ),
        buildRadioListTile(
            value: 1,
            text: 'Next Day Delivery',
            subText:
                "Place your order before 6pm and your items will be delivered the next day"),
        const SizedBox(
          height: 24,
        ),
        buildRadioListTile(
            value: 2,
            text: "Nominated Delivery",
            subText:
                "Pick a particular date from the calendar and order will be delivered on selected date"),
        Spacer(),
        Align(
          alignment: Alignment.bottomRight,
          child: CustomeButton(
            appFonts: appFonts!.font16,
            text: 'Next',
            onClicked: () {
              final index = context.read<IndexProvider>().index;
              if (index == 0) {
                context.read<IndexProvider>().changeIndex(1);
              } else {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SummerPart()));
              }
            },
            size: Size(150, 50),
          ),
        ),
      ],
    );
  }

  buildRadioListTile(
      {required int value, required String text, required String subText}) {
    return RadioListTile(
      activeColor: Colors.green,
      controlAffinity: ListTileControlAffinity.trailing,
      value: value,
      groupValue: vgroubValue,
      onChanged: (value) => setState(() {
        vgroubValue = value;
      }),
      title: CustomeText(
        font: appFonts!.font18,
        text: text,
        fontWeight: FontWeight.bold,
      ),
      subtitle: CustomeText(
        font: appFonts!.font14,
        text: subText,
      ),
    );
  }
}
