import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

import 'AppDatabase.dart';
import 'Movies.dart';

class DatabaseModel extends ChangeNotifier{

  AppDatabase database = AppDatabase();
  List<MovieResults> _favoriteList = [];

  List<MovieResults> get favorite => _favoriteList;

  getFavoriteList() {
    print("getFavoriteList");
    database.getFavoriteData().then((value){
      _favoriteList = value;
    });

    notifyListeners();
  }


}