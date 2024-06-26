import 'package:book_store/presentation/screens/home/home_screen.dart';
import 'package:book_store/presentation/screens/sign_in/sign_in_screen.dart';
import 'package:book_store/ui/components/components.dart';
import 'package:book_store/ui/theme/light_colors.dart';
import 'package:book_store/ui/theme/main_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/home_bloc/home_bloc.dart';
import '../../../bloc/register_bloc/register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if(state.back) Navigator.pop(context, true);
        if(state.toast.isNotEmpty) myToast(state.toast);
        if(state.signIn) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
        }
        if(state.registered) {
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
                      text: "Register to continue",
                      fontSize: 20,
                    ),

                    const SizedBox(height: 40,),

                    CustomTextField(controller: _emailController),
                    const SizedBox(height: 15,),
                    CustomPasswordTextField(myController: _passwordController1),
                    const SizedBox(height: 15,),
                    CustomPasswordTextField(myController: _passwordController2,
                      hint: "Retype Password",),

                    const SizedBox(height: 40,),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MyMainButton(
                            text: "REGISTER",
                            onClick:  () {
                              context.read<RegisterBloc>().add(
                                  ClickRegisterEvent(
                                    mail: _emailController.text,
                                    password: _passwordController1.text
                                  )
                              );
                            },
                          ),
                          const SizedBox(height: 40,),
                          const RegularText(text: "or register using",),
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
                            mainText: "Already have an account? ",
                            innerText: "Sign In",
                            onTap: () {
                              context.read<RegisterBloc>().add(SignInEvent());
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
