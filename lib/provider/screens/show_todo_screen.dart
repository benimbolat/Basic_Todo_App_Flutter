import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/screens/add_todo_screen.dart';
import 'package:flutter_application_1/provider/screens/edit_todo_screen.dart';
import 'package:flutter_application_1/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class ShowTodoScreen extends StatelessWidget {
  const ShowTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_box_rounded),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddTodoScreen()),
          );
        },
      ),
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      body: FutureBuilder(
        future: Provider.of<TodoProvider>(context, listen: false).selectData(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            return Consumer<TodoProvider>(
              builder: (context, todoProvider, child) {
                return todoProvider.todoItem.isNotEmpty
                    ? ListView.builder(
                        itemCount: todoProvider.todoItem.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: ValueKey(todoProvider.todoItem[index].id),
                            //primary
                            background: Container(
                              margin: EdgeInsets.all(width * 0.01),
                              padding: EdgeInsets.all(width * 0.03),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(width * 0.03),
                              ),
                              alignment: Alignment.centerLeft,
                              height: height * 0.02,
                              width: width,
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),

                            //secondary
                            secondaryBackground: Container(
                              padding: EdgeInsets.all(width * 0.03),
                              margin: EdgeInsets.all(width * 0.01),
                              width: width,
                              height: height * 0.02,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(width * 0.03),
                              ),
                              alignment: Alignment.centerRight,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),

                            confirmDismiss: (DismissDirection direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                return Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditTodoScreen(
                                    id: todoProvider.todoItem[index].id,
                                    title: todoProvider.todoItem[index].title,
                                    description: todoProvider.todoItem[index].description,
                                    date: todoProvider.todoItem[index].date,
                                  ),
                                ));
                              } else {
                                showDialog(
                                  useSafeArea: true,
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    scrollable: true,
                                    title: const Text("Sil"),
                                    content: const Text("Silmke istediğine eminmisin ?"),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          todoProvider.deleteById(
                                            todoProvider.todoItem[index].id,
                                          );
                                          todoProvider.todoItem.remove(
                                            todoProvider.todoItem[index],
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Evet"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: const Text("İptal"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return null;
                            },
                            child: Card(
                              elevation: 5,
                              child: ListTile(
                                style: ListTileStyle.drawer,
                                title: Text(todoProvider.todoItem[index].title),
                                subtitle: Text(todoProvider.todoItem[index].description),
                                trailing: Text(todoProvider.todoItem[index].date),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text("Liste Boş!"),
                      );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
