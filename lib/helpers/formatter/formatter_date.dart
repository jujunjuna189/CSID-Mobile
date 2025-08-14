import 'package:intl/intl.dart';

class FormatterDate {
  FormatterDate._privateController();
  static final instance = FormatterDate._privateController();

  String getMonth({required String monthKey}) {
    // Mapping bulan
    Map<String, String> monthMap = {
      'January': 'Januari',
      'February': 'Februari',
      'March': 'Maret',
      'April': 'April',
      'May': 'Mei',
      'June': 'Juni',
      'July': 'Juli',
      'August': 'Agustus',
      'September': 'September',
      'October': 'Oktober',
      'November': 'November',
      'December': 'Desember',
    };

    return monthMap[monthKey] ?? "";
  }

  String getDay({required String dayKey}) {
// Mapping hari
    Map<String, String> dayMap = {
      'Monday': 'Senin',
      'Tuesday': 'Selasa',
      'Wednesday': 'Rabu',
      'Thursday': 'Kamis',
      'Friday': 'Jumat',
      'Saturday': 'Sabtu',
      'Sunday': 'Minggu',
    };

    return dayMap[dayKey] ?? "";
  }

  String formatV1(int expiredTime) {
    final date = DateTime.fromMillisecondsSinceEpoch(expiredTime * 1000);

    final engMonth = DateFormat('MMMM').format(date); // January
    final dayNumber = DateFormat('d').format(date); // 14
    final year = DateFormat('y').format(date); // 2025
    final time = DateFormat('HH:mm').format(date); // 21:45

    final indoMonth = getMonth(monthKey: engMonth);

    return '$dayNumber $indoMonth $year $time';
  }

  String formatNow() {
    final date = DateTime.now();

    final engMonth = DateFormat('MMMM').format(date); // January
    final dayNumber = DateFormat('d').format(date); // 14
    final year = DateFormat('y').format(date); // 2025

    final indoMonth = getMonth(monthKey: engMonth);

    return '$dayNumber $indoMonth $year';
  }
}
