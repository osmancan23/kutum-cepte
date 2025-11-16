part of '../view/task_assignment_view.dart';

class _TimePickerWidget extends StatefulWidget {
  const _TimePickerWidget({required this.onChange, this.width = 180});
  final double width;
  final void Function(String?) onChange;
  @override
  _TimePickerDropdownState createState() => _TimePickerDropdownState();
}

class _TimePickerDropdownState extends State<_TimePickerWidget> {
  String _selectedTime = '-'; // Varsayılan başlangıç saati

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (Platform.isIOS) {
          await _timePickeriOS(context);
        } else {
          await _timePickerAndroid(context);
        }
      },
      child: Container(
        height: 56.h,
        width: widget.width.w,
        decoration: BoxDecoration(
          borderRadius: context.border.lowBorderRadius,
          color: context.general.colorScheme.primaryContainer,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              _selectedTime,
              textStyle: context.general.textTheme.bodySmall?.copyWith(fontSize: 14.sp),
            ),
            SvgPicture.asset(IconEnums.hour.svgPathIcon),
          ],
        ),
      ),
    );
  }

  Future<void> _timePickerAndroid(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 14, minute: 00),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime.format(context);
      });
      widget.onChange(_selectedTime);
    }
  }

  Future<dynamic> _timePickeriOS(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        width: 500,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          color: Colors.white,
        ),
        child: CupertinoTimerPicker(
          minuteInterval: 5,
          mode: CupertinoTimerPickerMode.hm,
          backgroundColor: Colors.transparent,
          onTimerDurationChanged: (value) {
            setState(() {
              _selectedTime = _formatDuration(value);
            });
            widget.onChange(_selectedTime);
          },
        ),
      ),
    );
  }

  // Saat ve dakikayı düzgün formatlamak için yardımcı fonksiyon
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitHours = twoDigits(duration.inHours);
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return '$twoDigitHours:$twoDigitMinutes';
  }
}
