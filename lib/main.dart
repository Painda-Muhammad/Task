import 'package:app_desk_task/bloc/hospital/hospital_bloc.dart';
import 'package:app_desk_task/firebase_options.dart';
import 'package:app_desk_task/repositories/check_in_repository.dart';
import 'package:app_desk_task/repositories/event_repository.dart';
import 'package:app_desk_task/screens/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HospitalBloc>(
      create: (context) => HospitalBloc(
        eventRepository: EventRepository(),
        checkInRepository: CheckInRepository(),
      )..add(LoadEvents()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const EventScreen(),
      ),
    );
  }
}
