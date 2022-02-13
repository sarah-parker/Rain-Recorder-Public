import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rain_recorder/models/rain.dart';
import 'package:rain_recorder/models/user.dart';
import 'package:rain_recorder/screens/calendar.dart/calendar.dart';
import 'package:rain_recorder/screens/charts/charts.dart';
import 'package:rain_recorder/screens/import_export/import_export.dart';
import 'package:rain_recorder/services/auth.dart';
import 'package:rain_recorder/services/database.dart';
import 'package:rain_recorder/shared/constants.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return StreamProvider<List<Rain>?>.value(
        value: DatabaseService(user!.uid).rainfall,
        catchError: (_, __) {
          print('error in home');
        },
        updateShouldNotify: (previous, current) => true,
        initialData: null,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primaryVariant,
              leading: const Icon(Icons.water),
              title: const Text('Rain Recorder '),
              actions: [
                TextButton.icon(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  icon: const Icon(Icons.person),
                  label: const Text('Logout'),
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).colorScheme.onPrimary),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: _tabBar.preferredSize,
                child: ColoredBox(
                    color: Theme.of(context).colorScheme.primary,
                    child: _tabBar),
              ),
            ),
            body: const TabBarView(children: [
              Padding(padding: EdgeInsets.all(8.0), child: Calendar()),
              Padding(padding: EdgeInsets.all(8.0), child: Charts()),
              Padding(padding: EdgeInsets.all(8.0), child: ImportExport()),
            ]),
          ),
        ));
  }
}

TabBar get _tabBar => const TabBar(
      indicator: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: mintAccent),
      tabs: [
        Tab(
          icon: Icon(Icons.calendar_today_rounded),
        ),
        Tab(
          icon: Icon(Icons.bar_chart_sharp),
        ),
        Tab(
          icon: Icon(Icons.import_export),
        ),
      ],
    );
