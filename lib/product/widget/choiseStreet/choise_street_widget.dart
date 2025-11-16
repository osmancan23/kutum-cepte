import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/components/button/button.dart';
import 'package:kutum_cepte_app/core/components/svgPicture/svg_image.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/components/textFormField/text_form_field_widget.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';

class ChoiseStreetWidget extends StatelessWidget {
  const ChoiseStreetWidget({
    required this.textEditingController,
    required this.onTapSave,
    required this.streetList,
    required this.onTapDelete,
    super.key,
  });

  final TextEditingController textEditingController;
  final VoidCallback onTapSave;
  final List<String> streetList;
  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormFieldWidget(
              textEditingController: textEditingController,
              width: 260,
              hintText: 'Sokak Adı Giriniz',
            ),
            ButtonWidget(
              onTap: () {
                if (textEditingController.text.isEmpty) return;
                streetList.add(textEditingController.text);

                textEditingController.clear();
                onTapSave();
              },
              text: 'Ekle',
              width: 100,
              radius: 16,
              height: 50,
            ),
          ],
        ),
        ListView.builder(
          itemCount: streetList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: context.padding.low,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    streetList[index],
                    textStyle: context.general.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {
                      streetList.removeAt(index);
                      onTapDelete();
                    },
                    child: const SvgImageWidget(
                      icon: IconEnums.delete,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
