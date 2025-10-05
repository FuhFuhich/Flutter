import 'package:flutter/material.dart';
import 'fragment2.dart';

class Fragment1 extends StatefulWidget {
  @override
  _Fragment1State createState() => _Fragment1State();
}

class _Fragment1State extends State<Fragment1> {
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
      MaterialPageRoute(builder: (context) => Fragment2()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SingleChildScrollView + Column')),
      body: SingleChildScrollView(
        child: Column(
          children: items.asMap().entries.map((entry) {
            int idx = entry.key;
            String val = entry.value;
            return ListTile(
              key: ValueKey(val),
              title: Text(val),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => removeItem(idx),
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton (
            heroTag: 'add1',
            onPressed: addItem,
            child: Icon(Icons.add),
            tooltip: 'Add item',
          ),
          const SizedBox(width: 16),
          FloatingActionButton.extended(
            label: const Text('ListView'),
            icon: const Icon(Icons.arrow_forward),
            onPressed: navigateNext,
            heroTag: 'nav1',
          ),
        ],
      ),
    );
  }
}
