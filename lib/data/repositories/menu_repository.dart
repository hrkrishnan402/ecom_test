import '../../core/constants/app_strings.dart';
import '../../core/network/api_client.dart';
import '../models/menu_category.dart';

class MenuRepository {
  final ApiClient _apiClient;

  MenuRepository({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  Future<List<MenuCategory>> fetchMenu() async {
    final json = await _apiClient.get(AppStrings.menuApiUrl);
    final categoriesJson = json['categories'] as List<dynamic>;
    return categoriesJson
        .map((c) => MenuCategory.fromJson(c as Map<String, dynamic>))
        .toList();
  }

  void dispose() => _apiClient.dispose();
}
