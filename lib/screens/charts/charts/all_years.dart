import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rain_recorder/models/rain.dart';
import 'package:intl/intl.dart';
import 'package:rain_recorder/models/rain_year.dart';

class AllYears extends StatelessWidget {
  final List<Series>? seriesList;
  final bool? animate;

  const AllYears({Key? key, this.seriesList, this.animate = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return BarChart(
        _addDataAllYears(context),
        animate: animate,
        vertical: false,
        barRendererDecorator: BarLabelDecorator<String>(
          labelAnchor: BarLabelAnchor.middle,
          labelPosition: BarLabelPosition.auto,
        ),
        behaviors: [
          SlidingViewport(),
          PanAndZoomBehavior(),
        ],
        // domainAxis: OrdinalAxisSpec(),
        defaultInteractions: false,
      );
    } catch (e) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0),
        child: Text("Unable to view graph, please try again"),
      );
    }
  }

  static List<Series<RainYear, String>> _addDataAllYears(BuildContext context) {
    // final data = Provider.of<List<Rain>?>(context);
    List<RainYear> yearlyRain = Provider.of<List<Rain>?>(context)!
        .map((e) => RainYear(amount: e.amount, year: e.date.year))
        .toList();

    List<RainYear> data = [];
    Set map = {};
    for (var year in yearlyRain) {
      map.add(year.year);
    }
    map.toList();

    for (var year in map) {
      RainYear currentMonth = RainYear(
          amount: yearlyRain
              .where((element) => element.year == year)
              .fold(0, (rainfall, element) => rainfall + element.amount),
          year: year);
      data.add(currentMonth);
    }

    return [
      Series<RainYear, String>(
        displayName: 'Rainfall per year',
        id: 'all-years',
        domainFn: (RainYear rain, _) => rain.year.toString(),
        measureFn: (RainYear rain, _) => rain.amount,
        data: data,
        colorFn: (_, __) => MaterialPalette.green.shadeDefault,
        labelAccessorFn: (RainYear rain, _) {
          return rain.amount > 0 ? '${rain.amount.toString()} mm' : '';
        },
      )
    ];
  }
}
