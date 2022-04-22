import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'task_list.dart';
import 'database_service.dart';
import 'task.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priorityController = TextEditingController();
  late DateTime _startDate;
  late DateTime _endDate;
  final _startDateController  = TextEditingController();
  final _endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Nouvelle tâche"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Ajouter une tâche", style: TextStyle(fontWeight: FontWeight.bold),),
              Form(
                key: _formKey,
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: "Le nom de la tâche",
                          labelText: "Nom *"
                      ),
                      validator: (String? value) {
                        return (value == null || value == "") ?
                        "Ce champ est obligatoire" : null;
                      },
                    ),

                    TextFormField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          icon: Icon(Icons.description),
                          hintText: "Description de la tâche",
                          labelText: "Description *"
                      ),
                      validator: (String? value) {
                        return (value == null || value == "") ?
                        "Ce champ est obligatoire" : null;
                      },
                    ),
                    TextFormField(
                      controller: _priorityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          icon: Icon(Icons.priority_high),
                          hintText: "Priorité de la tâche",
                          labelText: "Priorité *"
                      ),
                      validator: (String? value) {
                        return (value == null || value == "") ?
                        "Ce champ est obligatoire" : null;
                      },
                    ),

                    TextFormField(
                      readOnly: true,
                      controller: _startDateController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          hintText: "Date de début de la tâche",
                          labelText: "Date de début *"
                      ),
                      onTap: () async {
                        DateTime? startDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1980),
                            lastDate: DateTime(2050)
                        );
                        setState(() {
                          if(startDate!=null){
                            _startDate = startDate;
                            _startDateController.text = DateFormat('dd-MM-yyyy').format(_startDate);
                          }
                        });
                      },
                      validator: (String? value) {
                        return (value == null || value == "") ?
                        "Ce champ est obligatoire" : null;
                      },
                    ),


                    TextFormField(
                      readOnly: true,
                      controller: _endDateController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          hintText: "Date de début de la tâche",
                          labelText: "Date de début *"
                      ),
                      onTap: () async {
                        DateTime? endDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1980),
                            lastDate: DateTime(2050)
                        );
                        setState(() {
                          if(endDate!=null){
                            _endDate = endDate;
                            _endDateController.text = DateFormat('dd-MM-yyyy').format(_endDate);
                          }
                        });
                      },
                      validator: (String? value) {
                        return (value == null || value == "") ?
                        "Ce champ est obligatoire" : null;
                      },
                    ),

                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()) {
                      DatabaseService dbService = DatabaseService();
                      await dbService.insertTask(
                          Task(name: _nameController.text,
                              description: _descriptionController.text,
                              priority: _priorityController.text,
                              startDate: _startDateController.text,
                              endDate: _endDateController.text
                          ));
                      Fluttertoast.showToast(
                        msg: "La tâche a été enregistrée avec succès",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                      );
                      _nameController.text = "";
                      _descriptionController.text = "";
                      _priorityController.text = "";
                      _startDateController.text = "";
                      _endDateController.text = "";
                    }
                  },
                  child: Text('Enregistrer')
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TaskList()),
                    );
                  },
                  child: Text("Liste des contacts")
              )
            ],
          ),
        ),
      ),

    );
  }
}
