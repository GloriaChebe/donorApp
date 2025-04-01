import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ManageItemsPage extends StatefulWidget {
  @override
  _ManageItemsPageState createState() => _ManageItemsPageState();
}

class _ManageItemsPageState extends State<ManageItemsPage> {
  // Mock data for items
  List<Map<String, dynamic>> urgentItems = [];
  List<Map<String, dynamic>> normalItems = [];
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Items', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddItemDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Urgent Items Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Urgent Items',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            _buildItemList(urgentItems, 'Urgent'),
            Divider(),

            // Normal Items Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Normal Items',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            _buildItemList(normalItems, 'Normal'),
          ],
        ),
      ),
    );
  }

  // Build item list for a section
  Widget _buildItemList(List<Map<String, dynamic>> items, String section) {
    return items.isEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('No items in $section section.'),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: item['image'] != null
                    ? Image.file(
                        item['image'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.image, size: 50, color: Colors.grey),
                title: Text(item['name']),
                subtitle: Text('Category: ${item['category']}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _deleteItem(section, index);
                  },
                ),
              );
            },
          );
  }

  // Show dialog to add a new item
  void _showAddItemDialog() {
    String name = '';
    String category = 'Food';
    File? image;
    String section = 'Urgent';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Item'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Name'),
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: category,
                      items: ['Food', 'Clothing', 'Medicine', 'Other']
                          .map((cat) => DropdownMenuItem(
                                value: cat,
                                child: Text(cat),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          category = value!;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Category'),
                    ),
                    DropdownButtonFormField<String>(
                      value: section,
                      items: ['Urgent', 'Normal']
                          .map((sec) => DropdownMenuItem(
                                value: sec,
                                child: Text(sec),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          section = value!;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Section'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final pickedFile = await _picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedFile != null) {
                          setState(() {
                            image = File(pickedFile.path);
                          });
                        }
                      },
                      icon: Icon(Icons.upload),
                      label: Text('Upload Image'),
                    ),
                    if (image != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Image.file(
                          image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (name.isNotEmpty && category.isNotEmpty) {
                      setState(() {
                        final newItem = {
                          'name': name,
                          'category': category,
                          'image': image,
                        };
                        if (section == 'Urgent') {
                          urgentItems.add(newItem);
                        } else {
                          normalItems.add(newItem);
                        }
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Delete an item
  void _deleteItem(String section, int index) {
    setState(() {
      if (section == 'Urgent') {
        urgentItems.removeAt(index);
      } else {
        normalItems.removeAt(index);
      }
    });
  }
}