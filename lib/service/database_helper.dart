// TODO Implement this library.// TODO Implement this library.// TODO Implement this library.// TODO Implement this library.// TODO Implement this library.// TODO Implement this library.// TODO Implement this library.// TODO Implement this library.// TODO Implement this library.// TODO Implement this library.// TODO Implement this library.// TODO Implement this library.// TODO Implement this library.// TODO Implement this library.// TODO Implement this library.

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_note_list/model/category_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    var exists = await databaseExists(path);
    if (!exists) {
      var data = await rootBundle.load(join('assets', filePath));
      List<int> bytes =
      data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }
    return await openDatabase(path);
  }
  Future<List<CategoryModel>?> getCategories()async{
    try{
      var db = await instance.database;
      var templist = <CategoryModel>[];
      var categories = await db.query('categories');
      for(var item in categories){
      templist.add(CategoryModel.fromjson(item));
      }
      return templist;
      }catch(e){
        print('get categories $e');
        return null;

      }

  }
  Future<bool?> addCategories(CategoryModel category)async{
    try{
      var db = await instance.database;
      await db.insert('categories', category.toJson());
      return true;
    }catch(e){
      print(('add categories hatalý $e'));
      return null;
    }
  }

  Future<bool?> editCategory(CategoryModel category)async{
    try{
      var db = await instance.database;
      await db.update('categories', category.toJson(), where: 'id = ?', whereArgs: [category.id]);
      return true;
    }catch(e){
      print('edit category hatalý $e');
      return null;


    }

  }

  Future<bool?> deleteCategory(id)async{
    try{
      var db = await instance.database;
      await db.delete('categories',where: 'id = ?', whereArgs: [id]);

    }catch(e){
      print('delete category hatalý $e');
      return null;
      

    }

  }

}