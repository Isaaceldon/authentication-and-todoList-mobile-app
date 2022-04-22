import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_list_app/add_task.dart';
import 'package:to_do_list_app/edit_task.dart';

import 'database_service.dart';
import 'my_drawer.dart';
import 'task.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> _tasks = [];
  DatabaseService _dbService = new DatabaseService();

  _loadTasks () async {
    _tasks = await _dbService.fetchTasks();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTasks();
  }

  // Delete an person
  void _deleteTask(Task task) async {
    await _dbService.deleteTask(task);
    Fluttertoast.showToast(
      msg: "La tâche a été supprimée avec succès",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste tasks"),
      ),
      drawer: MyDrawer(),
      body: _tasks.length > 0 ? ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: _tasks.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.note_add),
                    title: Text(_tasks[index].name),
                    subtitle: Text(_tasks[index].description),
                      trailing: SizedBox(
                        width: 150,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_red_eye_outlined),
                              onPressed: (){
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ShowPerson(id: _journals[index]['id'])),
                                );*/
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditTask(task: _tasks[index])),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteTask(_tasks[index]),
                            ),
                          ],
                        ),
                      )
                  )
                ],
              ),
            );
          }
      ) : Center(
        child: Text("Aucun task dispobible", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>const AddTask()),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
