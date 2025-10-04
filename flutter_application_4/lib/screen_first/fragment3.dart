import 'package:flutter/material.dart';
import 'fragment1.dart';

class Fragment3 extends StatefulWidget {
  @override
  _Fragment3State createState() => _Fragment3State();
}

class _Fragment3State extends State<Fragment3> {
  List<String> items = ['Item X', 'Item Y', 'Item Z'];

  void addItem() {
    setState(() {
      items.add('Item ${items.length + 1}');
    });
  }

  void removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void navigateNext() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Fragment1()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListView.separated')),
      body: ListView.separated(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final val = items[index];
          return ListTile(
            key: ValueKey(val),
            title: Text(val),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => removeItem(index),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('SingleChildScrollView'),
        icon: Icon(Icons.swap_vert),
        onPressed: navigateNext,
      ),
    );
  }
}
