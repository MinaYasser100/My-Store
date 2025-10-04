import 'package:flutter/material.dart';
import 'package:my_store/core/model/text_field_model/text_field_model.dart';
import 'package:my_store/features/register/ui/widgets/register_field.dart';

class RegisterNameWidget extends StatelessWidget {
  const RegisterNameWidget({
    super.key,
    required this.firstNameController,
    required this.firstNameFocusNode,
    required this.lastNameFocusNode,
    required this.lastNameController,
    required this.emailFocusNode,
  });

  final TextEditingController firstNameController;
  final FocusNode firstNameFocusNode;
  final FocusNode lastNameFocusNode;
  final TextEditingController lastNameController;
  final FocusNode emailFocusNode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RegisterField(
            title: 'First Name',
            textFieldModel: TextFieldModel(
              controller: firstNameController,
              hintText: "John",
              icon: Icons.person,
              obscureText: false,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) return "this is required";
                return null;
              },
              // Only the first field should autofocus
              autofocus: true,
              focusNode: firstNameFocusNode,
              onFieldSubmitted: (value) {
                firstNameFocusNode.unfocus();
                FocusScope.of(context).requestFocus(lastNameFocusNode);
              },
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: RegisterField(
            title: 'Last Name',
            textFieldModel: TextFieldModel(
              controller: lastNameController,
              hintText: "Deo",
              obscureText: false,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) return "this is required";
                return null;
              },
              autofocus: false,
              focusNode: lastNameFocusNode,
              onFieldSubmitted: (value) {
                lastNameFocusNode.unfocus();
                FocusScope.of(context).requestFocus(emailFocusNode);
              },
            ),
          ),
        ),
      ],
    );
  }
}
