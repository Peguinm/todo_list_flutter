//* Class persistent, só uma vez criada e somente uma única viva

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:to_do_list/app/core/database/migrations/migration.dart';
import 'package:to_do_list/app/core/database/sqlite_migration_factory.dart';

class SqliteConnectionFactory {
  //* instance
  static SqliteConnectionFactory? _instance;

  //* database
  static const String _DATABASE_NAME = 'TO_DO_LIST';
  static const int _VERSION = 1;

  Database? _db;
  final _lock = Lock(); //

  //* main builder
  SqliteConnectionFactory._private();

  factory SqliteConnectionFactory() {
    if (_instance == null) {
      _instance = SqliteConnectionFactory._private();
    }

    //* com certeza uma instance vai ser retornada
    return _instance!;
  }

  //* criando conexão
  Future<Database> openConnection() async {
    String databasePath = await getDatabasesPath();
    final String databasePathFinal = join(databasePath, _DATABASE_NAME);

    if (_db == null) {
      //* garantindo que não vai acontecer mais que uma chamada para connect
      await _lock.synchronized(() async {
        _db = await openDatabase(
          databasePathFinal,
          version: _VERSION,
          onConfigure: _onConfigure,
          onCreate: _onCreate,
          onDowngrade: _onDowngrade,
          onUpgrade: _onUpgrade,
        );
      });
    }
    return _db!;
  }

  //* fechando a connection
  void closeConnection() {
    _db?.close();
    _db = null;
  }

  //* métodods de abertura do db
  Future<void> _onConfigure(Database db) async {
    //ligando as foreign keys
    await db.execute('PRAGMA foreign_keys on');
  }
  Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();

    //dando get em todas as migrations de criação que precisam ser executadas
    final List<Migration> listMigrations = SqliteMigrationFactory().getCreateMigratios();

    //executando a criação das migrations 
    for (Migration migration in listMigrations) {
      migration.create(batch);
    }

    batch.commit();
  }
  
  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {
    //mesma estrutura de cima
    final batch = db.batch();

    List<Migration> listMigrations = SqliteMigrationFactory().getUpdateMigrations(oldVersion);
    for (Migration migration in listMigrations) {
      migration.update(batch);
    }
    
    batch.commit();
  }

  Future<void> _onDowngrade(Database db, int oldVersion, int version) async {}
}
