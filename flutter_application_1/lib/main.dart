import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Плавное появление',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FadeInWidgetOnFocus(),
    );
  }
}

class FadeInWidgetOnFocus extends StatefulWidget {
  @override
  _FadeInWidgetOnFocusState createState() => _FadeInWidgetOnFocusState();
}

class _FadeInWidgetOnFocusState extends State<FadeInWidgetOnFocus> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Плавное появление')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            focusNode: _focusNode,
            decoration: InputDecoration(labelText: 'Введите текст'),
          ),
          SizedBox(height: 20),
          AnimatedOpacity(
            opacity: _isFocused ? 1.0 : 0.0,
            duration: Duration(milliseconds: 1000),
            child: Container(
              height: 50,
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text(
                'Этот виджет появляется плавно!',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
