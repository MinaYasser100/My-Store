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

    // Use FormField so we can render the error text outside the decorated
    // container (below it) instead of letting InputDecoration draw it inside.
    return FormField<String>(
      initialValue: widget.textFieldModel.controller.text,
      validator: widget.textFieldModel.validator,
      autovalidateMode: widget.textFieldModel.autovalidateMode,
      builder: (FormFieldState<String> fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
              child: TextField(
                controller: widget.textFieldModel.controller,
                cursorColor: ColorsTheme().primaryDark,
                onChanged: (v) => fieldState.didChange(v),
                obscureText: isObscured,
                keyboardType: widget.textFieldModel.keyboardType,
                autofocus: widget.textFieldModel.autofocus,
                focusNode: _focusNode,
                onSubmitted: widget.textFieldModel.onFieldSubmitted,
                style: TextStyle(
                  color: ColorsTheme().primaryDark,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  hintText: widget.textFieldModel.hintText,
                  // Hide the internal error text so we can show it below the
                  // container instead.
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
            ),

            // Render validation message below the two borders (outside the
            // decorated container). We use the FormField's state to get the
            // current error text so it'll update when the form is validated.
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
      borderSide: BorderSide(color: ColorsTheme().primaryDark),
    );
  }
}
