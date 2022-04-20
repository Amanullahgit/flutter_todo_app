// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final List _itemList = [];
  final List _completedTasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'TODO Everyday',
        style: TextStyle(color: Colors.black),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.purpleAccent),
        onPressed: () => _additemDialog(),
      ),
      body: ListView.builder(
          itemCount: _itemList.length,
          padding: EdgeInsets.all(8.0),
          reverse: false,
          itemBuilder: (_, int index) {
            return _itemsCardWidget(index);
          }),
    );
  }

  void _submitTask(String text) {
    setState(() {
      _itemList.add(text);
    });
    _textEditingController.clear();
  }

  _completeTask(int index) {
    if (_completedTasks.contains(_itemList[index])) {
      setState(() {
        _completedTasks.remove(_itemList[index]);
      });
    } else {
      setState(() {
        _completedTasks.add(_itemList[index]);
      });
    }
  }

  void _updateTask(int index, String text) {
    setState(() {
      _itemList[index] = text;
    });
  }

  _itemsCardWidget(int index) {
    return Card(
      color: Colors.white70,
      child: ListTile(
        title: Text(_itemList[index]),
        onLongPress: () => _completedTasks.contains(_itemList[index])
            ? _deleteItemDialog(index)
            : _updateItemDialog(index),
        onTap: () => _completeTask(index),
        trailing: _completedTasks.contains(_itemList[index])
            ? Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
              )
            : GestureDetector(
                child: Icon(
                  Icons.remove_circle,
                  color: Colors.redAccent,
                ),
                onTap: () => _deleteItemDialog(index),
              ),
      ),
    );
  }

  _additemDialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: _textEditingController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Task",
                  hintText: "eg. Shopping",
                ),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.redAccent),
                    )),
                TextButton(
                    onPressed: () {
                      _submitTask(_textEditingController.text);
                      Navigator.pop(context);
                    },
                    child: Text("Save")),
              ],
            ));
  }

  _deleteItemDialog(int index) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Delete Task"),
              content: Text('Do you want to delete ${_itemList[index]} ?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _textEditingController.clear();
                    setState(() {
                      _itemList.removeAt(index);
                    });
                    print('item removed');
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            ));
  }

  _updateItemDialog(int index) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Update Task"),
            content: TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Task",
                hintText: "eg. Something else",
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
              TextButton(
                onPressed: () {
                  _updateTask(index, _textEditingController.text);

                  _textEditingController.clear();
                  Navigator.pop(context);
                },
                child: Text("Update"),
              ),
            ],
          );
        });
  }
}
