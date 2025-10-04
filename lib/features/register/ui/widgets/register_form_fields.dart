import 'package:flutter/material.dart';
import 'package:my_store/core/model/text_field_model/text_field_model.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/core/validation/validatoin.dart';
import 'package:my_store/features/register/ui/widgets/register_field.dart';
import 'package:my_store/features/register/ui/widgets/register_name_widget.dart';

class RegisterFormFields extends StatelessWidget {
  const RegisterFormFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.confirmPasswordFocusNode,
    required this.firstNameController,
    required this.lastNameController,
    required this.firstNameFocusNode,
    required this.lastNameFocusNode,
    required this.phoneController,
    required this.phoneFocusNode,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;
  final FocusNode firstNameFocusNode;
  final FocusNode lastNameFocusNode;
  final FocusNode phoneFocusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Create account",
            style: AppTextStyles.styleBold28sp(context),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "Join My Store and start shopping. After registration, you'll need to sign in.",
          textAlign: TextAlign.center,
          style: AppTextStyles.styleRegular16sp(
            context,
          ).copyWith(color: ColorsTheme().primaryLight),
        ),
        const SizedBox(height: 30),

        // First & Last name side-by-side
        RegisterNameWidget(
          firstNameController: firstNameController,
          firstNameFocusNode: firstNameFocusNode,
          lastNameFocusNode: lastNameFocusNode,
          lastNameController: lastNameController,
          emailFocusNode: emailFocusNode,
        ),

        const SizedBox(height: 10),
        RegisterField(
          title: 'Email',
          textFieldModel: TextFieldModel(
            controller: emailController,
            hintText: "jhon@example.com",
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => Validatoin.emailValidation(value),
            focusNode: emailFocusNode,
            onFieldSubmitted: (value) {
              emailFocusNode.unfocus();
              FocusScope.of(context).requestFocus(phoneFocusNode);
            },
          ),
        ),

        const SizedBox(height: 10),
        RegisterField(
          title: 'Phone Number',
          textFieldModel: TextFieldModel(
            controller: phoneController,
            hintText: "012 2222 2222",
            keyboardType: TextInputType.phone,
            validator: (value) => Validatoin.validatePhone(value),
            focusNode: phoneFocusNode,
            onFieldSubmitted: (value) {
              phoneFocusNode.unfocus();
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
          ),
        ),

        const SizedBox(height: 10),
        RegisterField(
          title: 'Password',
          textFieldModel: TextFieldModel(
            keyboardType: TextInputType.visiblePassword,
            controller: passwordController,
            hintText: "Create a password",
            obscureText: true,
            validator: (value) => Validatoin.validatePassword(value),
            focusNode: passwordFocusNode,
            onFieldSubmitted: (value) {
              passwordFocusNode.unfocus();
              FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
            },
          ),
        ),

        const SizedBox(height: 10),
        RegisterField(
          title: 'Confirm Password',
          textFieldModel: TextFieldModel(
            keyboardType: TextInputType.visiblePassword,
            controller: confirmPasswordController,
            hintText: "Confirm your password",
            obscureText: true,
            validator: (value) => value != passwordController.text.trim()
                ? "Passwords do not match"
                : null,
            focusNode: confirmPasswordFocusNode,
            onFieldSubmitted: (value) {
              confirmPasswordFocusNode.unfocus();
            },
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
