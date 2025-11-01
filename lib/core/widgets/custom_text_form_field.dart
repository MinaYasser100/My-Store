import 'package:flutter/material.dart';
import 'package:my_store/core/model/text_field_model/text_field_model.dart';
import 'package:my_store/core/utils/colors.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({super.key, required this.textFieldModel});

  final TextFieldModel textFieldModel;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isObscured;

  @override
  void initState() {
    super.initState();
    isObscured = widget.textFieldModel.obscureText;
  }

  @override
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: widget.textFieldModel.controller.text,
      validator: widget.textFieldModel.validator,
      autovalidateMode: widget.textFieldModel.autovalidateMode,
      builder: (FormFieldState<String> fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: widget.textFieldModel.controller,
              cursorColor: ColorsTheme().primaryDark,
              onChanged: (v) => fieldState.didChange(v),
              obscureText: isObscured,
             
              keyboardType: widget.textFieldModel.keyboardType,
              autofocus: widget.textFieldModel.autofocus,
              focusNode: widget.textFieldModel.focusNode,
              onSubmitted: widget.textFieldModel.onFieldSubmitted,
              style: TextStyle(color: ColorsTheme().primaryDark, fontSize: 14),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                hintText: widget.textFieldModel.hintText,
                errorText: null,
                hintStyle: TextStyle(color: ColorsTheme().primaryLight),
                suffixIcon: widget.textFieldModel.obscureText
                    ? GestureDetector(
                        onTap: () {
                          isObscured = !isObscured;
                          setState(() {});
                        },
                        child: Icon(
                          isObscured
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: isObscured
                              ? ColorsTheme().primaryDark
                              : ColorsTheme().primaryLight,
                        ),
                      )
                    : null,
                border: _customOutlineInputBorder(),
                focusedBorder: _customOutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: ColorsTheme().primaryLight,
                    width: 1.5,
                  ),
                ),
              ),
            ),
            if (fieldState.errorText != null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 6.0),
                child: Text(
                  fieldState.errorText!,
                  style: TextStyle(color: Colors.red[700], fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }

  OutlineInputBorder _customOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: ColorsTheme().primaryDark, width: 2),
    );
  }
}
