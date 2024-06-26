import 'package:book_store/bloc/audio_bloc/audio_bloc.dart';
import 'package:book_store/bloc/register_bloc/register_bloc.dart';
import 'package:book_store/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:book_store/data/local/my_pref.dart';
import 'package:book_store/data/model/book_data.dart';
import 'package:book_store/presentation/screens/book_viewer/audio_screen.dart';
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
      home: BlocProvider(
        create: (context) => AudioBloc(),
        child: AudioScreen(bookData: BookData(
          authorName: "Ahmad Lutfiy Qozonchi",
          bookName: "Umar ibn Hattob",
          category: "",
          imgUrl: "https://firebasestorage.googleapis.com/v0/b/bookappflutter-5860d.appspot.com/o/images%2Fumar.jpg?alt=media&token=6cfd8a4b-043b-47bd-bcda-4823f669945b",
          audioUrl: "https://firebasestorage.googleapis.com/v0/b/bookappflutter-5860d.appspot.com/o/audios%2Fbook_3_Umar.mp3?alt=media&token=e95e7367-a04a-430d-bad4-e980c24f3692",
          pdfUrl: ""
        ),),
      )
      // _pref.getString(ConstantKeys.registerStatus) == "0"
      //     ? BlocProvider(
      //         create: (context) => RegisterBloc(),
      //         child: const RegisterScreen(),
      //       )
      //     : BlocProvider(
      //         create: (context) => SignInBloc(),
      //         child: const SignInScreen(),
      //       ),
    );
  }
}
