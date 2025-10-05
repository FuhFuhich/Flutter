import 'package:flutter/material.dart';
import 'fragment5_custom.dart';

class Fragment4Builder extends StatefulWidget {
  @override
  _Fragment4BuilderState createState() => _Fragment4BuilderState();
}

class _Fragment4BuilderState extends State<Fragment4Builder> {
  List<String> items = ['Server 1', 'Server 2', 'Server 3'];

  void addItem() {
    setState(() {
      items.add('Server ${items.length + 1}');
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
      MaterialPageRoute(builder: (context) => Fragment5Custom()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListView.builder')),
      body: ListView.builder(
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
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'add_builder',
            onPressed: addItem,
            child: Icon(Icons.add),
            tooltip: 'Add item',
          ),
          SizedBox(width: 16),
          FloatingActionButton.extended(
            heroTag: 'next_builder',
            label: Text('ListView.custom'),
            icon: Icon(Icons.settings),
            onPressed: navigateNext,
          ),
        ],
      ),
    );
  }
}
