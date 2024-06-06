import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/blocs/bloc_observer.dart';
import 'package:money_manager/blocs/main/main_cubit.dart';
import 'package:money_manager/main_routes.dart';
import 'package:money_manager/repositories/api.dart';
import 'package:money_manager/repositories/api_impl.dart';
import 'package:money_manager/repositories/log.dart';
import 'package:money_manager/repositories/log_impl.dart';
import 'package:money_manager/widgets/screens/login/login_screen.dart';

void main() {
  Log log = LogImpl();
  Bloc.observer = SimpleBlocObserver(log);
  runApp(RepositoryProvider<Log>.value(
      value: log,
      child: const Repository()));
}

class Repository extends StatelessWidget {
  const Repository({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Api>(
      create: (context) => ApiImpl(context.read<Log>()),
      child: const Provider(),
    );
  }
}

class Provider extends StatelessWidget {
  const Provider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return MaterialApp(
          darkTheme: ThemeData.dark(),
          theme: ThemeData.light(),
          themeMode: state.isLightTheme ? ThemeMode.light : ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: mainRoute,
          initialRoute: LoginScreen.routeName,
        );
      }
    );
  }
}