import 'package:flutter/material.dart';
import 'fragment3.dart';

class Fragment2 extends StatefulWidget {
  @override
  _Fragment2State createState() => _Fragment2State();
}

class _Fragment2State extends State<Fragment2> {
  List<String> items = ['Item A', 'Item B', 'Item C'];

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
      MaterialPageRoute(builder: (context) => Fragment3()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListView')),
      body: ListView(
        children: items.asMap().entries.map((entry) {
          int idx = entry.key;
          String val = entry.value;
          return ListTile(
            key: ValueKey(val),
            title: Text(val),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => removeItem(idx),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'add2',
            onPressed: addItem,
            child: Icon(Icons.add),
            tooltip: "Add item",
          ),
          SizedBox(width: 16),
          FloatingActionButton.extended(
            label: Text('ListView.separated'),
            icon: Icon(Icons.view_module),
            onPressed: navigateNext,
            heroTag: 'nav2',
          ),
        ],
      ),
    );
  }
}
