import 'package:flutter/material.dart';
import 'package:rain_recorder/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:rain_recorder/services/auth.dart';
import 'package:rain_recorder/shared/constants.dart';

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Rain Recorder';
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      catchError: (_, __) => null,
      child: MaterialApp(
          title: title,
          theme: themeData,
          debugShowCheckedModeBanner: false,
          home: const Wrapper()),
    );
  }
}
