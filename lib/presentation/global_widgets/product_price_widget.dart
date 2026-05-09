import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/money_formatter.dart';

class ProductPriceState {
  final String? originalPriceUzs;
  final String? currentPriceUzs;
  final String? discountPercent;
  final bool showOldPrice;
  final bool showPercentBadge;

  const ProductPriceState({
    required this.originalPriceUzs,
    required this.currentPriceUzs,
    required this.discountPercent,
    required this.showOldPrice,
    required this.showPercentBadge,
  });

  factory ProductPriceState.fromRaw({
    required String? originalPriceUzs,
    required String? salePriceUzs,
    required bool? isOnSale,
    required String? discountPercent,
  }) {
    final normalizedOriginal = _normalize(originalPriceUzs);
    final normalizedSale = _normalize(salePriceUzs);

    final hasSalePrice = normalizedSale != null && normalizedSale != normalizedOriginal;
    final hasDiscountPercent = _normalize(discountPercent) != null;

    return ProductPriceState(
      originalPriceUzs: normalizedOriginal,
      currentPriceUzs: hasSalePrice ? normalizedSale : normalizedOriginal,
      discountPercent: _normalize(discountPercent),
      showOldPrice: hasSalePrice,
      showPercentBadge: hasSalePrice && (isOnSale ?? false) && hasDiscountPercent,
    );
  }

  static String? _normalize(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    return trimmed;
  }
}

class ProductPriceWidget extends StatelessWidget {
  final ProductPriceState priceState;
  final TextStyle currentPriceStyle;
  final TextStyle oldPriceStyle;
  final TextStyle discountStyle;
  final double spacing;

  const ProductPriceWidget({
    super.key,
    required this.priceState,
    required this.currentPriceStyle,
    required this.oldPriceStyle,
    required this.discountStyle,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (priceState.showOldPrice)
          Row(
            children: [
              Flexible(
                child: Text(
                  "${AppMoneyFormatter.longFormatString(priceState.originalPriceUzs)} UZS",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: oldPriceStyle.copyWith(
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
              if (priceState.showPercentBadge) ...[
                SizedBox(width: spacing),
                Text(
                  "-${priceState.discountPercent}%",
                  style: discountStyle,
                ),
              ],
            ],
          ),
        if (priceState.showOldPrice) SizedBox(height: spacing),
        Text(
          "${AppMoneyFormatter.longFormatString(priceState.currentPriceUzs)} UZS",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: currentPriceStyle,
        ),
      ],
    );
  }
}
