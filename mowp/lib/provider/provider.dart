//ให้บริการข้อมูล
import 'package:flutter/foundation.dart';
import 'package:mowp/database/transactoin__db.dart';
import 'package:mowp/model/Transactions.dart';

class TransactionProvider with ChangeNotifier {
  //แจ้งเตือนเมื่อเปลี่ยนข้อมูล
  //object ที่จะเก็นในProvider คือชื่อรายกสร จำนวนเงิน วันที่
  //
  List<Transactions> transactions = [];
//ดึงข้อมูล
  List<Transactions> getTransaction() {
    return transactions;
  }

  void addTransactions(Transactions statement) async {
    // var db = await TransactionDB(dbName: "transaction.db")
    //     .openDatabase(); //transaction.dbชื่อฐฐานข้อมูล
    // print(db);
    transactions.insert(
        0, statement); //จากadd เป็น insertข้อมูลใหม่จะอยู่ข้างบน
    //แจ้งเตือนconsumer
    notifyListeners(); //ค่าจะเพิ่มที่หน้าแรกละแต่ข้อมูลที่เพิ่มอยู่ด้านล่าง
  }
}
