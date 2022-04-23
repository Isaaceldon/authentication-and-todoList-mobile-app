import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'database_service.dart';
import 'task.dart';
import 'task_list.dart';

class ShowTask extends StatefulWidget {

  Task task;

  ShowTask({Key? key, required this.task}) : super(key: key);

  @override
  State<ShowTask> createState() => _ShowTaskState();
}

class _ShowTaskState extends State<ShowTask> {

  _control(){
    DateTime startDate = DateTime.parse(widget.task.startDate);
    DateTime endDate = DateTime.parse(widget.task.endDate);
    DateTime nowDate = DateTime.now();
    if(nowDate.isAfter(endDate)){
      //Task terminé
      return Container();
    }else if(nowDate.isBefore(endDate) && nowDate.isAfter(startDate)){
      //Task en cour
      return ElevatedButton(
          onPressed: () async {
            setState(() {
              widget.task = Task(id: widget.task.id,
                  name: widget.task.name,
                  description: widget.task.description,
                  priority: widget.task.priority,
                  startDate: widget.task.startDate,
                  endDate: DateFormat('yyyy-MM-dd').format(DateTime.now())
              );
            });
            DatabaseService dbService = DatabaseService();
            await dbService.updateTask(widget.task);
          },
          child: Text('Terminer la tâche')
      );
    }else{
      //Task no start
      return ElevatedButton(
          onPressed: () async {
            setState(() {
              widget.task = Task(id: widget.task.id,
                  name: widget.task.name,
                  description: widget.task.description,
                  priority: widget.task.priority,
                  startDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  endDate: widget.task.endDate
              );
            });
            DatabaseService dbService = DatabaseService();
            await dbService.updateTask(widget.task);
          },
          child: Text('Commencer la tâche')
      );
    }
  }

  _status(){
    DateTime startDate = DateTime.parse(widget.task.startDate);
    DateTime endDate = DateTime.parse(widget.task.endDate);
    DateTime nowDate = DateTime.now();
    if(nowDate.isAfter(endDate)){
      //Task terminé
      return Text("Tâche terminée", style: TextStyle(fontSize: 18, color: Colors.red));
    }else if(nowDate.isBefore(endDate) && nowDate.isAfter(startDate)){
      //Task en cour
      return Text("Tâche en cours", style: TextStyle(fontSize: 18, color: Colors.green));
    }else{
      //Task no start
      return Text("Tâche non débutée", style: TextStyle(fontSize: 18, color: Colors.orange));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Details de la tâche"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nom", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Column(
                        children: [
                          ListTile(
                              title: Text(widget.task.name, style: TextStyle(fontSize: 18))
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Column(
                        children: [
                          ListTile(
                              title: Text(widget.task.description, style: TextStyle(fontSize: 18))
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Priorité", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Column(
                        children: [
                          ListTile(
                              title: Text(widget.task.priority, style: TextStyle(fontSize: 18))
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date de début", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Column(
                        children: [
                          ListTile(
                              title: Text(widget.task.startDate, style: TextStyle(fontSize: 18))
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date de fin", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Column(
                        children: [
                          ListTile(
                              title: Text(widget.task.endDate, style: TextStyle(fontSize: 18))
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Statut", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Column(
                        children: [
                          ListTile(
                              title: _status()
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _control(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TaskList()),
                      );
                    },
                    child: Text("Liste des tâches")
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
