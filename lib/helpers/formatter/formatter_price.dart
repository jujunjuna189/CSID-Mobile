class FormatterPrice {
  FormatterPrice._privateController();
  static final instance = FormatterPrice._privateController();

  String formatToK(int value) {
    if (value >= 1000) {
      double divided = value / 1000;
      // Hilangkan ".0" kalau bulat
      return divided % 1 == 0 ? '${divided.toInt()}K' : '${divided.toStringAsFixed(1)}K';
    }
    return value.toString();
  }

  String formatCurrency(num value) {
    String s = value.toStringAsFixed(0);
    final regex = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return s.replaceAllMapped(regex, (match) => '.');
  }
}
