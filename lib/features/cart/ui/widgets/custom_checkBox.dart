import 'package:flutter/material.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';

class CustomCheckbox extends FormField<bool> {
  CustomCheckbox({
    super.key,
    required String label,
    required ValueChanged<bool?> onChanged,
    bool initialValue = false,
    FormFieldValidator<bool>? validator,
  }) : super(
         initialValue: initialValue,
         validator: validator,
         builder: (FormFieldState<bool> state) {
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                 children: [
                   Checkbox(
                     value: state.value ?? false,
                     onChanged: (val) {
                       state.didChange(val);
                       onChanged(val);
                     },
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(4),
                     ),
                   ),
                   Expanded(
                     child: Text(
                       label,
                       style: AppTextStyles.styleRegular16sp(
                         state.context,
                       ).copyWith(color: ColorsTheme().softBlue),
                     ),
                   ),
                 ],
               ),
               if (state.hasError)
                 Padding(
                   padding: const EdgeInsets.only(left: 12.0, top: 4),
                   child: Text(
                     state.errorText!,
                     style: const TextStyle(color: Colors.red, fontSize: 12),
                   ),
                 ),
             ],
           );
         },
       );
}
