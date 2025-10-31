import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_store/core/caching/hive/user_hive_helper.dart';
import 'package:my_store/core/caching/shared/shared_perf_helper.dart';
import 'package:my_store/core/dependency_injection/set_up_dependencies.dart';
import 'package:my_store/core/routing/app_router.dart';
import 'package:my_store/core/theme/theme_cubit/theme_cubit.dart';
import 'package:my_store/core/utils/theme_data_func.dart';
import 'firebase_options.dart';
import 'features/profile/ui/personal_info_screen.dart';
import 'features/profile/ui/profile_screen.dart';
import 'features/profile/ui/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await UserHiveHelper.init();
  // Ensure SharedPreferences is initialized before routing checks
  await SharedPrefHelper.instance.init();
  setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return ScreenUtilInit(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: themeDataFunc(isDark: state is ThemeDark),
              darkTheme: themeDataFunc(isDark: true),
              themeMode: state is ThemeDark ? ThemeMode.dark : ThemeMode.light,
              routerConfig: AppRouter.router,
            ),
          );
        },
      ),
    );
  }
}
