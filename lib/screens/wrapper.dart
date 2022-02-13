import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rain_recorder/models/user.dart';
import 'package:rain_recorder/screens/authenticate/authenticate.dart';
import 'package:rain_recorder/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
