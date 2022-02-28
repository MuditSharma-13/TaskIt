import 'package:flutter/material.dart';
import 'package:nudger/models/category.dart';
import 'package:nudger/services/category_service.dart';
import 'package:nudger/sidebar.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();
  var _category = Category();
  var _categoryService = CategoryService();

  List<Category> _categoryList = <Category>[];

  var category;

  var _editCategoryNameController = TextEditingController();
  var _editCategoryDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  getAllCategories() async {
    _categoryList = <Category>[];
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        var categoryModel = Category();
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];
        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, CategoryId) async {
    category = await _categoryService.readCategoriesbyId(CategoryId);
    setState(() {
      _editCategoryNameController.text = category[0]['name'] ?? 'No Name';
      _editCategoryDescriptionController.text =
          category[0]['name'] ?? 'No Description';
    });
    _editFormDialog(context);
  }

  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              TextButton(
                  style: TextButton.styleFrom(primary: Colors.red),
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              TextButton(
                  style: TextButton.styleFrom(primary: Colors.blue),
                  onPressed: () async {
                    _category.name = _categoryNameController.text;
                    _category.description = _categoryDescriptionController.text;
                    var result = await _categoryService.saveCategory(_category);

                    if (result > 0) {
                      Navigator.pop(context);
                      getAllCategories();
                    }
                  },
                  child: Text('Save'))
            ],
            title: Text('Task'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _categoryNameController,
                    decoration: InputDecoration(
                        hintText: 'Enter a Task', labelText: 'Task'),
                  ),
                  TextField(
                    controller: _categoryDescriptionController,
                    decoration: InputDecoration(
                        hintText: 'Enter a Description',
                        labelText: 'Description'),
                  )
                ],
              ),
            ),
          );
        });
  }

  _editFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              TextButton(
                  style: TextButton.styleFrom(primary: Colors.red),
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              TextButton(
                  style: TextButton.styleFrom(primary: Colors.blue),
                  onPressed: () async {
                    _category.id = category[0]['id'];
                    _category.name = _editCategoryNameController.text;
                    _category.description =
                        _editCategoryDescriptionController.text;
                    var result =
                        await _categoryService.updateCategory(_category);
                    Navigator.pop(context);
                    getAllCategories();
                    _showSuccessSnackBar();
                  },
                  child: Text('Update'))
            ],
            title: Text('Edit Task'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _editCategoryNameController,
                    decoration: InputDecoration(
                        hintText: 'Enter the task', labelText: 'Task'),
                  ),
                  TextField(
                    controller: _editCategoryDescriptionController,
                    decoration: InputDecoration(
                        hintText: 'Enter a Description',
                        labelText: 'Description'),
                  )
                ],
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              TextButton(
                  style: TextButton.styleFrom(primary: Colors.green),
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              TextButton(
                  style: TextButton.styleFrom(primary: Colors.red),
                  onPressed: () async {
                    var result =
                        await _categoryService.deleteCategory(categoryId);
                    if (result > 0) {
                      Navigator.pop(context);
                      getAllCategories();
                      _showDeleteSnackBar();
                    }
                  },
                  child: Text('Delete'))
            ],
            title: Text('Do you want to delete this task?'),
          );
        });
  }

  _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Successfully Updated"),
        duration: Duration(milliseconds: 1000),
      ),
    );
  }

  _showDeleteSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Successfully Deleted"),
        duration: Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      key: _globalKey,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(80.0),
          child: Container(
              child: Text(
            'TaskIt',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )),
        ),
      ),
      body: ListView.builder(
        itemCount: _categoryList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 8.0, left: 16, right: 16),
            child: Card(
              elevation: 5,
              color: Colors.amber[200],
              child: ListTile(
                leading: IconButton(
                    onPressed: () {
                      _editCategory(context, _categoryList[index].id);
                    },
                    icon: Icon(Icons.edit)),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _categoryList[index].name.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      onPressed: () {
                        _deleteFormDialog(context, _categoryList[index].id);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    _categoryList[index].description.toString(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
