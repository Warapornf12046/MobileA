import 'dart:io';

import 'package:mowp/model/Transactions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  //บริการเกี่ยวกับข้อมูล
  String dbName; //เก็บชื่อฐานข้อมููล ตั้งชื่ออะ
  //นิยามconstor
  //ถ้ายังไม่ถูกสร้าง =>> สร้าง
  //ถ้าถูกสร้างไว้แล้วว =>> เปิด มาใช้วันหลังมันก็จจะเปิด
  TransactionDB({required this.dbName});

  //หาตำแหน่งที่จะเก็บ เช่นหาจากuser ex. user/b  C:/user/a/transaction.db
  Future<Database> openDatabase() async {
    //ถ้าชื่อdbคือ transaction.db ก็จะเอาไปต่อที่path
    //รูปแบบเป็นASyn
    //หาตำแหน่งที่จะเก็บข้อมูล
    Directory appDirectory = await getApplicationCacheDirectory();
    String dbLocation = join(appDirectory.path, dbName); //ต่อpathกัน

    //สร้างdb
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);

    return db;
  }

  //บันทึกข้อมูล
  InsertData(Transactions statement) async {
    //บันทึกข้อมููลลงฐานข้อมูลที่store
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");

    //json
    store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date
    });
  }
}
