import 'package:flutter/material.dart';
import 'package:nudger/models/category.dart';
import 'package:nudger/repositories/repository.dart';

class CategoryService {
  Repository? _repository;

  CategoryService() {
    _repository = Repository();
  }
  //Create the data
  saveCategory(Category category) async {
    return await _repository?.insertData('categories', category.CategoryMap());
  }

  //read the data from the table
  readCategories() async {
    return await _repository?.readData('categories');
  }

  //read data from table by Id
  readCategoriesbyId(categoryId) async {
    return await _repository?.readDataById('categories', categoryId);
  }

  //updates data from the table
  updateCategory(Category category) async {
    return await _repository?.updateData('categories', category.CategoryMap());
  }

  //delete data from the table
  deleteCategory(categoryId) async {
    return await _repository?.deleteData('categories', categoryId);
  }
}
