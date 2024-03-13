import 'package:flutter/material.dart';
import 'package:mowp/model/Transactions.dart';
import 'package:mowp/provider/provider.dart';
import 'package:provider/provider.dart';

class FromScreen extends StatelessWidget {
  //ตรวจสอบข้อมูลที่กรอกว่าไม่ค่าว่าไรงี้อะ
  final formKey = GlobalKey<FormState>();

//controller
  final titleController = TextEditingController(); //รับค่าชื่อรายการ
  final AmountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("แบบฟอร์มบันทึกข้อมูล"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0), //4ทิศห่างเท่านีเลย
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, //ทำให้ปุ่มอยู่ด้านข้าง
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "ชื่อรายการ"),
                autofocus: true, //ให้เคอร์เซอร์อยู่ตรงนี้ที่แรกเก๋ๆ
                controller: titleController,
                validator: (String? str) {
                  if (str == null || str.isEmpty) {
                    return "กรุณาป้อนข้อมูล";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "จำนวนเงิน"),
                keyboardType: TextInputType
                    .number, //ที่keybordเป็นตัวเลข และรับเฉพาะตัวเลขเท่านั้น
                controller: AmountController,
                validator: (String? str) {
                  if (str == null || str.isEmpty) {
                    return "กรุณาป้อนจำนวนเงิน";
                  }
                  double? parsedValue = double.tryParse(str);
                  if (parsedValue == null || parsedValue <= 0) {
                    return "โปรดป้อนค่าเป็นตัวเลขที่มากกว่าศูนย์";
                  }
                  return null;
                },
              ),
              TextButton(
                child: Text("add data"),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.yellow, // กำหนดสีของตัวอักษรในปุ่ม
                  backgroundColor: Colors.pink, //พื้นหลังของปุ่ม
                ),
                onPressed: () {
                  if (formKey.currentState != null &&
                      formKey.currentState!.validate()) {
                    var title = titleController.text;
                    var amount = AmountController.text;
                    //เตรียมข้อมูลลงprovider
                    double Amount = double.parse(amount);
                    Transactions statement = Transactions(
                        title: title, amount: Amount, date: DateTime.now());

                    //เรียกprovider
                    var provider = Provider.of<TransactionProvider>(context,
                        listen: false);
                    provider.addTransactions(statement);
                    Navigator.pop(
                        context); //เอาหน้าจอที่2ออกจากหtackของnavigatorคือกดเพิ่มข้อมูลก็จักลับไปหน้าแรก
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
