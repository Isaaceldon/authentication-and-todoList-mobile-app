import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_app/my_drawer.dart';

import 'add_task.dart';
import 'database_service.dart';
import 'task.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> _tasks = [];
  Iterable<Task> _tasksNoStart = [];
  Iterable<Task> _priorityNoStartTasks = [];
  Iterable<Task> _noPriorityNoStartTasks = [];
  Iterable<Task> _tasksFinished = [];
  DatabaseService _dbService = new DatabaseService();
  int _averageTime=0;
  int _timeSum = 0;

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  _load () async {
    _tasks = await _dbService.fetchTasks();
    setState(() {
      _tasksNoStart = _tasks.where((task) => DateTime.parse(task.startDate).isAfter(DateTime.now()));
      _priorityNoStartTasks = _tasksNoStart.where((task) => task.priority=="Elevée");
      _noPriorityNoStartTasks = _tasksNoStart.where((task) => task.priority=="Basse");

      _tasksFinished = _tasks.where((task) => DateTime.parse(task.endDate).isBefore(DateTime.now()));
      if(_tasksFinished.length>0) {
        _tasksFinished.forEach((task) {
          DateTime startDate = DateTime.parse(task.startDate);
          DateTime endDate = DateTime.parse(task.endDate);
          _timeSum += daysBetween(startDate, endDate);
        });
        _averageTime = (_timeSum/_tasksFinished.length).round();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accueil"),
      ),
      drawer: MyDrawer(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Column(
                children: [
                  ListTile(
                    title: Text("Nombre totale de tâches", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(_tasks.length.toString(), style: TextStyle(fontSize: 80,color: Colors.amber)),
                  )
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Tâches restantes à faire", style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(_tasksNoStart.length.toString(), style: TextStyle(fontSize: 80,color: Colors.lightBlueAccent)),
                    )
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Tâches prioritaires restantes à faire", style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(_priorityNoStartTasks.length.toString(), style: TextStyle(fontSize: 80, color: Colors.green)),
                    )
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Tâches non prioritaires restantes à faire", style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(_noPriorityNoStartTasks.length.toString(), style: TextStyle(fontSize: 80, color: Colors.red)),
                    )
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Durée moyenne des tâches déjà faites", style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(_averageTime.toString(), style: TextStyle(fontSize: 80, color: Colors.purple)),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
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
