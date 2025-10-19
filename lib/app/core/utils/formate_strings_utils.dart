class NumberFormatter {
  static String formatNumber(num number) {
    if (number >= 1000000000) {
      // Billions
      return '${(number / 1000000000).toStringAsFixed(number % 1000000000 == 0 ? 0 : 1)}B';
    } else if (number >= 1000000) {
      // Millions
      return '${(number / 1000000).toStringAsFixed(number % 1000000 == 0 ? 0 : 1)}M';
    } else if (number >= 1000) {
      // Thousands
      return '${(number / 1000).toStringAsFixed(number % 1000 == 0 ? 0 : 1)}K';
    } else {
      // Less than 1000
      return number.toStringAsFixed(0);
    }
  }
}
