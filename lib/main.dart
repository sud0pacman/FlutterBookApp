import 'package:book_store/bloc/register_bloc/register_bloc.dart';
import 'package:book_store/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:book_store/data/local/my_pref.dart';
import 'package:book_store/presentation/screens/register/register_screen.dart';
import 'package:book_store/presentation/screens/sign_in/sign_in_screen.dart';
import 'package:book_store/ui/theme/constant_keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final SharedPreferencesHelper _pref = SharedPreferencesHelper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
      _pref.getString(ConstantKeys.registerStatus) == "0"
          ? BlocProvider(
              create: (context) => RegisterBloc(),
              child: const RegisterScreen(),
            )
          : BlocProvider(
              create: (context) => SignInBloc(),
              child: const SignInScreen(),
            ),
    );
  }
}
