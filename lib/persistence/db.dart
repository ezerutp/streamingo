import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('streamingo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE clientes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        telefono TEXT,
        email TEXT,
        deleted INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE servicios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        descripcion TEXT,
        imagenUrl TEXT,
        disponible INTEGER DEFAULT 1,
        deleted INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE tipo_servicios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        descripcion TEXT,
        servicioId INTEGER NOT NULL,
        precio REAL NOT NULL,
        duracionDias INTEGER NOT NULL,
        deleted INTEGER DEFAULT 0,
        FOREIGN KEY (servicioId) REFERENCES servicios (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE ventas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        clienteId INTEGER NOT NULL,
        tipoServicioId INTEGER NOT NULL,
        fechaInicio TEXT NOT NULL,
        fechaFin TEXT NOT NULL,
        monto REAL NOT NULL,
        cancelado INTEGER DEFAULT 0,
        deleted INTEGER DEFAULT 0,
        FOREIGN KEY (clienteId) REFERENCES clientes (id),
        FOREIGN KEY (tipoServicioId) REFERENCES tipo_servicios (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE venta_historial (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ventaId INTEGER NOT NULL,
        fechaPago TEXT NOT NULL,
        fechaInicio TEXT NOT NULL,
        fechaFin TEXT NOT NULL,
        montoPagado REAL NOT NULL,
        FOREIGN KEY (ventaId) REFERENCES ventas (id)
      )
    ''');
  }
}
