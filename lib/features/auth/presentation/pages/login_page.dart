import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:messanger/features/auth/presentation/bloc/auth_event.dart';
import 'package:messanger/features/auth/presentation/bloc/auth_state.dart';
import 'package:messanger/features/auth/presentation/widgets/auth_button.dart';
import 'package:messanger/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:messanger/features/auth/presentation/widgets/login_prompt.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    context.read<AuthBloc>().add(
          AuthLoginRequested(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthInputField(
                hint: "Your email",
                icon: Icons.email_outlined,
                controller: _emailController,
                isPassword: false,
              ),
              const SizedBox(height: 20),
              AuthInputField(
                hint: "Your password",
                icon: Icons.lock_outline,
                controller: _passwordController,
                isPassword: true,
              ),
              const SizedBox(height: 20),

              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthAuthenticated) {
                    Navigator.pushReplacementNamed(context, '/messagePage');
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return AuthButton(text: 'Login', onPressed: _onLogin);
                },
              ),

              const SizedBox(height: 10),
              LoginPrompt(
                title: "Don't have an account? ",
                subtitle: "Click here to register",
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
