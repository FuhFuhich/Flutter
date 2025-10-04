import 'package:flutter/material.dart';
import 'fragment1.dart';

class Fragment5Custom extends StatefulWidget {
  @override
  _Fragment5CustomState createState() => _Fragment5CustomState();
}

class _Fragment5CustomState extends State<Fragment5Custom> {
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
      MaterialPageRoute(builder: (context) => Fragment1()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListView.custom')),
      body: ListView.custom(
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) {
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
          childCount: items.length,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'add_custom',
            onPressed: addItem,
            child: Icon(Icons.add),
            tooltip: 'Add item',
          ),
          SizedBox(width: 16),
          FloatingActionButton.extended(
            heroTag: 'next_custom',
            label: Text('SingleChildScrollView'),
            icon: Icon(Icons.swap_vert),
            onPressed: navigateNext,
          ),
        ],
      ),
    );
  }
}
