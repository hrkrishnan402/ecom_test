import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// Small coloured dot indicating veg (green) or non-veg (red).
///
/// Reusable across any screen that needs a dietary indicator.
class VegIndicator extends StatelessWidget {
  final bool isVeg;
  final double size;

  const VegIndicator({
    super.key,
    required this.isVeg,
    this.size = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isVeg ? AppTheme.vegColor : AppTheme.nonVegColor,
      ),
    );
  }
}
