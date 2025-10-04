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
  late FocusNode _focusNode;
  late bool _createdFocusNode;

  @override
  void initState() {
    super.initState();
    isObscured = widget.textFieldModel.obscureText;
    if (widget.textFieldModel.focusNode != null) {
      _focusNode = widget.textFieldModel.focusNode!;
      _createdFocusNode = false;
    } else {
      _focusNode = FocusNode();
      _createdFocusNode = true;
    }
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    // Rebuild when focus changes so the decoration (focused border) updates.
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (_createdFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = _focusNode.hasFocus;
    return Container(
      decoration: isFocused
          ? BoxDecoration(
              border: Border.all(
                color: ColorsTheme().primaryLight.withAlpha(
                  153,
                ), // Outer border color
                width: 2, // Wider outer border
              ),
              borderRadius: BorderRadius.circular(18),
            )
          : null,
      child: TextFormField(
        controller: widget.textFieldModel.controller,
        cursorColor: ColorsTheme().primaryDark,
        validator: widget.textFieldModel.validator,
        autovalidateMode: widget.textFieldModel.autovalidateMode,
        obscureText: isObscured,
        keyboardType: widget.textFieldModel.keyboardType,
        autofocus: widget.textFieldModel.autofocus,
        focusNode: _focusNode,
        onFieldSubmitted: widget.textFieldModel.onFieldSubmitted,
        style: TextStyle(color: ColorsTheme().primaryDark),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          hintText: widget.textFieldModel.hintText,
          errorText: widget.textFieldModel.errorText,
          hintStyle: TextStyle(color: ColorsTheme().primaryLight),
          labelStyle: TextStyle(color: ColorsTheme().primaryDark),
          suffixIcon: widget.textFieldModel.obscureText
              ? GestureDetector(
                  onTap: () {
                    isObscured = !isObscured;
                    setState(() {});
                  },
                  child: Icon(
                    isObscured
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: isObscured
                        ? ColorsTheme().primaryDark
                        : ColorsTheme().primaryLight,
                  ),
                )
              : null,
          border: InputBorder.none,
          focusedBorder: _customOutlineInputBorder(),
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  OutlineInputBorder _customOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: ColorsTheme().primaryDark),
    );
  }
}
