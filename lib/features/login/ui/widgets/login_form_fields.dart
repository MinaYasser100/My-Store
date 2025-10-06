import 'package:flutter/material.dart';
import 'package:my_store/core/model/text_field_model/text_field_model.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/core/validation/validatoin.dart';
import 'package:my_store/core/widgets/custom_text_form_field.dart';

class LoginFormFields extends StatelessWidget {
  const LoginFormFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Welcome back",
            style: AppTextStyles.styleBold30sp(
              context,
            ).copyWith(color: ColorsTheme().primaryColor),
          ),
        ),
        Center(
          child: Text(
            'Sign in to your My Store account',
            style: AppTextStyles.styleBold16sp(
              context,
            ).copyWith(color: ColorsTheme().primaryLight),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'Email',
          style: AppTextStyles.styleBold16sp(
            context,
          ).copyWith(color: ColorsTheme().primaryColor),
        ),
        CustomTextFormField(
          textFieldModel: TextFieldModel(
            controller: emailController,
            hintText: "Enter your email",
            icon: Icons.email,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => Validatoin.emailValidation(value),
            autofocus: true,
            focusNode: emailFocusNode,
            onFieldSubmitted: (value) {
              emailFocusNode.unfocus();
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Password',
          style: AppTextStyles.styleBold16sp(
            context,
          ).copyWith(color: ColorsTheme().primaryColor),
        ),
        CustomTextFormField(
          textFieldModel: TextFieldModel(
            keyboardType: TextInputType.visiblePassword,
            controller: passwordController,
            labelText: "Password",
            hintText: "Enter your password",
            icon: Icons.lock,
            obscureText: true,
            validator: (value) => Validatoin.validatePassword(value),
            focusNode: passwordFocusNode,
            onFieldSubmitted: (value) {
              passwordFocusNode.unfocus();
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
