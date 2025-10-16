class ProductHelpers {
  static double calculateOfferPercentage(
    double totalPrice,
    double sellingPrice,
  ) {
    if (totalPrice <= 0 || sellingPrice < 0 || sellingPrice > totalPrice) {
      return 0.0;
    }
    double discount = totalPrice - sellingPrice;
    double percentage = (discount / totalPrice) * 100;
    return double.parse(percentage.toStringAsFixed(2)); // round to 2 decimals
  }
}
