import 'package:employee_app/features/employee_managment/data/model/employee.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db; // Make this private to control access

  DatabaseHelper._instance();

  final tableName = 'employees';
  final id = 'id';
  final employeeName = 'employeeName';
  final role = 'role';
  final startDate = 'startDate';
  final endDate = 'endDate';

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = '${documentsDirectory.path}/employees.db';

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $employeeName TEXT NOT NULL,
            $role TEXT NOT NULL,
            $startDate INTEGER NOT NULL,
            $endDate INTEGER
          )
        ''');
      },
    );
  }

  Future<Employee> add(Employee employee) async {
    final db = await database; // Ensure db is initialized
    employee.id = await db.insert(tableName, employee.toJson());
    return employee;
  }

  Future<List<Employee>> fetch() async {
    final db = await database; // Ensure db is initialized
    final maps = await db.query(tableName);

    print(maps);
    return List.generate(maps.length, (i) {
      return Employee.fromJson(Map<String, dynamic>.from(maps[i]));
    });
  }

  Future<Employee> update(Employee employee) async {
    final db = await database; // Ensure db is initialized
    await db.update(tableName, employee.toJson(),
        where: '$id = ?', whereArgs: [employee.id]);
    return employee;
  }

  Future<Employee> delete(int empId) async {
    final db = await database; // Ensure db is initialized
    Employee? employee = await fetchSingle(empId);
    if (employee != null) {
      await db.delete(
        tableName,
        where: '$id = ?',
        whereArgs: [empId],
      );
      return employee;
    }
    throw Exception('Employee not found');
  }

  Future<Employee?> fetchSingle(int employeeId) async {
    final db = await database; // Ensure db is initialized
    final maps = await db.query(
      tableName,
      where: '$id = ?',
      whereArgs: [employeeId],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return Employee.fromJson(Map<String, dynamic>.from(maps.first));
    } else {
      return null;
    }
  }
}
