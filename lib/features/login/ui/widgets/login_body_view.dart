import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/routing/routes.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/features/forgot_password/manager/autovalidate_mode/autovalidate_mode_cubit.dart';
import 'package:my_store/features/login/manager/cubit/login_cubit.dart';
import 'package:my_store/features/login/ui/widgets/login_form_fields.dart';
import 'package:my_store/features/login/ui/widgets/login_submit_button.dart';

import 'custom_dont_account.dart';
import 'custom_login_auth_button_bloc.dart';
import 'login_error_widget.dart';

class LoginBodyView extends StatelessWidget {
  const LoginBodyView({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.fromVerifyEmail,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final bool fromVerifyEmail;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocBuilder<AutovalidateModeCubit, AutovalidateModeState>(
            builder: (context, state) {
              return Form(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginFormFields(
                        emailController: emailController,
                        passwordController: passwordController,
                        emailFocusNode: emailFocusNode,
                        passwordFocusNode: passwordFocusNode,
                        fromVerifyEmail: fromVerifyEmail,
                      ),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          if (state is LoginError) {
                            return LoginErrorWidget(error: state.error);
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              context.push(Routes.forgotPasswordView);
                            },
                            child: Text(
                              "Forgot password?",
                              style: AppTextStyles.styleBold16sp(context),
                            ),
                          ),
                        ],
                      ),
                      LoginSubmitButton(
                        formKey: _formKey,
                        emailController: emailController,
                        passwordController: passwordController,
                      ),
                      const SizedBox(height: 16),
                      CustomGoogleLoginBloc(),
                      const SizedBox(height: 16),
                      CustomDontAccount(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
