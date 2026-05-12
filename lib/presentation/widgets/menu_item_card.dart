import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/dish.dart';
import 'counter_button.dart';
import 'veg_indicator.dart';

/// Card displaying a single dish with image, info, counter, and
/// optional "Customizations Available" label.
///
/// Fully reusable — takes a [Dish] model and callbacks.
class MenuItemCard extends StatelessWidget {
  final Dish dish;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const MenuItemCard({
    super.key,
    required this.dish,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Left: info column ──
          Expanded(child: _buildInfoColumn(theme)),
          const SizedBox(width: 12),
          // ── Right: image ──
          _buildImage(),
        ],
      ),
    );
  }

  // ── Info Column ────────────────────────────────────────────────────────────

  Widget _buildInfoColumn(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNameRow(theme),
        const SizedBox(height: 4),
        _buildPriceCaloriesRow(theme),
        const SizedBox(height: 6),
        _buildDescription(theme),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: CounterButton(
            quantity: quantity,
            onIncrement: onIncrement,
            onDecrement: onDecrement,
          ),
        ),
        if (dish.customizationsAvailable) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              AppStrings.customizationsAvailable,
              style: theme.textTheme.labelMedium?.copyWith(
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNameRow(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, right: 8),
          child: VegIndicator(isVeg: dish.isVeg),
        ),
        Expanded(
          child: Text(dish.name, style: theme.textTheme.titleMedium),
        ),
      ],
    );
  }

  Widget _buildPriceCaloriesRow(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: Row(
        children: [
          Text(
            AppStrings.priceLabel(dish.currency, dish.price),
            style: theme.textTheme.bodyMedium,
          ),
          const Spacer(),
          Text(
            '${dish.calories} ${AppStrings.calories}',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildDescription(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: Text(dish.description, style: theme.textTheme.bodySmall),
    );
  }

  // ── Image ──────────────────────────────────────────────────────────────────

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: dish.imageUrl,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(
          width: 80,
          height: 80,
          color: Colors.grey.shade100,
          child: const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
        errorWidget: (_, __, ___) => Container(
          width: 80,
          height: 80,
          color: Colors.grey.shade200,
          child: const Icon(Icons.image, color: Colors.grey),
        ),
      ),
    );
  }
}
