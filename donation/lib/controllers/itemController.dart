import 'package:get/get.dart';
import '../models/item.dart';

class ItemController extends GetxController {
  var items = <Item>[].obs;
  var filteredItems = <Item>[].obs;
  var selectedCategory = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  void fetchItems() {
    var mockItems = [
      Item(name: 'Rice', category: 'Food', imageUrl: 'https://example.com/images/rice.jpg'),
      Item(name: 'Milk', category: 'Food', imageUrl: 'https://example.com/images/milk.jpg'),
      Item(name: 'Blankets', category: 'Textiles', imageUrl: 'https://example.com/images/blankets.jpg'),
      Item(name: 'Solar Panels', category: 'Engineering', imageUrl: 'https://example.com/images/solar_panels.jpg'),
      Item(name: 'Medical Kits', category: 'Medical', imageUrl: 'https://example.com/images/medical_kits.jpg'),
    ];
    items.assignAll(mockItems);
    filteredItems.assignAll(mockItems);
  }

  void filterItems(String category) {
    selectedCategory.value = category;
    if (category == 'All') {
      filteredItems.assignAll(items);
    } else {
      filteredItems.assignAll(items.where((item) => item.category == category).toList());
    }
  }

  void searchItems(String query) {
    if (query.isEmpty) {
      filterItems(selectedCategory.value);
    } else {
      filteredItems.value = items.where((item) => item.name.toLowerCase().contains(query.toLowerCase())).toList();
    }
  }
}
