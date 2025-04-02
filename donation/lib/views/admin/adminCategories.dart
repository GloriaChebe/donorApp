import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:flutter_application_1/controllers/itemController.dart';
import 'package:flutter_application_1/views/donate.dart';
import 'package:get/get.dart';

class CategoriesAdmin extends StatelessWidget {
  final ItemController itemController = Get.put(ItemController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        foregroundColor: appwhiteColor,
        title: Center(
          child: Text(
            'Browse Categories',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          // Category Filter Chips
          _CategoryFilterChips(itemController: itemController),

          // Header Section
          Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text(
                      itemController.selectedCategory.value == 'All'
                          ? 'All Items'
                          : '${itemController.selectedCategory.value} Items',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                SizedBox(width: 16),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    onChanged: (value) {
                      itemController.searchItems(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Items Grid
          Expanded(
            child: _ItemGrid(itemController: itemController),
          ),
        ],
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
          _showAddItemDialog(context);
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  
  void _showAddItemDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController imageController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Item'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: categoryController,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: imageController,
                  decoration: InputDecoration(
                    labelText: 'Image ',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
               
                
                Navigator.of(context).pop();
              },
              child: Text('Add', style: TextStyle(color: appwhiteColor),),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: appwhiteColor,
              ),
            ),
          ],
        );
      },
    );
  }
}

// Category Filter Chips Widget
class _CategoryFilterChips extends StatelessWidget {
  final ItemController itemController;

  _CategoryFilterChips({required this.itemController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Obx(() => ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: <String>['All', 'Food', 'Textiles', 'Engineering', 'Leather']
                .map((String category) {
              bool isSelected = itemController.selectedCategory.value == category;
              return Padding(
                padding: EdgeInsets.only(right: 12),
                child: FilterChip(
                  selected: isSelected,
                  label: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  backgroundColor: Colors.grey.shade200,
                  selectedColor: primaryColor,
                  onSelected: (bool selected) {
                    itemController.filterItems(category);
                  },
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              );
            }).toList(),
          )),
    );
  }
}

// Items Grid Widget
class _ItemGrid extends StatelessWidget {
  final ItemController itemController;

  _ItemGrid({required this.itemController});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.builder(
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.71,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: itemController.filteredItems.length,
          itemBuilder: (context, index) {
            var item = itemController.filteredItems[index];
            return _ItemCard(item: item);
          },
        ));
  }
}

// Item Card Widget
class _ItemCard extends StatelessWidget {
  final dynamic item;

  _ItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item image
          AspectRatio(
            aspectRatio: 1.2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                image: DecorationImage(
                  image: NetworkImage('https://sanerylgloann.co.ke/donorApp/itemImages/' + item.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Item details
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            //Get.to(() => );
                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8), 
                      // edit
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                             
                            
                          },
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom search delegate
class ItemSearchDelegate extends SearchDelegate<String> {
  final ItemController itemController;

  ItemSearchDelegate(this.itemController);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement search suggestions
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final results = itemController.items
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: Container(
            width: 50,
            height: 50,
            color: Colors.grey.shade200,
            child: Center(
              child: Icon(Icons.image, color: Colors.grey),
            ),
          ),
          title: Text(item.name),
          subtitle: Text(item.category),
          onTap: () {
            // Handle item selection
            close(context, item.name);
          },
        );
      },
    );
  }
}