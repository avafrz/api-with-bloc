import 'package:apiwithbloc/screens/phoneNumber_screen.dart';
import 'package:apiwithbloc/services/api_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'screens/code_screen.dart';
import 'screens/home_screen.dart';
import 'services/token_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TokenProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: 
          const PhoneNumberScreen(),
        
        // home: PhoneNumberScreen(),
        routes: {
          CodeScreen.routename: (ctx) => CodeScreen(),
           HomeScreen.routename : (ctx) => HomeScreen(),
        },
      ),
    );
  }
}
