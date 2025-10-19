import 'dart:math';

import 'package:html_unescape/html_unescape.dart';

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

  static double getPercentageAmount(double totalAmount, double percentage) {
    if (totalAmount <= 0 || percentage < 0) return 0.0;

    double percentageAmount = (totalAmount * percentage) / 100;
    return double.parse(percentageAmount.toStringAsFixed(1));
  }

  static String extractTextWithEntities(String htmlString) {
    final regex = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
    String plainText = htmlString.replaceAll(regex, '').trim();
    return HtmlUnescape().convert(plainText);
  }

  static double ratingToPercentage(double rating) {
    const double maxRating = 5.0;
    double percentage = (rating / maxRating) * 100;
    return double.parse(percentage.toStringAsFixed(2));
  }

  static Map<int, double> generateRealisticDistribution(
    double averageRating, {
    double stdDev = 1.0,
  }) {
    if (averageRating < 1.0 || averageRating > 5.0) {
      return {};
    }

    // 1. Calculate unnormalized weights for each star (1 through 5)
    final Map<int, double> unnormalizedWeights = {};
    double totalWeight = 0.0;

    for (int star = 1; star <= 5; star++) {
      // Normal Distribution Probability Density Function (PDF) simplified:
      // P(x) = exp( -0.5 * ((x - mean) / stdDev)^2 )

      // x = star rating, mean = averageRating
      double zScore = (star - averageRating) / stdDev;

      // Calculate the weight (higher for stars closer to the average)
      double weight = exp(-0.5 * zScore * zScore);

      unnormalizedWeights[star] = weight;
      totalWeight += weight;
    }

    // 2. Normalize the weights to get proportions (sum must be 1.0)
    final Map<int, double> finalDistribution = {};

    unnormalizedWeights.forEach((star, weight) {
      // Proportion = weight / totalWeight
      double proportion = weight / totalWeight;

      // Round to 3 decimal places for accuracy, or 2 for cleaner UI
      finalDistribution[star] = double.parse(proportion.toStringAsFixed(3));
    });

    // 3. Ensure the keys are sorted (optional, but clean)
    return Map.fromEntries(
      finalDistribution.entries.toList()
        ..sort((a, b) => b.key.compareTo(a.key)),
    );
  }
}
