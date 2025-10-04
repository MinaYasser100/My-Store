import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/dependency_injection/set_up_dependencies.dart';
import 'package:my_store/features/forgot_password/manager/autovalidate_mode/autovalidate_mode_cubit.dart';
import 'package:my_store/features/login/data/repo/login_repo_impl.dart';
import 'package:my_store/features/login/manager/cubit/login_cubit.dart';
import 'package:my_store/features/login/ui/widgets/login_body_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AutovalidateModeCubit()),
        BlocProvider(create: (context) => LoginCubit(getIt<LoginRepoImpl>())),
      ],
      child: Scaffold(
        body: LoginBodyView(
          formKey: _formKey,
          emailController: emailController,
          passwordController: passwordController,
          emailFocusNode: emailFocusNode,
          passwordFocusNode: passwordFocusNode,
        ),
      ),
    );
  }
}
