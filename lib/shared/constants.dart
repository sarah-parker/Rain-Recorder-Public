import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

const textInputDecoration = InputDecoration(
    fillColor: Color(0xFFE0F2F1),
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFE0F2F1)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF00695C)),
    ));

const MaterialColor mint = MaterialColor(_mintPrimaryValue, <int, Color>{
  50: Color(0xFFE8F6F1),
  100: Color(0xFFC5E9DC),
  200: Color(0xFF9FDAC4),
  300: Color(0xFF78CBAC),
  400: Color(0xFF5BBF9B),
  500: Color(_mintPrimaryValue),
  600: Color(0xFF38AD81),
  700: Color(0xFF30A476),
  800: Color(0xFF289C6C),
  900: Color(0xFF1B8C59),
});
const int _mintPrimaryValue = 0xFF3EB489;

const MaterialColor mintAccent = MaterialColor(_mintAccentValue, <int, Color>{
  100: Color(0xFFC5FFE3),
  200: Color(_mintAccentValue),
  400: Color(0xFF5FFFB2),
  700: Color(0xFF46FFA6),
});
const int _mintAccentValue = 0xFF92FFCB;

final themeData = ThemeData(
    primarySwatch: mint,
    primaryColorLight: mintAccent,
    primaryColorDark: mint[800],
    brightness: Brightness.light,
    hoverColor: Colors.blue,
    backgroundColor: mint[50],
    textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.black)));

final calendarStyle = CalendarStyle(
  cellAlignment: Alignment.topRight,
  cellMargin: const EdgeInsets.all(1.0),
  defaultDecoration: BoxDecoration(shape: BoxShape.rectangle, color: mint[50]),
  selectedDecoration:
      const BoxDecoration(shape: BoxShape.rectangle, color: mint),
  todayDecoration: BoxDecoration(shape: BoxShape.rectangle, color: mint[100]),
  weekendDecoration: BoxDecoration(shape: BoxShape.rectangle, color: mint[50]),
  outsideDecoration:
      BoxDecoration(shape: BoxShape.rectangle, color: Colors.grey[100]),
  todayTextStyle: const TextStyle(color: mint),
  // markerSizeScale: 0.9,
  // markerDecoration:
  //     const BoxDecoration(color: null, shape: BoxShape.rectangle),
);

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text(""), value: ""),
    const DropdownMenuItem(child: Text("By Month"), value: "month"),
    const DropdownMenuItem(child: Text("By Year"), value: "year"),
    const DropdownMenuItem(child: Text("Compare Years"), value: "compare"),
    const DropdownMenuItem(child: Text("All Years"), value: "all-years"),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get monthDropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text(""), value: ""),
    const DropdownMenuItem(child: Text("Jan"), value: "Jan"),
    const DropdownMenuItem(child: Text("Feb"), value: "Feb"),
    const DropdownMenuItem(child: Text("Mar"), value: "Mar"),
    const DropdownMenuItem(child: Text("Apr"), value: "Apr"),
    const DropdownMenuItem(child: Text("May"), value: "May"),
    const DropdownMenuItem(child: Text("Jun"), value: "Jun"),
    const DropdownMenuItem(child: Text("Jul"), value: "Jul"),
    const DropdownMenuItem(child: Text("Aug"), value: "Aug"),
    const DropdownMenuItem(child: Text("Sep"), value: "Sep"),
    const DropdownMenuItem(child: Text("Oct"), value: "Oct"),
    const DropdownMenuItem(child: Text("Nov"), value: "Nov"),
    const DropdownMenuItem(child: Text("Dec"), value: "Dec"),
  ];
  return menuItems;
}
