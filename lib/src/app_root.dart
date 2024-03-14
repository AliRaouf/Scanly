import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanly/bloc/login/login_cubit.dart';
import 'package:scanly/bloc/register/register_cubit.dart';
import 'package:scanly/bloc/test/test_cubit.dart';
import 'package:scanly/bloc/textract/textract_cubit.dart';
import 'package:scanly/bloc/user/user_cubit.dart';
import 'package:scanly/screens/splash_screen.dart';
import 'package:scanly/screens/start_screen.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => RegisterCubit()),
          BlocProvider(create: (context) => LoginCubit()..loadUserEmailPassword()),
          BlocProvider(create: (context) => UserCubit()),
          BlocProvider(create: (context) => TestCubit()),
          BlocProvider(create: (context) => TextractCubit()),

        ],
        child: const MaterialApp(debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ));
  }
}
