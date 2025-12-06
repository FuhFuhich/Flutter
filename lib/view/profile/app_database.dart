import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();                
  TextColumn get name => text().withLength(min: 1, max: 100)();    
  TextColumn get email =>
      text().withLength(min: 3, max: 200).unique()();              
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();                
  BoolColumn get isActive =>
      boolean().withDefault(const Constant(true))();              
}

class Projects extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 150)();
  TextColumn get description => text().nullable()();
  IntColumn get ownerId =>
      integer().references(Users, #id)();                          
  DateTimeColumn get deadline => dateTime().nullable()();
  IntColumn get priority =>
      integer().withDefault(const Constant(0))();                 
}

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  TextColumn get details => text().nullable()();
  IntColumn get projectId =>
      integer().references(Projects, #id)();                       
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isCompleted =>
      boolean().withDefault(const Constant(false))();
}

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get colorHex =>
      text().withDefault(const Constant('#FFFFFF'))();             // Цвет тега
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}

// Связующая таблица задач и тегов (многие‑ко‑многим)
class TaskTags extends Table {
  IntColumn get taskId =>
      integer().references(Tasks, #id)();                          // FK на задачу
  IntColumn get tagId =>
      integer().references(Tags, #id)();                           // FK на тег

  @override
  Set<Column> get primaryKey => {taskId, tagId};                   // Составной PK
}
