import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/common/load_status.dart';
import 'package:money_manager/models/login.dart';
import 'package:money_manager/repositories/api.dart';
import 'package:money_manager/widgets/common_widgets/noti_bar.dart';
import 'package:money_manager/widgets/main_app.dart';
import 'package:money_manager/widgets/screens/login/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login_screen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<Api>()),
      child: Page(),
    );
  }
}

class Page extends StatelessWidget {
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            height: 200,
            child: const Text(
              'Winter .',
              style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
            ),
          ),
          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if(state.loadStatus == LoadStatus.Error) {
                ScaffoldMessenger.of(context).showSnackBar(notiBar('Login Error', true));
              } else if(state.loadStatus == LoadStatus.Done) {
                Navigator.of(context).pushReplacementNamed(MainApp.routeName, );
              }
            },
            builder: (context, state) {
              return Form(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Username'),
                      onChanged: (value) => _username = value,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      onChanged: (value) => _password = value,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black.withOpacity(.8)),
                            onPressed: () {
                              context.read<LoginCubit>().checkLogin(Login(username: _username, password: _password));
                            },
                            child:
                            state.loadStatus == LoadStatus.Loading ?
                                const Center(child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),)
                            :
                            const Text(
                              'L O G I N',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            )))
                  ],
                ),
              ));
            },
          )
        ],
      ),
    );
  }
}
