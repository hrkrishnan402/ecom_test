import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event.dart';
import 'blocs/auth/auth_state.dart';
import 'blocs/cart/cart_bloc.dart';
import 'blocs/menu/menu_bloc.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/menu_repository.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/login_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              repository: RepositoryProvider.of<AuthRepository>(context),
            )..add(AuthCheckRequested()),
          ),
          BlocProvider<MenuBloc>(
            create: (_) => MenuBloc(repository: MenuRepository()),
          ),
          BlocProvider<CartBloc>(
            create: (_) => CartBloc(),
          ),
        ],
        child: MaterialApp(
          title: AppStrings.appTitle,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return const HomeScreen();
              }
              if (state is Unauthenticated || state is AuthFailure) {
                return const LoginScreen();
              }
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }
}
