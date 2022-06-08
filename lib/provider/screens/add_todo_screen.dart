import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Ekle"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'Başlık'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(hintText: 'Açıklama'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _dateController,
              decoration: const InputDecoration(hintText: 'Tarih'),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              todoProvider.insertData(_titleController.text, _descriptionController.text, _dateController.text);
              _titleController.clear();
              _descriptionController.clear();
              _dateController.clear();
              Navigator.of(context).pop(
                  // MaterialPageRoute(builder: (context) => const ShowTodoScreen()),
                  );
            },
            child: const Text("Kaydet"),
          )
        ],
      ),
    );
  }
}
