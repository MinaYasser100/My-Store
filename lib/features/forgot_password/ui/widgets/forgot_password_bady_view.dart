import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/model/text_field_model/text_field_model.dart';
import 'package:my_store/core/routing/routes.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/core/utils/show_top_toast.dart';
import 'package:my_store/core/validation/validatoin.dart';
import 'package:my_store/core/widgets/custom_text_form_field.dart';
import 'package:my_store/features/forgot_password/manager/autovalidate_mode/autovalidate_mode_cubit.dart';
import 'package:my_store/features/forgot_password/manager/cubit/forgot_password_cubit.dart';

class ForgotPasswordBadyView extends StatelessWidget {
  const ForgotPasswordBadyView({
    super.key,
    required this.emailController,
    required this.emailFocusNode,
    required this.formKey,
  });
  final TextEditingController emailController;
  final FocusNode emailFocusNode;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: BlocBuilder<AutovalidateModeCubit, AutovalidateModeState>(
        builder: (context, state) {
          return Form(
            key: formKey,
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Forgot Password',
                    style: AppTextStyles.styleBold24sp(
                      context,
                    ).copyWith(color: ColorsTheme().primaryDark),
                  ),

                  Text(
                    'If you have forgotten your password, you can reset it here. Please enter your email address and we will send you a link to reset your password.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.styleRegular16sp(
                      context,
                    ).copyWith(color: ColorsTheme().primaryLight),
                  ),

                  const SizedBox(height: 30),

                  CustomTextFormField(
                    textFieldModel: TextFieldModel(
                      controller: emailController,
                      labelText: "Email",
                      hintText: "username@gmail.com",
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => Validatoin.emailValidation(value),
                      autofocus: true,
                      focusNode: emailFocusNode,
                      onFieldSubmitted: (value) {
                        emailFocusNode.unfocus();
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                  BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                    listener: (context, state) {
                      if (state is ForgotPasswordError) {
                        showErrorToast(context, 'Error', state.error);
                      }
                      if (state is ForgotPasswordSuccess) {
                        showSuccessToast(
                          context,
                          'Success',
                          'Password Reset Link Sent Successfully',
                        );
                        context.go(Routes.loginView);
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsTheme().primaryDark,
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            context
                                .read<ForgotPasswordCubit>()
                                .sendPasswordResetEmail(
                                  email: emailController.text.trim(),
                                );
                          } else {
                            context
                                .read<AutovalidateModeCubit>()
                                .changeAutovalidateMode();
                          }
                        },
                        child: const Text('Reset Password'),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
