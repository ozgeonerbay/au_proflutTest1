/// Single food item with optional calorie. Extendable for future nutrition fields.
class FoodItem {
  final String name;
  final int? calories;

  FoodItem({required this.name, this.calories});

  /// Total calories for this item (0 if not set).
  int get effectiveCalories => calories ?? 0;
}

/// Daily menu: date + list of food items. Daily total = sum of item calories.
class DailyMenu {
  final DateTime date;
  final List<FoodItem> items;

  DailyMenu({required this.date, required this.items});

  int get totalCalories => items.fold(0, (sum, i) => sum + i.effectiveCalories);
}
