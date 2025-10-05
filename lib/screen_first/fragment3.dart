import 'package:flutter/material.dart';
import 'fragment4_builder.dart';

class Fragment3 extends StatefulWidget {
  @override
  _Fragment3State createState() => _Fragment3State();
}

class _Fragment3State extends State<Fragment3> {
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
      MaterialPageRoute(builder: (context) => Fragment4Builder()),
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'add3',
            onPressed: addItem,
            child: Icon(Icons.add),
            tooltip: 'Add item',
          ),
          SizedBox(width: 16),
          FloatingActionButton.extended(
            label: Text('ListView.builder'),
            icon: Icon(Icons.arrow_forward),
            onPressed: navigateNext,
            heroTag: 'nav3',
          ),
        ],
      ),
    );
  }
}
