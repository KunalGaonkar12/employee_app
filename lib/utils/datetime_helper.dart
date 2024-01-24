class DateTimeHelper {
  static String formatDateTime(DateTime? dateToConvert) {
    if (dateToConvert == null) {
      return 'No Date';
    }
    final date = dateToConvert;
    final monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    final day = date.day;
    final month = monthNames[date.month - 1];
    final year = date.year;

    return '$day $month $year';
  }

  static DateTime? calculateDate(DateTime? fromDate, String condition) {
    final now = DateTime.now();
    final date = fromDate ?? DateTime.now();
    DateTime result;

    switch (condition) {
      case 'Today':
        result = DateTime(now.year, now.month, now.day);
        break;
      case 'Next Monday':
        result =
            date.add(Duration(days: (DateTime.monday - date.weekday + 7) % 7));
        break;
      case 'Next Tuesday':
        result =
            date.add(Duration(days: (DateTime.tuesday - date.weekday + 7) % 7));
        break;
      case 'After 1 Week':
        result = date.add(Duration(days: 7));
        break;
      default:
        return null;
    }

    return result;
  }

  static DateTime? parseDateString(String dateString) {
    // Define the month names
    final monthNames = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12,
    };

    final parts = dateString.split(' ');

    if (parts.length == 3 && monthNames.containsKey(parts[1])) {
      final day = int.tryParse(parts[0]);
      final month = monthNames[parts[1]];
      final year = int.tryParse(parts[2]);

      if (day != null && month != null && year != null) {
        return DateTime(year, month, day);
      }
    }

    return null;
  }

 static bool isDateRangeValid(DateTime fromDate, DateTime toDate) {
    return fromDate.isBefore(toDate) || fromDate.isAtSameMomentAs(toDate);
  }
}
