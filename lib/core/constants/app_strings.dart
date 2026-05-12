/// Centralized string constants – no hardcoded strings in widgets.
class AppStrings {
  AppStrings._();

  // ── App ──────────────────────────────────────────────────────────────────────
  static const String appTitle = 'Food Menu';

  // ── API ──────────────────────────────────────────────────────────────────────
  static const String menuApiUrl =
      'https://faheemkodi.github.io/mock-menu-api/menu.json';

  // ── Labels ───────────────────────────────────────────────────────────────────
  static const String calories = 'calories';
  static const String customizationsAvailable = 'Customizations Available';
  static const String yourCart = 'Your Cart';
  static const String cartEmpty = 'Cart is empty';
  static const String quantityPrefix = '×';
  static const String retry = 'Retry';
  static const String somethingWentWrong = 'Something went wrong';
  static const String noItemsInCategory = 'No items in this category';

  // ── Currency ─────────────────────────────────────────────────────────────────
  static String priceLabel(String currency, String amount) =>
      '${currency == 'SAR' ? 'INR' : currency} $amount';
}
