import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class DatePopup {
  const DatePopup({Key? key});

  Future<DateTime?> setDate(BuildContext context, DateTime selectedDay) async {
    return await showMonthPicker(
      context: context,
      initialDate: selectedDay,
    );
  }
}
