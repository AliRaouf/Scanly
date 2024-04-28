import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scanly/bloc/api/api_cubit.dart';
import 'package:scanly/bloc/login/login_cubit.dart';
import 'package:scanly/bloc/register/register_cubit.dart';
import 'package:scanly/bloc/test/test_cubit.dart';
import 'package:scanly/bloc/textract/textract_cubit.dart';
import 'package:scanly/bloc/user/user_cubit.dart';
import 'package:scanly/generated/l10n.dart';
import 'package:scanly/screens/introduction_screen.dart';
import 'package:scanly/screens/splash_screen.dart';

class AppRoot extends StatefulWidget {
  final bool onboarding;
  const AppRoot({
    super.key,
    required this.onboarding,
  });

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => RegisterCubit()),
          BlocProvider(
              create: (context) => LoginCubit()..loadUserEmailPassword()),
          BlocProvider(create: (context) => UserCubit()),
          BlocProvider(create: (context) => TestCubit()),
          BlocProvider(create: (context) => TextractCubit()),
          BlocProvider(create: (context) => ApiCubit()),
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 800),
            splitScreenMode: false,
            useInheritedMediaQuery: true,
            ensureScreenSize: true,
            builder: (_, child) {
              return MaterialApp(
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                debugShowCheckedModeBanner: false,
                home: widget.onboarding ? SplashScreen() : IntroductionScreen(),
              );
            }));
  }
}
