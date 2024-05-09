import 'package:firebase_core/firebase_core.dart';
import 'package:firelearn/blocssss/bloc/add_user_bloc.dart';
import 'package:firelearn/blocssss/imageadding/bloc/image_adding_bloc.dart';
import 'package:firelearn/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddUserBloc()),
        BlocProvider(
          create: (context) => ImageAddingBloc(),
          child: Container(),
        )
      ],
      child: MaterialApp(
        home: Home(),
      ),
    );
  }
}
