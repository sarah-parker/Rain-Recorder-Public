import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:rain_recorder/models/rain.dart';
import 'package:rain_recorder/screens/charts/charts/all_years.dart';
import 'package:rain_recorder/screens/charts/charts/compare_years.dart';
import 'package:rain_recorder/screens/charts/charts/single_month.dart';
import 'package:rain_recorder/screens/charts/charts/single_year.dart';
import 'package:rain_recorder/shared/constants.dart';

class Charts extends StatefulWidget {
  const Charts({Key? key}) : super(key: key);

  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  String? selectedValue = "";
  String? selectedYear = DateTime.now().year.toString();
  String? selectedYear2 = (DateTime.now().year - 1).toString();
  String? selectedYear3 = (DateTime.now().year - 2).toString();
  String? selectedMonth = "";
  List<Rain>? rain;

  @override
  Widget build(BuildContext context) {
    rain = Provider.of<List<Rain>?>(context);
    //selectedMonth = DateFormat('MMM').format(rain!.last.date);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (selectedValue!.isEmpty)
            const Text('Please select a graph to view'),
          DropdownButton(
              value: selectedValue,
              items: dropdownItems,
              onChanged: (String? value) {
                setState(() {
                  selectedValue = value;
                });
              }),
          _renderDates(),
          _renderChart(),
        ],
      ),
    );
  }

  _renderChart() {
    if (selectedValue == 'month' && selectedMonth!.isNotEmpty) {
      try {
        return Column(
          children: [
            Text(
              'Rainfall for $selectedMonth',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            ConstrainedBox(
                constraints: const BoxConstraints.expand(height: 500.0),
                child: SingleMonth(
                  selectedYear: selectedYear!,
                  selectedMonth: selectedMonth!,
                )),
          ],
        );
      } catch (e) {
        return Text("Unable to view graph, please try again");
      }
    } else if (selectedValue == 'year') {
      return Column(
        children: [
          Text(
            'Rainfall for $selectedYear',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          ConstrainedBox(
              constraints: const BoxConstraints.expand(height: 500.0),
              child: SingleYear(selectedYear: selectedYear!)),
        ],
      );
    } else if (selectedValue == 'compare') {
      return Column(
        children: [
          Text(
            'Comparison Rainfall per month',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          ConstrainedBox(
              constraints: const BoxConstraints.expand(height: 600.0),
              child: CompareYears(
                  selectedYear1: selectedYear!,
                  selectedYear2: selectedYear2!,
                  selectedYear3: selectedYear3)),
        ],
      );
    } else {
      return const Expanded(child: Text(''));
    }
  }

  _renderDates() {
    if (selectedValue == 'month') {
      return Flexible(
        child: Row(
          children: [
            DropdownButton(
                items: _availableYears(),
                value: selectedYear,
                onChanged: (String? value) {
                  setState(() {
                    selectedYear = value!;
                  });
                }),
            const Padding(padding: EdgeInsets.all(15.0)),
            DropdownButton(
                items: _availableMonths(),
                onChanged: (String? value) {
                  setState(() {
                    selectedMonth = value!;
                  });
                }),
          ],
        ),
      );
    } else if (selectedValue == 'year') {
      return Flexible(
        child: DropdownButton(
            items: _availableYears(),
            value: selectedYear,
            onChanged: (String? value) {
              setState(() {
                selectedYear = value!;
              });
            }),
      );
    } else if (selectedValue == 'compare') {
      return Flexible(
        child: Row(
          children: [
            DropdownButton(
                items: _availableYears(),
                value: selectedYear,
                onChanged: (String? value) {
                  if (value!.isNotEmpty) {
                    setState(() {
                      selectedYear = value;
                    });
                  }
                }),
            const Padding(padding: EdgeInsets.all(10.0)),
            DropdownButton(
                items: _availableYears(),
                value: selectedYear2,
                onChanged: (String? value) {
                  if (value!.isNotEmpty) {
                    setState(() {
                      selectedYear2 = value;
                    });
                  }
                }),
            const Padding(padding: EdgeInsets.all(10.0)),
            DropdownButton(
                items: _availableYears(),
                value: selectedYear3,
                onChanged: (String? value) {
                  setState(() {
                    selectedYear3 = value!;
                  });
                }),
          ],
        ),
      );
    } else if (selectedValue == 'all-years') {
      return Expanded(
        child: Column(
          children: [
            Text(
              'Rainfall per year',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const Expanded(child: AllYears()),
          ],
        ),
      );
    } else {
      return const Flexible(child: Text(''));
    }
  }

  List<DropdownMenuItem<String>> _availableYears() {
    List<DropdownMenuItem<String>> menuItems = [];
    Set<String> rainSet = {};

    for (var rainfall in rain!) {
      rainSet.add(rainfall.date.year.toString());
    }

    menuItems.add(const DropdownMenuItem(child: Text(""), value: ""));

    for (var year in rainSet) {
      menuItems.add(DropdownMenuItem(child: Text(year), value: year));
    }
    return menuItems;
  }

  List<DropdownMenuItem<String>> _availableMonths() {
    List<DropdownMenuItem<String>> menuItems = [];
    Set<String> rainSet = {};
    var monthlyRain =
        rain!.where((e) => e.date.year.toString() == selectedYear);

    for (var rainfall in monthlyRain) {
      rainSet.add(DateFormat('MMM').format(rainfall.date));
    }

    menuItems.add(const DropdownMenuItem(child: Text(""), value: ""));

    for (var month in rainSet) {
      menuItems.add(DropdownMenuItem(child: Text(month), value: month));
    }
    return menuItems;
  }
}
