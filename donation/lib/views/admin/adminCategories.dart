import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:flutter_application_1/controllers/itemController.dart';
import 'package:flutter_application_1/views/donate.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

String? selectedCategory = 'Food';
  String? urgency = 'Urgent';
   final ItemController itemController = Get.put(ItemController());
    
    File? selectedImage;
    final TextEditingController nameController = TextEditingController();

class CategoriesAdmin extends StatefulWidget {
  @override
  _CategoriesAdminState createState() => _CategoriesAdminState();
}

class _CategoriesAdminState extends State<CategoriesAdmin> {
 
  //final CategoryController categoryController = Get.put(CategoryController());
  //final TextEditingController nameController = TextEditingController();
  
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
          print('clicked'); 
          _showAddItemDialog(context); // Call the dialog method
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  
  void _showAddItemDialog(BuildContext context) {
    
  

    Future<void> _pickImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          selectedImage = File(pickedFile.path);
        });
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add New Item'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),

                    //categories
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      items: ['Food', 'Textiles', 'Engineering', 'Leather', 'Money']
                          .map((selectedCategory) {
                        return DropdownMenuItem(
                          value: selectedCategory,
                          child: Text(selectedCategory),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      hint: Text('Select a category'),
                    ),
                    SizedBox(height: 16),
                    if (selectedCategory == 'Money')
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Enter Amount',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    SizedBox(height: 16),

                    //subcategory
                    DropdownButtonFormField<String>(
                      value: urgency,
                      items: ['Urgent', 'Normal']
                          .map((urgency) {
                        return DropdownMenuItem(
                          value: urgency,
                          child: Text(urgency),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          urgency = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'subCategory',
                        border: OutlineInputBorder(),
                      ),
                      hint: Text('Select a subCategory'),
                    ),
                    SizedBox(height: 16),

                    // Image picker section
                    Row(
                      children: [
                        // Image display container
                        Expanded(
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: selectedImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      selectedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      'No image selected',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(width: 8),

                        // Upload button
                        ElevatedButton(
                          onPressed: () async {
                            await _pickImage();
                            setState(() {});
                          },
                          child: Text('Upload',style: TextStyle(color: appwhiteColor),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    
                  
  addItems(context);

                    // Close the dialog after adding the item
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: appwhiteColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: appwhiteColor,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
  
 Future<void> addItems(context) async {
    if (selectedImage == null) {
      print("No image selected.");
      return;
    }

    final url = Uri.parse(
      'https://sanerylgloann.co.ke/donorApp/createItems.php',
    ); // Update with your API endpoint

    var request = http.MultipartRequest("POST", url);

    // Add text fields
    request.fields['name'] = nameController.text;
    request.fields['category'] = selectedCategory ?? '';
    request.fields['mostRequired'] = urgency??'' ;

    // Attach image file
    var imageFile = await http.MultipartFile.fromPath(
      'image',
      selectedImage!.path,
    );
    request.files.add(imageFile);

    // Send request
    var response = await request.send();

    if (response.statusCode == 200) {
      print("Item added successfully");
     // Navigator.of(context).pop(); // Close the popup
    } else {
      print("Failed to add item");
    }
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
                  image: CachedNetworkImageProvider('https://sanerylgloann.co.ke/donorApp/itemImages/' + item.image),
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
                          onPressed: () async {
                            http.Response response = await http.post(
                              Uri.parse('https://sanerylgloann.co.ke/donorApp/deleteItem.php'),
                              body: {
                                'itemID': item.itemsID,
                              },
                            );
                            if (response.statusCode == 200) {
                              // Handle successful deletion
                              print('Item deleted successfully');
                              itemController.fetchDonationItems();
                              Get.snackbar("Success", "Item deleted successfully");
                            } else {
                              // Handle error
                              print('Failed to delete item');
                              Get.snackbar("Error", "Failed to delete item");
                            }
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