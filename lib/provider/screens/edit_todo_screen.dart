import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../todo_provider.dart';

class EditTodoScreen extends StatefulWidget {
  const EditTodoScreen({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  }) : super(key: key);
  final String id;
  final String title;
  final String description;
  final String date;

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.title;
    _descriptionController.text = widget.description;
    _dateController.text = widget.date;
    super.initState();
  }

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
        title: const Text("Todo Güncelle"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _titleController,
              decoration:
                  const InputDecoration(hintText: 'Başlık', floatingLabelBehavior: FloatingLabelBehavior.always),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _descriptionController,
              decoration:
                  const InputDecoration(hintText: 'Açıklama', floatingLabelBehavior: FloatingLabelBehavior.always),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _dateController,
              decoration: const InputDecoration(hintText: 'Tarih', floatingLabelBehavior: FloatingLabelBehavior.always),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await todoProvider.updateTitle(widget.id, _titleController.text);
              await todoProvider.updateDescription(widget.id, _descriptionController.text);
              await todoProvider.updateDate(widget.id, _dateController.text);

              Navigator.of(context).pop();
            },
            child: const Text("Güncelle"),
          )
        ],
      ),
    );
  }
}
