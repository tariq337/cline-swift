import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:client_swift/Widgets/TextFieldWidget.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  FormWidget(
      {super.key,
      required this.ifremove,
      required this.remove,
      required this.locationEditing,
      required this.discrEditing,
      required this.nameEditing,
      required this.cachEditing,
      required this.onPressed,
      required this.phoneEditing});
  Function remove;
  bool ifremove;
  void Function()? onPressed;
  TextEditingController locationEditing;

  TextEditingController cachEditing;

  TextEditingController phoneEditing;

  TextEditingController nameEditing;

  TextEditingController discrEditing;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  bool paymethod = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      decoration: BoxDecoration(
          color: classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          if (widget.ifremove)
            Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                    onTap: () {
                      widget.remove();
                    },
                    child: const Icon(
                      Icons.clear,
                    ))),
          const SizedBox(height: 5),
          TextFieldWidget(
            color: Colors.green[50],
            circleBorder: true,
            text: language[modeControll.LanguageValue]["customerLocation"],
            validator: (String? v) {
              if (v == null || v.isEmpty) {
                return language[modeControll.LanguageValue]["authError"][0];
              }
              return null;
            },
            width: MediaQuery.of(context).size.width > 300
                ? 300
                : MediaQuery.of(context).size.width * .7,
            border: true,
            widget: IconButton(
                onPressed: widget.onPressed,
                icon: const Icon(Icons.map_outlined)),
            textInputType: TextInputType.number,
            textEditingController: widget.locationEditing,
          ),
          const SizedBox(height: 5),
          TextFieldWidget(
            border: true,
            circleBorder: true,
            color: Colors.green[50],
            validator: (String? v) {
              if (v == null || v.isEmpty) {
                return language[modeControll.LanguageValue]["authError"][0];
              }
              return null;
            },
            text: language[modeControll.LanguageValue]["Titeltable"][1],
            textInputType: TextInputType.name,
            textEditingController: widget.nameEditing,
          ),
          const SizedBox(height: 5),
          TextFieldWidget(
            border: true,
            circleBorder: true,
            color: Colors.green[50],
            validator: (String? v) {
              if (v == null || v.isEmpty) {
                return language[modeControll.LanguageValue]["authError"][0];
              }
              return null;
            },
            text: language[modeControll.LanguageValue]["auth"][9],
            textInputType: TextInputType.phone,
            textEditingController: widget.phoneEditing,
          ),
          const SizedBox(height: 5),
          TextFieldWidget(
            border: true,
            color: Colors.green[50],
            circleBorder: true,
            text: language[modeControll.LanguageValue]["descriptionLocation"],
            textInputType: TextInputType.multiline,
            length: 3,
            textEditingController: widget.discrEditing,
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 250,
            child: SwitchListTile.adaptive(
              value: paymethod,
              onChanged: (v) {
                setState(() {
                  paymethod = v;
                });
              },
              secondary: TextUnit.TextsubTitel(
                  text: language[modeControll.LanguageValue]["pay"]),
            ),
          ),
          const SizedBox(height: 5),
          if (!paymethod)
            TextUnit.Textsub(
                text: language[modeControll.LanguageValue]["cach"]),
          if (!paymethod)
            TextFieldWidget(
              border: true,
              color: Colors.green[50],
              circleBorder: true,
              validator: (String? v) {
                if (v == null || v.isEmpty) {
                  return language[modeControll.LanguageValue]["authError"][0];
                }
                return null;
              },
              text: language[modeControll.LanguageValue]["orderDetails"][11],
              width: MediaQuery.of(context).size.width > 250
                  ? 250
                  : MediaQuery.of(context).size.width * .6,
              textInputType: TextInputType.number,
              textEditingController: widget.cachEditing,
            ),
        ],
      ),
    );
  }
}
