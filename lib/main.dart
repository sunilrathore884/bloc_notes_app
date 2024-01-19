import 'package:bloc_notes_app/Bloc/Notes_Bloc.dart';
import 'package:bloc_notes_app/Database/DbHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Scrren/NotesApp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>NotesBloc(dbHelper: DbHelper.instance),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
      
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NotesApp(),
      ),
    );
  }
}

