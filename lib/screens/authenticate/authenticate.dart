import 'package:flutter/material.dart';
import 'package:rain_recorder/screens/authenticate/widgets/register.dart';
import 'package:rain_recorder/screens/authenticate/widgets/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) return SignIn(toggleView: toggleView);
    return Register(toggleView: toggleView);
  }
}
