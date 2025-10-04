import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/features/verfiy_email/manager/cubit/verify_email_cubit.dart';

class CustomVerifyWaitingState extends StatelessWidget {
  const CustomVerifyWaitingState({super.key, this.message});
  final String? message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                'Waiting for Verification',
                style: AppTextStyles.styleBold24sp(
                  context,
                ).copyWith(color: ColorsTheme().primaryDark),
              ),
              const SizedBox(height: 20),
              Icon(
                Icons.email_outlined,
                size: 80,
                color: ColorsTheme().primaryDark,
              ),
              const SizedBox(height: 20),
              Text(
                message ??
                    'Please verify your email via the link sent to your inbox.',
                textAlign: TextAlign.center,
                style: AppTextStyles.styleMedium20sp(
                  context,
                ).copyWith(color: ColorsTheme().primaryLight),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () =>
                    context.read<VerifyEmailCubit>().resendVerificationEmail(),
                icon: const Icon(Icons.refresh),
                label: const Text('Resend Verification Email'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
