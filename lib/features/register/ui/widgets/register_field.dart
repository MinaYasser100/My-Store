import 'package:flutter/material.dart';
import 'package:my_store/core/model/text_field_model/text_field_model.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/core/widgets/custom_text_form_field.dart';

class RegisterField extends StatelessWidget {
  const RegisterField({
    super.key,
    required this.title,
    required this.textFieldModel,
  });

  final String title;
  final TextFieldModel textFieldModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 0),
          child: Text(
            title,
            style: AppTextStyles.styleBold16sp(
              context,
            ).copyWith(color: ColorsTheme().primaryColor),
          ),
        ),
        const SizedBox(height: 6),
        CustomTextFormField(textFieldModel: textFieldModel),
      ],
    );
  }
}
