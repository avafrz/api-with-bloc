import 'package:apiwithbloc/blocs/usersbloc/users_bloc.dart';
import 'package:apiwithbloc/blocs/usersbloc/users_event.dart';
import 'package:apiwithbloc/services/api_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../blocs/usersbloc/users_state.dart';
import '../model/data.dart';
import '../services/token_provider.dart';

class HomeScreen extends StatefulWidget {
  static const routename = '/home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool start = false;
  late TokenProvider tokenProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tokenProvider = context.read<TokenProvider>();
    context.read<TokenProvider>().init(context).then((value) {
      setState(() {
        start = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersBloc(context)..add(LoadUsersEvent()),
      child: !start
          ? Center()
          : Scaffold(body:
          BlocListener<UsersBloc, UsersState>(
            listener: (context, state) {
              if(state is UsersSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Load data')));
              }
            },
            child: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
              if (state is UsersSuccess) {
                Users users = state.users;

                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: ListView.builder(itemBuilder: (_, index) {
                    return Text(users.valueOrDefault.data[index].name);
                  }),
                );
              }
              return Container();
            })
          )
              ),
    );
  }
}
