import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/dependency_injection/set_up_dependencies.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/features/forgot_password/manager/autovalidate_mode/autovalidate_mode_cubit.dart';

import '../data/repo/forgot_password_repo_impl.dart';
import '../manager/cubit/forgot_password_cubit.dart';
import 'widgets/forgot_password_bady_view.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController emailController;
  late final GlobalKey<FormState> formKey;
  late FocusNode emailFocusNode;

  @override
  void initState() {
    emailController = TextEditingController();
    formKey = GlobalKey<FormState>();
    emailFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AutovalidateModeCubit()),
        BlocProvider(
          create: (context) =>
              ForgotPasswordCubit(getIt<ForgotPasswordRepoImpl>()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
          backgroundColor: ColorsTheme().whiteColor,
          foregroundColor: ColorsTheme().primaryDark,
        ),
        body: Stack(
          children: [
            ForgotPasswordBadyView(
              emailController: emailController,
              emailFocusNode: emailFocusNode,
              formKey: formKey,
            ),
          ],
        ),
      ),
    );
  }
}
