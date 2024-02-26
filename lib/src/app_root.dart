import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanly/bloc/login/login_cubit.dart';
import 'package:scanly/bloc/register/register_cubit.dart';
import 'package:scanly/bloc/user/user_cubit.dart';
import 'package:scanly/screens/start_screen.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => RegisterCubit()),
          BlocProvider(create: (context) => LoginCubit()..loadUserEmailPassword()),
          BlocProvider(create: (context) => UserCubit())
        ],
        child: const MaterialApp(debugShowCheckedModeBanner: false,
          home: StartScreen(),
        ));
  }
}
