import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rain_recorder/models/rain.dart';
import 'package:rain_recorder/models/rain_month.dart';
import 'package:intl/intl.dart';

class CompareYears extends StatelessWidget {
  final List<Series>? seriesList;
  final bool? animate;
  final String selectedYear1;
  final String selectedYear2;
  final String? selectedYear3;

  const CompareYears(
      {Key? key,
      this.seriesList,
      this.animate = true,
      required this.selectedYear1,
      required this.selectedYear2,
      this.selectedYear3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return BarChart(
        _addDataForSelectedYear(
            context, selectedYear1, selectedYear2, selectedYear3),
        animate: animate,
        vertical: false,
        barRendererDecorator: BarLabelDecorator<String>(
          labelAnchor: BarLabelAnchor.middle,
          labelPosition: BarLabelPosition.auto,
        ),
        behaviors: [
          SlidingViewport(),
          PanAndZoomBehavior(),
          SeriesLegend(),
        ],
        defaultInteractions: false,
        barGroupingType: BarGroupingType.grouped,
      );
    } catch (e) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0),
        child: Text("Unable to view graph, please try again"),
      );
    }
  }

  List<Series<RainMonth, String>> _addDataForSelectedYear(BuildContext context,
      String selectedYear1, String selectedYear2, String? selectedYear3) {
    List<Rain> rain = Provider.of<List<Rain>?>(context)!;

    return [
      Series<RainMonth, String>(
        displayName: selectedYear1,
        id: selectedYear1,
        domainFn: (RainMonth rain, _) {
          return DateFormat('MMM').format(DateTime(2022, rain.month, 1));
        },
        measureFn: (RainMonth rain, _) => rain.amount,
        data: _getDataForYear(rain, selectedYear1),
        colorFn: (_, __) => MaterialPalette.purple.shadeDefault,
        labelAccessorFn: (RainMonth rain, _) {
          return rain.amount > 0 ? '${rain.amount.toString()} mm' : '';
        },
      ),
      Series<RainMonth, String>(
        displayName: selectedYear2,
        id: selectedYear2,
        domainFn: (RainMonth rain, _) {
          return DateFormat('MMM').format(DateTime(2022, rain.month, 1));
        },
        measureFn: (RainMonth rain, _) => rain.amount,
        data: _getDataForYear(rain, selectedYear2),
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        labelAccessorFn: (RainMonth rain, _) {
          return rain.amount > 0 ? '${rain.amount.toString()} mm' : '';
        },
      ),
      if (selectedYear3 != null)
        Series<RainMonth, String>(
          displayName: selectedYear2,
          id: selectedYear2,
          domainFn: (RainMonth rain, _) {
            return DateFormat('MMM').format(DateTime(2022, rain.month, 1));
          },
          measureFn: (RainMonth rain, _) => rain.amount,
          data: _getDataForYear(rain, selectedYear3),
          colorFn: (_, __) => MaterialPalette.green.shadeDefault,
          labelAccessorFn: (RainMonth rain, _) {
            return rain.amount > 0 ? '${rain.amount.toString()} mm' : '';
          },
        ),
    ];
  }

  List<RainMonth> _getDataForYear(List<Rain> rain, String selectedYear) {
    List<RainMonth> monthlyRain = rain
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

    return data;
  }
}
