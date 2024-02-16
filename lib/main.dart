import 'package:flutter/material.dart';
import 'package:todo_stream/repository.dart';

class StreamPage extends StatefulWidget {
  const StreamPage({super.key});

  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  late Repository repository;

  @override
  void initState() {
    repository = Repository();
    super.initState();
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ToDoModel>>(
        stream: repository.stream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: Text("No Todo "),
            );
          } else {
            final todos = snapshot.data!;
            return ListView.separated(
              itemBuilder: (_, index) => ListTile(
                title: Text('${todos[index].title} ${todos[index].id}'),
                subtitle: Text(todos[index].desc),
              ),
              separatorBuilder: (_, __) => const SizedBox(height: 6),
              itemCount: todos.length,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: TextField(
                                controller: titleController,
                                cursorColor: Colors.black,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 13.5),
                                  filled: true,
                                  fillColor: Color.fromRGBO(243, 242, 245, 1),
                                  hintText: "Title",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: TextField(
                                controller: descController,
                                cursorColor: Colors.black,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 13.5),
                                  filled: true,
                                  fillColor: Color.fromRGBO(243, 242, 245, 1),
                                  hintText: "Desription",
                                ),
                              ),
                            ),
                          ),
        
                        ],
                      ),                  ElevatedButton(
                              onPressed: () async {
                                await repository.createToDo(titleController.text, descController.text);
                                Navigator.of(context).pop();
                              },
                              child: const Text("Create ToDo"))
                    ],
                  ),
                ),
              );
            },
          );
          // await repository.createToDo('To Do', 'Created');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StreamPage(),
    );
  }
}
