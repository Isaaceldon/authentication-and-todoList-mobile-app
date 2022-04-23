import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'database_service.dart';
import 'task.dart';
import 'task_list.dart';

class EditTask extends StatefulWidget {

  Task task;

  EditTask({Key? key, required this.task}) : super(key: key);

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _priority;
  late DateTime _startDate;
  late DateTime _endDate;
  final _startDateController  = TextEditingController();
  final _endDateController = TextEditingController();

  _loadTask(){
    if(widget.task != null){
      setState(() {
        _nameController.text = widget.task.name;
        _descriptionController.text = widget.task.description;
        _priority = widget.task.priority;
        _startDateController.text = widget.task.startDate;
        _endDateController.text = widget.task.endDate;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Modification de tâche"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Modifier une tâche", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                const SizedBox(
                  height: 40,
                ),
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
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                            icon: Icon(Icons.priority_high),
                            hintText: "Priorité de la tâche",
                            labelText: "Priorité *"
                        ),
                        value: _priority,
                        items: <String>['Basse', 'Moyenne', 'Elevée'].map<DropdownMenuItem<String>>((String value){
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: const TextStyle(color: Colors.black),),
                          );
                        }).toList(),
                        onChanged: (String? v) async{
                          setState(() {
                            _priority = v;
                          });
                        },
                        validator: (str) => str==null ? "This field is required" : null,
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
                              _startDateController.text = DateFormat('yyyy-MM-dd').format(_startDate);
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
                              _endDateController.text = DateFormat('yyyy-MM-dd').format(_endDate);
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
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if(_formKey.currentState!.validate()) {
                            DatabaseService dbService = DatabaseService();
                            await dbService.updateTask(Task(id: widget.task.id,
                                name: _nameController.text,
                                description: _descriptionController.text,
                                priority: _priority!,
                                startDate: _startDateController.text,
                                endDate: _endDateController.text
                            ));
                            Fluttertoast.showToast(
                              msg: "La tâche a été modifiée avec succès",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                            );
                          }
                        },
                        child: Text('Modifier')
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const TaskList()),
                          );
                        },
                        child: Text("Liste des tâches")
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
