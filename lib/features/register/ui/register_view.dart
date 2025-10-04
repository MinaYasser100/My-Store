import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/dependency_injection/set_up_dependencies.dart';
import 'package:my_store/features/forgot_password/manager/autovalidate_mode/autovalidate_mode_cubit.dart';
import 'package:my_store/features/register/data/repo/register_repo_impl.dart';
import 'package:my_store/features/register/manager/register_cubit/register_cubit.dart';

import 'widgets/register_body_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  // Focus nodes
  late FocusNode firstNameFocusNode;
  late FocusNode lastNameFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode phoneFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode confirmPasswordFocusNode;

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    firstNameFocusNode = FocusNode();
    lastNameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    phoneFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AutovalidateModeCubit()),
        BlocProvider(
          create: (context) => RegisterCubit(getIt<RegisterRepoImpl>()),
        ),
      ],

      child: Scaffold(
        body: RegisterBodyView(
          formKey: _formKey,
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
      ),
    );
  }
}
