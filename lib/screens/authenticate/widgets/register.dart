import 'package:flutter/material.dart';
import 'package:rain_recorder/services/auth.dart';
import 'package:rain_recorder/shared/constants.dart';
import 'package:rain_recorder/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: const Text('Sign up to Rain Recorder'),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: const Icon(Icons.person),
                  label: const Text('Sign In'),
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).colorScheme.onPrimary),
                )
              ],
            ),
            body: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                        ),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          validator: (val) => val!.length < 6
                              ? 'Enter a password 6+ chars long'
                              : null,
                          obscureText: true,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => loading = true);

                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);

                              if (result == null) {
                                setState(() {
                                  error = 'Please supply a valid email';
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: const Text('Register'),
                        ),
                        const Padding(padding: EdgeInsets.all(8.0)),
                        Text(
                          error,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ))),
          );
  }
}
