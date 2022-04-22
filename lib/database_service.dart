import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'task.dart';
import 'task_list.dart';

class DatabaseService {

  _initDatabase () async {
    //await deleteDatabase(join(await getDatabasesPath(), 'tasks_database.db'));
    // Open the database and store the reference.
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'tasks_database.db'),
      // When the database is first created, create a table to store Tasks.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, description TEXT, priority TEXT, startDate TEXT, endDate TEXT)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  // Define a function that inserts Tasks into the database
  Future<void> insertTask(Task task) async {

    Database database = await _initDatabase();

    // Insert the Task into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same Task is inserted twice.
    //
    // In this case, replace any previous data.
    await database.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTask(Task task) async {

    Database database = await _initDatabase();

    await database.update(
      'tasks',
      task.toMap(),
      // Ensure that the Task has a matching id.
      where: 'id = ?',
      // Pass the Task's id as a whereArg to prevent SQL injection.
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(Task task) async {

    Database database = await _initDatabase();

    // Remove the Task from the database.
    await database.delete(
      'tasks',
      // Use a `where` clause to delete a specific Task.
      where: 'id = ?',
      // Pass the Task's id as a whereArg to prevent SQL injection.
      whereArgs: [task.id],
    );
  }

  // A method that retrieves all the Tasks from the Tasks table.
  Future<List<Task>> fetchTasks() async {
    // Get a reference to the database.
    Database database = await _initDatabase();

    // Query the table for all The Tasks.
    final List<Map<String, dynamic>> maps = await database.query('tasks');

    // Convert the List<Map<String, dynamic> into a List<Task>.
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        priority: maps[i]['priority'],
        startDate: maps[i]['startDate'],
        endDate: maps[i]['endDate'],
      );
    });
  }

  Future<Task?> getTaskById(int id) async {

    Database database = await _initDatabase();

    // Remove the Task from the database.
    final List<Map<String, dynamic>> maps = await database.query(
      'tasks',

      limit: 1,
      // Use a `where` clause to delete a specific Task.
      where: 'id = ?',
      // Pass the Task's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return new Task(
        id: maps[0]['id'],
        name: maps[0]['name'],
        description: maps[0]['description'],
        priority: maps[0]['priority'],
        startDate: maps[0]['startDate'],
        endDate: maps[0]['endDate'],
      );
    }
    return null;
  }

}