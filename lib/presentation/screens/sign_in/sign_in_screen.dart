import 'package:book_store/bloc/home_bloc/home_bloc.dart';
import 'package:book_store/presentation/screens/home/home_screen.dart';
import 'package:book_store/ui/components/components.dart';
import 'package:book_store/ui/theme/light_colors.dart';
import 'package:book_store/ui/theme/main_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/sign_in_bloc/sign_in_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController(text: "assalomalaykum14@gmail.com");
  final TextEditingController _passwordController1 = TextEditingController(text: "mm1111.");


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.signed) {
          // Navigate to HomeScreen only if HomeBloc is provided above
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => HomeBloc(), // Provide HomeBloc here
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) => const HomeScreen(),
                ),
              ),
            ),
                (route) => false,
          );
        }
        if (state.back) {
          Navigator.pop(context, true);
        }
        if (state.toast.isNotEmpty) {
          myToast(state.toast);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        Image.asset(
                          MainImages.back,
                          height: 24,
                          width: 24,
                          color: LightColors.grey,
                        ),

                        const SizedBox(width: 15,),

                        const BoldText(text: "Back"),
                      ],
                    ),

                    const SizedBox(height: 24,),

                    Image.asset(
                      MainImages.logo,
                      height: 100,
                      width: 100,
                    ),

                    const SizedBox(height: 20,),

                    const BoldText(
                      text: "Create an Account",
                      fontSize: 24,
                      color: Colors.black,
                    ),

                    const SizedBox(height: 30,),

                    const BoldText(
                      text: "Sign In to continue",
                      fontSize: 20,
                    ),

                    const SizedBox(height: 40,),

                    CustomTextField(controller: _emailController),
                    const SizedBox(height: 15,),
                    CustomPasswordTextField(myController: _passwordController1),
                    const SizedBox(height: 25,),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: RegularText(
                        text: "Forget Password?",
                        color: LightColors.primary,
                      ),
                    ),

                    const SizedBox(height: 40,),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MyMainButton(
                            text: "SIGN IN",
                            onClick: () {
                              context.read<SignInBloc>().add(ClickSignInEvent(
                                  mail: _emailController.text, password: _passwordController1.text
                              ));
                            },
                          ),
                          const SizedBox(height: 40,),
                          const RegularText(text: "or sign in using",),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              registerButtons(MainImages.google),
                              const SizedBox(width: 15,),
                              registerButtons(MainImages.facebook)
                            ],
                          ),
                          const SizedBox(height: 30,),
                          TextWithSpan(
                            mainText: "Don't have an account? ",
                            innerText: "Register",
                            onTap: () {

                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget registerButtons(String img) {
    return Image.asset(
      img,
      height: 36,
      width: 36,
    );
  }
}
