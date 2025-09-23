import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/core/di.dart';
import 'package:messanger/core/theme.dart';
import 'package:messanger/features/auth/presentation/pages/login_page.dart';
import 'package:messanger/features/auth/presentation/pages/register_page.dart';
import 'package:messanger/message_page.dart';

void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DI.provideAuthBloc(),
        ),
      ],
      child: MaterialApp(
        title: "Messenger App",
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/register',
        routes: {
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
          '/messagePage': (_) => const MessagePage(),
        },
      ),
    );
  }
}
