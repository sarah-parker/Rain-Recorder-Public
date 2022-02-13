import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rain_recorder/models/rain.dart';
import 'package:rain_recorder/models/rain_month.dart';
import 'package:intl/intl.dart';

class SingleYear extends StatelessWidget {
  final List<Series>? seriesList;
  final bool? animate;
  final String selectedYear;

  const SingleYear(
      {Key? key,
      this.seriesList,
      this.animate = true,
      required this.selectedYear})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return BarChart(
        _addDataForSelectedYear(context, selectedYear),
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

  static List<Series<RainMonth, String>> _addDataForSelectedYear(
      BuildContext context, String selectedYear) {
    List<RainMonth> monthlyRain = Provider.of<List<Rain>?>(context)!
        .where((e) => e.date.year.toString() == selectedYear)
        .map((e) => RainMonth(amount: e.amount, month: e.date.month))
        .toList();

    List<RainMonth> data = [];
    for (var i = 1; i < 13; i++) {
      RainMonth currentMonth = RainMonth(
          amount: monthlyRain
              .where((element) => element.month == i)
              .fold(0, (rainfall, element) => rainfall + element.amount),
          month: i);
      data.add(currentMonth);
    }

    return [
      Series<RainMonth, String>(
        displayName: 'Rainfall for $selectedYear',
        id: 'year',
        domainFn: (RainMonth rain, _) {
          return DateFormat('MMM').format(DateTime(2022, rain.month, 1));
        },
        measureFn: (RainMonth rain, _) => rain.amount,
        data: data,
        colorFn: (_, __) => MaterialPalette.purple.shadeDefault,
        labelAccessorFn: (RainMonth rain, _) {
          return rain.amount > 0 ? '${rain.amount.toString()} mm' : '';
        },
      )
    ];
  }
}
