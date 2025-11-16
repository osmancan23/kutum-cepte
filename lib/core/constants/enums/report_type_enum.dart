enum ReportTypeEnum {
  daily(value: 'DAILY'),
  weekly(value: 'WEEKLY'),
  yearly(value: 'YEARLY');

  const ReportTypeEnum({required this.value});

  final String value;
}
