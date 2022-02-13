import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rain_recorder/models/rain.dart';
import 'package:intl/intl.dart';

class SingleMonth extends StatelessWidget {
  final List<Series>? seriesList;
  final bool? animate;
  final String selectedYear;
  final String selectedMonth;

  const SingleMonth(
      {Key? key,
      this.seriesList,
      this.animate = true,
      required this.selectedYear,
      required this.selectedMonth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return BarChart(
        _addDataForSelectedMonth(context, selectedYear, selectedMonth),
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
        defaultInteractions: false,
      );
    } catch (e) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0),
        child: Text("Unable to view graph, please try again"),
      );
    }
  }

  static List<Series<Rain, String>> _addDataForSelectedMonth(
      BuildContext context, String selectedYear, String selectedMonth) {
    List<Rain> monthlyRain = Provider.of<List<Rain>?>(context)!
        .where((e) =>
            e.date.year.toString() == selectedYear &&
            DateFormat('MMM').format(e.date) == selectedMonth)
        .map((e) => Rain(amount: e.amount, date: e.date))
        .toList();

    var lengthOfMonth = DateUtils.getDaysInMonth(
        int.parse(selectedYear), monthlyRain.first.date.month);

    if (monthlyRain.isEmpty) throw Exception;

    List<Rain> data = [];
    for (var i = 1; i < lengthOfMonth + 1; i++) {
      Rain currentMonth = Rain(
          amount: monthlyRain
              .where((element) => element.date.day == i)
              .fold(0, (rainfall, element) => rainfall + element.amount),
          date: DateTime(
              int.parse(selectedYear), monthlyRain.first.date.month, i));
      data.add(currentMonth);
    }

    return [
      Series<Rain, String>(
        displayName: 'Rainfall for $selectedMonth $selectedYear',
        id: 'month',
        domainFn: (Rain rain, _) {
          return DateFormat('dd').format(rain.date);
        },
        measureFn: (Rain rain, _) => rain.amount,
        data: data,
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        labelAccessorFn: (Rain rain, _) {
          return rain.amount > 0 ? '${rain.amount.toString()} mm' : '';
        },
      )
    ];
  }
}
