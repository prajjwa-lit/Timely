import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/firestore_functions.dart';
import 'package:todoapp/login.dart';
import 'package:todoapp/models.dart';
import 'package:uuid/uuid.dart';

class MyHome extends StatefulWidget {
  final UserModel userModel;
  const MyHome({super.key, required this.userModel});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final uid = const Uuid();
  List<Todo> _todoList = [];
  List jsonTODOList = [];

  final TextEditingController _textFieldController = TextEditingController();
  @override

  getData()async{
    var taskSnapshot = await FirebaseFirestore.instance.collection('user').doc(widget.userModel.uid).get();
    Map jsonList = taskSnapshot.data() as Map;
    List<dynamic> temp = jsonList['Tasks'];
    return temp;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30), top: Radius.circular(15))),
        centerTitle: true,
        backgroundColor: Color(0xff040D12),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 14.0),
          child: Text(
            'Timely',
            style: TextStyle(
              color: Color(0xff93B1A6),
              fontWeight: FontWeight.w600,
              fontSize: 35,
            ),
          ),
        ),
      ),
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg3.jpg'), fit: BoxFit.fitHeight)),
          child: Container(
            margin: const EdgeInsets.only(
                left: 30.0, right: 30.0, bottom: 10.0, top: 10.0),
            color: Color(0xff183D3D).withOpacity(0.5),
            child: FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                    log(snapshot.data.toString());
                    List<Todo> temp = [];
                    jsonTODOList = snapshot.data;
                    for(var items in snapshot.data){
                      temp.add(Todo.fromJson(items));
                      _todoList.add(Todo.fromJson(items));
                    }
                    _todoList = temp;
                  return ListView(children: _getItems());
                }
                  else{
                    return ListView(children: _getItems());
                  }
              },

            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 5,),
          FloatingActionButton(
            elevation: 30,
            backgroundColor: Color(0xff3C2A21),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
              // await Firestore().fetchUserData(widget.userModel);
              // getData();
            },
            child: Icon(
              Icons.logout_rounded,
              color: Color(0xff93B1A6),
            ),
          ),
          SizedBox(width: 80,),
          FloatingActionButton(
            elevation: 30,
            shape: StadiumBorder(
                side: BorderSide(color: Colors.white24, width: 1)),
            backgroundColor: Color(0xff93B1A6),
            onPressed: () => _displayDialog(context),
            tooltip: 'Add Item',
            child: Icon(
              Icons.add,
              color: Color(0xff3C2A21),
            ),
          ),
        ],
      ),
    );
  }

  void _addTodoItem(String title) async {
    Todo myTodo = Todo(title: title, isDone: false, uid: uid.v1());
    _todoList.add(myTodo);
    Map<String, dynamic> ogTODO = myTodo.toJson();
    jsonTODOList.add(ogTODO);
    await Firestore().uploadTask([ogTODO], widget.userModel);
    setState(() {});
    _textFieldController.clear();
  }

  List<Widget> _getItems() {
    final List<Widget> todoWidgets = [];
    for (Todo todo in _todoList) {
      todoWidgets.add(TodoItem(
        todo: todo,
        onChanged: (value) async {
          setState(() {
            todo.isDone = !todo.isDone;
            for (var mp in jsonTODOList) {
              if (todo.uid == mp['uid']) {
                mp['isDone'] = todo.isDone;
                log('changed the one with name = ${todo.title} to : ${todo.isDone}');
                print(jsonTODOList);
              }
            }
          });
          await Firestore().updateDoneStatus(jsonTODOList, widget.userModel);
        }, onPressed: (){
            jsonTODOList.remove(todo.toJson());
            _todoList.remove(todo);
            Firestore().removeTask([todo.toJson()], widget.userModel);
            setState(() {

            });
      },
      ));
    }
    return todoWidgets;
  }

  Future<Future> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff93B1A6),
            title: const Text(
              'Add a task to your List',
              style: TextStyle(color: Color(0xff040D12)),
            ),
            content: TextField(
              controller: _textFieldController,
              decoration:
                  const InputDecoration(hintText: 'Enter your task here'),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff040D12)),
                child: const Text(
                  'ADD',
                  style: TextStyle(color: Color(0xff93B1A6)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff040D12),
                ),
                child: const Text(
                  'CANCEL',
                  style: TextStyle(color: Color(0xff93B1A6)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  final void Function() onPressed;
  final void Function(bool?) onChanged;
  const TodoItem(
      {super.key,
      required this.todo,
      required this.onChanged, required this.onPressed});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        activeColor: Color(0xff93B1A6),
        checkColor: Color(0xff040D12),
        value: widget.todo.isDone,
        onChanged: widget.onChanged,
      ),
      title: Text(
        widget.todo.title ?? '',
        style: TextStyle(color: Color(0xff93B1A6)),
      ),
      trailing: IconButton(onPressed: widget.onPressed, icon: const Icon(Icons.close)),
    );
  }
}
/**
 * Row(
    children: [


    ],
    )
 */
