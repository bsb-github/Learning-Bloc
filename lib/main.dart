// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

const names = [
  "GetX",
  "Provider",
  "Riverpod",
  "Bloc",
];

extension RandomElement<T> on Iterable<T> {
  T get randomElement => elementAt(Random().nextInt(length));
}

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);
  void pickRandomName() => emit(names.randomElement);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final NamesCubit _namesCubit;

  @override
  void initState() {
    // TODO: implement initState
    _namesCubit = NamesCubit();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _namesCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<String?>(
      stream: _namesCubit.stream,
      builder: (context, snapshot) {
        final button = TextButton(
            onPressed: () {
              _namesCubit.pickRandomName();
            },
            child: Text("Pick random name"));
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(snapshot.data.toString()),
              const SizedBox(
                height: 30,
              ),
              button,
            ],
          ),
        );
      },
    ));
  }
}
