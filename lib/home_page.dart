import 'package:flutter/material.dart';

class MultiSelect extends StatefulWidget {
  final List<String> items;

  const MultiSelect({super.key, required this.items});

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];

//this function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

//this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Select Topics'),
        content: SingleChildScrollView(
          child: ListBody(
            children: widget.items
                .map((item) => CheckboxListTile(
                      value: _selectedItems.contains(item),
                      title: Text(item),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (isChecked) => _itemChange(item, isChecked!),
                    ))
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _cancel,
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Submit'),
          ),
        ]);
  }
}

@override
Widget build(BuildContext context) {
  return Container();
}

//Implement a multi select on the Home screen
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _selectedItems = [];

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can hard-coded or dynamically loaded from a database or API
    final List<String> items = [
      'Flutter',
      'Dart',
      'Android',
      'iOS',
      'Kotlin',
      'Swift',
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items);
      },
    );

// Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MultiSelect'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _showMultiSelect,
              child: const Text('Select your favorite topic'),
            ),
            const Divider(
              height: 30,
            ),
            Wrap(
              children: _selectedItems
                  .map((e) => Chip(
                        label: Text(e),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
