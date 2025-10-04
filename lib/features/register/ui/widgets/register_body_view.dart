import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/features/forgot_password/manager/autovalidate_mode/autovalidate_mode_cubit.dart';
import 'package:my_store/features/register/ui/widgets/register_form_fields.dart';

import 'have_account_widget.dart';
import 'register_submit_button.dart';

class RegisterBodyView extends StatelessWidget {
  const RegisterBodyView({
    super.key,
    required GlobalKey<FormState> formKey,
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
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;
  final FocusNode firstNameFocusNode;
  final FocusNode lastNameFocusNode;
  final TextEditingController phoneController;
  final FocusNode phoneFocusNode;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: BlocBuilder<AutovalidateModeCubit, AutovalidateModeState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Form(
                key: _formKey,
                autovalidateMode: context
                    .read<AutovalidateModeCubit>()
                    .autovalidateMode,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorsTheme().grayColor),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      RegisterFormFields(
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                        emailFocusNode: emailFocusNode,
                        passwordFocusNode: passwordFocusNode,
                        confirmPasswordFocusNode: confirmPasswordFocusNode,
                        firstNameController: firstNameController,
                        lastNameController: lastNameController,
                        firstNameFocusNode: firstNameFocusNode,
                        lastNameFocusNode: lastNameFocusNode,
                        phoneController: phoneController,
                        phoneFocusNode: phoneFocusNode,
                      ),
                      RegisterSubmitButton(
                        formKey: _formKey,
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                        phoneController: phoneController,
                        firstNameController: firstNameController,
                        lastNameController: lastNameController,
                      ),
                      HaveAccountWidget(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
