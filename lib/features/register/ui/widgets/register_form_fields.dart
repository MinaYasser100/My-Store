import 'package:flutter/material.dart';
import 'package:my_store/core/model/text_field_model/text_field_model.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/core/validation/validatoin.dart';
import 'package:my_store/core/widgets/custom_text_form_field.dart';

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
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                textFieldModel: TextFieldModel(
                  controller: firstNameController,
                  hintText: "John",
                  icon: Icons.person,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "First name is required";
                    }
                    return null;
                  },
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
              child: CustomTextFormField(
                textFieldModel: TextFieldModel(
                  controller: lastNameController,
                  hintText: "Deo",
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "First name is required";
                    }
                    return null;
                  },
                  autofocus: true,
                  focusNode: lastNameFocusNode,
                  onFieldSubmitted: (value) {
                    lastNameFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(emailFocusNode);
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        textTitle(context, "Email"),
        CustomTextFormField(
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
        textTitle(context, "Phone Number"),
        CustomTextFormField(
          textFieldModel: TextFieldModel(
            controller: phoneController,
            hintText: "+20 123 456 789",
            keyboardType: TextInputType.phone,
            validator: (value) => Validatoin.emailValidation(value),
            focusNode: phoneFocusNode,
            onFieldSubmitted: (value) {
              phoneFocusNode.unfocus();
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
          ),
        ),
        const SizedBox(height: 10),
        textTitle(context, "Password"),
        CustomTextFormField(
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
        textTitle(context, "Confirm Password"),
        CustomTextFormField(
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

  Padding textTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 4),
      child: Text(
        title,
        style: AppTextStyles.styleBold18sp(
          context,
        ).copyWith(color: ColorsTheme().primaryColor),
      ),
    );
  }
}
