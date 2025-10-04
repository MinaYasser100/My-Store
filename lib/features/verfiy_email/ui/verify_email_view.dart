import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/dependency_injection/set_up_dependencies.dart';
import 'package:my_store/core/routing/routes.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/core/utils/show_top_toast.dart';
import 'package:my_store/features/verfiy_email/data/repo/verify_email_repo_impl.dart';
import 'package:my_store/features/verfiy_email/manager/cubit/verify_email_cubit.dart';

import 'widgets/custom_verify_error_state.dart';
import 'widgets/custom_verify_waiting_state.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyEmailCubit(getIt<VerifyEmailRepoImpl>())
        ..checkEmailVerification()
        ..startVerificationCheck(),
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<VerifyEmailCubit, VerifyEmailState>(
            listener: (context, state) {
              if (state is VerifyEmailSuccess) {
                Future.delayed(const Duration(seconds: 2), () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showSuccessToast(context, 'Success', 'Email verified!');
                    context.go(Routes.loginView);
                  });
                });
              }
            },
            child: BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
              builder: (context, state) {
                if (state is VerifyEmailLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is VerifyEmailSuccess) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorsTheme().grayColor),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified,
                            color: ColorsTheme().primaryDark,
                            size: 80,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Email verified!\nRedirecting...',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.styleMedium18sp(
                              context,
                            ).copyWith(color: ColorsTheme().primaryLight),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is VerifyEmailWaiting) {
                  return CustomVerifyWaitingState(message: state.message);
                } else if (state is VerifyEmailError) {
                  return CustomVerifyErrorState(error: state.error);
                }
                return const Center(child: Text('Verify Email View'));
              },
            ),
          ),
        ),
      ),
    );
  }
}
