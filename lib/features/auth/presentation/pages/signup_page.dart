import 'dart:developer';

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      );
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //formKey.currentState!.validate();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              AuthField(
                hintText: 'Name',
                controller: nameController,
              ),
              const SizedBox(
                height: 15,
              ),
              AuthField(
                hintText: 'Email',
                controller: emailController,
              ),
              const SizedBox(
                height: 15,
              ),
              AuthField(
                hintText: 'Password',
                controller: passwordController,
                isObscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              AuthGradientButton(
                buttonText: "Sign In",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(AuthSignUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        name: nameController.text.trim()));
                    log('signup called');
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, LoginPage.route());
                },
                child: RichText(
                    text: TextSpan(
                        children: [
                      TextSpan(
                          text: 'Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold))
                    ],
                        text: 'Don\'t have an account? ',
                        style: Theme.of(context).textTheme.titleMedium)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
