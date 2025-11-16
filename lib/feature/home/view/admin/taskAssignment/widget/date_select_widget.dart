import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';

class DateSelectWidget extends StatefulWidget {
  const DateSelectWidget({required this.onChange, this.width, super.key, this.initialDate});
  final double? width;
  final void Function(DateTime?) onChange;
  final DateTime? initialDate;

  @override
  State<DateSelectWidget> createState() => _BirthdaySelectWidgetState();
}

class _BirthdaySelectWidgetState extends State<DateSelectWidget> {
  DateTime? _selectedDate;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (Platform.isIOS) {
          await _datePickeriOS(context);
        } else {
          await _datePickerAndroid(context);
        }
      },
      child: Container(
        width: (widget.width ?? 380).w,
        height: 56.h,
        decoration: BoxDecoration(
          borderRadius: context.border.lowBorderRadius,
          color: context.general.colorScheme.primaryContainer,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                _selectedDate != null ? _handleDateText() : 'Tarih Seçiniz',
                textStyle: context.general.textTheme.bodySmall?.copyWith(
                  color: _selectedDate != null
                      ? context.general.colorScheme.onPrimary
                      : context.general.colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SvgPicture.asset(IconEnums.calendar.svgPathIcon),
            ],
          ),
        ),
      ),
    );
  }

  String _handleDateText() {
    final date = DateFormat('dd/MM/yyyy').format(_selectedDate!);
    return date;
  }

  Future<dynamic> _datePickeriOS(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        width: 500,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          color: Colors.white,
        ),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          backgroundColor: Colors.transparent,
          onDateTimeChanged: (value) {
            _selectedDate = value;
            setState(() {});
            widget.onChange(_selectedDate);
          },
        ),
      ),
    );
  }

  Future<dynamic> _datePickerAndroid(BuildContext context) async {
    await showDatePicker(
      context: context,
      firstDate: widget.initialDate ?? DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      helpText: 'Tarih Seç',
      cancelText: 'İptal',
      confirmText: 'Onayla',
      fieldLabelText: 'Tarih Seç',
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: const Locale('tr', 'TR'),
    ).then((value) {
      _selectedDate = value;
      setState(() {});
      widget.onChange(_selectedDate);
    });
  }
}
