import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rain_recorder/models/observation.dart';
import 'package:rain_recorder/models/rain.dart';
import 'package:rain_recorder/models/user.dart';
import 'package:rain_recorder/screens/calendar.dart/widgets/date_popup.dart';
import 'package:rain_recorder/screens/calendar.dart/widgets/observation_card.dart';
import 'package:rain_recorder/screens/calendar.dart/widgets/rain_data.dart';
import 'package:rain_recorder/screens/calendar.dart/widgets/rainfall_popup.dart';
import 'package:rain_recorder/services/database.dart';
import 'package:rain_recorder/services/weather_station.dart';
import 'package:rain_recorder/shared/constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _Calendar();
}

class _Calendar extends State<Calendar> {
  final Map<DateTime, List<Rain>> _selectedRain = {};

  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  List<Rain> _getRainFromDay(DateTime date) {
    return _selectedRain[date] ?? [];
  }

  _setRainfall(List<Rain>? rain) async {
    showDialog(
        context: context,
        builder: (context) => RainfallPopup(
              selectedDay: _selectedDay!,
              existingRainfall: existingRainfall(_selectedDay!, rain),
            ));
  }

  _setDate() async {
    DatePopup datePopup = const DatePopup();
    DateTime? newDate =
        await datePopup.setDate(context, _selectedDay ?? _focusedDay);
    if (newDate != null) {
      setState(() {
        _selectedDay = newDate;
        _focusedDay = newDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final rain = Provider.of<List<Rain>?>(context);
    final WeatherStation weatherStation = WeatherStation();
    final user = Provider.of<User>(context);

    return FutureBuilder(
        future: weatherStation.getCurrentObservations(),
        builder: (BuildContext context, AsyncSnapshot<Observations> snapshot) {
          Observations observation = Observations();
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            observation = snapshot.data!;

            if (observation.metric?.precipTotal != null &&
                observation.metric!.precipTotal! > 0.0) {
              DatabaseService(user.uid).updateRainData(
                  double.parse(
                      observation.metric!.precipTotal!.toStringAsFixed(2)),
                  DateTime(
                      observation.obsTimeLocal!.year,
                      observation.obsTimeLocal!.month,
                      observation.obsTimeLocal!.day));
            }
          }
          return Column(
            children: [
              Card(
                child: TableCalendar(
                    firstDay: DateTime(2000),
                    lastDay: DateTime(2050),
                    focusedDay: _focusedDay,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                      _setRainfall(rain);
                    },
                    calendarBuilders: CalendarBuilders(
                      headerTitleBuilder: (context, day) {
                        return Row(
                          children: [
                            GestureDetector(
                                onTap: _setDate,
                                child: Text(DateFormat('MMMM yyyy')
                                    .format(_focusedDay))),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _focusedDay = DateTime.now();
                                  });
                                },
                                icon: const Icon(Icons.today)),
                            const Spacer(),
                            Text("${rainfallForMonth(_focusedDay, rain)}")
                          ],
                        );
                      },
                      markerBuilder: (context, day, events) {
                        return allRainfall(rain, day);
                      },
                    ),
                    eventLoader: _getRainFromDay,
                    pageJumpingEnabled: true,
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                    calendarFormat: CalendarFormat.month,
                    headerStyle: const HeaderStyle(formatButtonVisible: false),
                    calendarStyle: calendarStyle),
              ),
              Padding(padding: EdgeInsets.all(15.0)),
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData)
                ObservationCard(
                  observation: observation,
                  focusedDay: _focusedDay,
                  yearlyRainfall: rainfallForYear(_focusedDay, rain),
                ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ElevatedButton(
                        onPressed: () {
                          updateHistoricalObservations(weatherStation, user);
                        },
                        child: Text('Update rainfall')),
                  )
                ],
              )
            ],
          );
        });
  }
}
