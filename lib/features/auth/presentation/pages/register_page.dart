import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:messanger/features/auth/presentation/bloc/auth_event.dart';
import 'package:messanger/features/auth/presentation/bloc/auth_state.dart';
import 'package:messanger/features/auth/presentation/widgets/auth_button.dart';
import 'package:messanger/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:messanger/features/auth/presentation/widgets/login_prompt.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onRegister() {
    context.read<AuthBloc>().add(
          AuthRegisterRequested(
            username: _usernameController.text,
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                hint: "Your name",
                icon: Icons.person,
                controller: _usernameController,
                isPassword: false,
              ),
              const SizedBox(height: 20),

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
                    // После успешной регистрации можно отправить на login или сразу в чаты
                    Navigator.pushReplacementNamed(context, '/login');
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
                  return AuthButton(text: "Register", onPressed: _onRegister);
                },
              ),

              const SizedBox(height: 10),
              LoginPrompt(
                title: "Already have an account? ",
                subtitle: "Click here to login",
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
