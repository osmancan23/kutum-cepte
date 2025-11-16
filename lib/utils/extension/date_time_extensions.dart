extension DateTimeExtensions on DateTime {
  ///MARK: - Formatted Date Year-Month-Day
  String get formattedDate =>
      '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
}
