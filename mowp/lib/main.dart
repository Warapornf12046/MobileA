import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mowp/model/Transactions.dart';
import 'package:mowp/provider/provider.dart';
import 'package:mowp/screen/FormScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //จากMYMattherailApp
      //มีproหลายตัว ใช้เชื่อม
      providers: [
        //ใส่ชื่อproที่มี
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider(); //clickหลอดไฟimportด้วย
          //เอาข้อมูลมาฝากไว้ที่widjetนี้ widjetนี่จะรอฟังว่ามีการเปลี่ยนข้อมูลอะไร
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'แอปบัญชี'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
            actions: [
              IconButton(
                icon: Icon(Icons.add), //icon+จะขึ้นข้างๆ
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FromScreen(); //Text("Screen2");ต้องreturnหน้าที่2เจอเป็นจอดำ
                    //formscren8ือหน้าที่สร้างไว้อะ
                  })); //routบอกเส้นทาง
                }, //naviggaterทำงานตอนกด+
              )
            ]),
        //แสดงข้อมูล
        body: Consumer(
          //รับข้อมูลมาแสดง
          builder: (context, TransactionProvider provider, child) {
            var count = provider.transactions
                .length; //นับจำนวนข้อมูล แสดงข้อมูลตามที่มีในprovider
            if (count <= 0) {
              return Center(
                child: Text(
                  "ไม่พบข้อมูล",
                  style: TextStyle(fontSize: 35),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, int index) {
                    Transactions data = provider.transactions[
                        index]; //ดึงข้อมูลที่ละแถว ได้objectเป็นdata0 1 2
                    return Card(
                      elevation: 5, //กำหนดเงาของการ์ด
                      margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal:
                              5), //horizontal:5แนงนอนระยะห่างของการ์ดแต่ละอัน
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: FittedBox(
                            //บอกว่ามีอะไรอยู่ข้างใน
                            child: Text(data.amount.toString()),
                          ),
                        ),
                        title: Text(data.title), //เดิมคือชื่อรายการ
                        subtitle: Text(DateFormat("dd/mm/yyyy").format(
                            data.date)), //data.date.toString()มาเยอะเกิน
                      ), //จะมีเส้นๆขอบๆแสดงขอบเขต
                    );
                  } //ด้านในอยู่ใใน{}
                  );
            }
          },
        )); //เปลี่ยนจากContainer เป็นlist view
  }
}
