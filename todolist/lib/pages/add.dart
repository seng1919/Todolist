import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class AddPage extends StatefulWidget {
  const AddPage({ Key? key }) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เพิ่มรายการใหม่'),),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(height: 30,),
            SizedBox(
                  width: 300,
                  child: TextField(
                      controller: todo_title,
                      decoration: InputDecoration(
                          labelText: 'รายการที่ต้องทำ', 
                          labelStyle: TextStyle(fontFamily: 'Kanit'),
                          border: OutlineInputBorder())),
                ),
            SizedBox(height: 30,),
            SizedBox(
                  width: 300,
                  child: TextField(
                      minLines: 4,
                      maxLines: 8,
                      controller: todo_detail,
                      decoration: InputDecoration(
                          labelText: 'รายละเอียด', 
                          labelStyle: TextStyle(fontFamily: 'Kanit'),
                          border: OutlineInputBorder())),
                ),
            SizedBox(height: 30,),
            // ปุ่มเพิ่มข้อมูล
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                  child: ElevatedButton(
                      onPressed: () {
                        print('-------------');
                        print('title: ${todo_title.text}');
                        print('detail: ${todo_detail.text}');
                        postTodo();
                      }, 
                      child: Text('เพิ่มรายการ'), 
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                            padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 20, 50, 20)),
                            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20, fontFamily: 'Kanit')),
                         ),
                  ),
                ),
                SizedBox(height: 30,),
          ]),
      ));
  }

  Future postTodo() async {
    //var url = Uri.https('4ad5-184-22-214-62.ngrok.io', '/api/post-todolist');
    var url = Uri.http('192.168.0.14:8000', '/api/post-todolist');
    Map<String, String> header = {"Content-type":"application/json"};
    String jsondata = '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('--------result--------');
    print(response.body);
  }


}