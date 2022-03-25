import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> items = List.generate(10, (index) => 'item $index');
  String inputValue = '';
  void showAlert() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('data'),
              TextFormField(
                onChanged: (value) {
                  inputValue == value;
                  setState(() {});
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              child: const Text('Добавить'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  items.add(inputValue);
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReorderableListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(items[index]),
            child: Container(
              color: Colors.green[400],
              margin: const EdgeInsets.only(bottom: 5),
              padding: const EdgeInsets.all(15),
              child: Text(
                items[index],
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                items.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(milliseconds: 400),
                content: Text('Элемент удален'),
              ));
            },
          );
        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex = newIndex - 1;
            }
            final element = items.removeAt(oldIndex);
            items.insert(newIndex, element);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAlert,
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
