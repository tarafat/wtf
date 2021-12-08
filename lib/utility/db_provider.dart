import 'dart:io';
import 'dart:async';

import 'package:peandpr/model/coupon.dart';
import 'package:peandpr/model/redeem.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    DatabaseHelper? _databaseHelper;
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper;
  }

  Future<Database> get database async {
    Database? _database;
    _database ??= await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory dd = await getApplicationDocumentsDirectory();
    final path = join(dd.path, "peandpr.db");

    var createDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            '''CREATE TABLE coupon
       (
         id INTEGER PRIMARY KEY,
         amount INTEGER,
         earned INTEGER
       )
       ''');
        db.insert(
          'coupon',
          {'id': '1', 'amount': '150', 'earned': '0'},
        );
        db.insert(
          'coupon',
          {'id': '2', 'amount': '50', 'earned': '0'},
        );
        db.insert(
          'coupon',
          {'id': '3', 'amount': '250', 'earned': '0'},
        );
        db.insert(
          'coupon',
          {'id': '4', 'amount': '60', 'earned': '0'},
        );
        db.insert(
          'coupon',
          {'id': '5', 'amount': '40', 'earned': '0'},
        );
        db.insert(
          'coupon',
          {'id': '6', 'amount': '100', 'earned': '0'},
        );
        db.insert(
          'coupon',
          {'id': '7', 'amount': '20', 'earned': '0'},
        );
        db.insert(
          'coupon',
          {'id': '8', 'amount': '80', 'earned': '0'},
        );
      },
    );
    return createDatabase;
  }

  //Coupon
  Future<Coupon?> fetchCoupon() async {
    Database db = await database;
    var maps = await db.query(
      "coupon",
      columns: null,
    );
    if (maps.isNotEmpty) {
      return Coupon.fromMapToDb(maps.first);
    }
    return null;
  }

  Future<List<Coupon>> getAllCoupon() async {
    Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query("coupon", columns: null, orderBy: "id ASC");
    List<Coupon> coupons = [];
    results.forEach((result) {
      Coupon coupon = Coupon.fromMapToDb(result);
      coupons.add(coupon);
    });
    return coupons;
  }

  Future<int> addCoupon(Coupon coupon) async {
    Database db = await database;
    return db.insert("coupon", coupon.toMapFromDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  updateCoupon(Coupon coupon) async {
    Database db = await database;
    var result = await db.update("coupon", coupon.toMapFromDb(),
        where: "id = ?", whereArgs: [coupon.id]);
    return result;
  }

  deleteCoupon(int id) async {
    Database db = await database;
    db.delete("coupon", where: "id = ?", whereArgs: [id]);
  }

  //Redeem
  Future<Redeem?> fetchRedeem() async {
    Database db = await database;
    var maps = await db.query(
      "redeem",
      columns: null,
    );
    if (maps.isNotEmpty) {
      return Redeem.fromMapToDb(maps.first);
    }
    return null;
  }

  Future<List<Redeem>> getAllRedeem() async {
    Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query("redeem", columns: null, orderBy: "id ASC");
    List<Redeem> redeems = [];
    results.forEach((result) {
      Redeem redeem = Redeem.fromMapToDb(result);
      redeems.add(redeem);
    });
    return redeems;
  }

  Future<int> addRedeem(Redeem redeem) async {
    Database db = await database;
    return db.insert("redeem", redeem.toMapFromDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  updateRedeem(Redeem redeem) async {
    Database db = await database;
    var result = await db.update("redeem", redeem.toMapFromDb(),
        where: "id = ?", whereArgs: [redeem.id]);
    return result;
  }

  deleteRedeem(int id) async {
    Database db = await database;
    db.delete("redeem", where: "id = ?", whereArgs: [id]);
  }
}
