import 'package:flutter/material.dart';
import 'package:todolist/pages/add.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:todolist/pages/update_todolist.dart';

class Todolist extends StatefulWidget {
  //const Todolist({ Key? key }) : super(key: key);

  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  
  List todolistitems = ['A', 'B', 'C', 'D'];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodolist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPage())).then((value) {    // Navigator.push(*UpdatePage*).then(*setState*);
                    setState(() {
                      getTodolist();
                    });
                  });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('All Todolist'),
      actions: [
        IconButton(onPressed: () {
          setState(() {
            getTodolist();
          });;
        }, icon: Icon(Icons.refresh,color: Colors.white,))
      ],
        ),
      body: todolistCreate(),
      
    );
  }
  Widget todolistCreate() {
    return ListView.builder(
      itemCount: todolistitems.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('${todolistitems[index]['title']}'), 
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=> UpdatePage(
                  todolistitems[index]['id'],
                  todolistitems[index]['title'],
                  todolistitems[index]['detail'],
                  )
                  )
                  ).then((value) {    // Navigator.push(*UpdatePage*).then(*setState*);
                    setState(() {
                      print(value);
                      if(value == 'delete') {

                        final snackBar = SnackBar(
                          content: const Text('ลบรายการเรียบร้อยแล้ว'),
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        
                      }
                      getTodolist();
                    });
                  });
            },
          )
        );
      } 
    );
  }
  Future<void> getTodolist() async {
    List alltodo = [];
    //var url = Uri.https('4ad5-184-22-214-62.ngrok.io', '/api/all-todolist');
    var url = Uri.http('192.168.0.14:8000', '/api/all-todolist');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    print(result);
    setState(() {
      todolistitems = jsonDecode(result);
    });
  }
}