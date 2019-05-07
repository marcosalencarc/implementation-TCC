import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
final String sensorReadTable = "sensorReadTable";
final String idColumn = "idColumn";
final String idStationColumn = "idStationColumn";
final String umidadeArColumn = "umidadeArColumn";
final String umidadeSoloColumn = "umidadeSoloColumn";
final String temperaturaColumn = "temperaturaColumn";
final String isChuvaColumn = "isChuvaColumn";
final String statusColumn = "statusColumn";


class SensorRead{
  int id;
  int idStation;
  int umidadeAr;
  double temperatura;
  int isChuva;
  int umidadeSolo;
  bool status;

  SensorRead({this.idStation,this.umidadeAr,this.temperatura, this.isChuva,this.umidadeSolo});

  SensorRead.fromMap(Map map){
    id = map[idColumn];
    idStation = map[idStationColumn];
    umidadeAr = map[umidadeArColumn];
    temperatura = map[temperaturaColumn];
    isChuva = map[isChuvaColumn];
    umidadeSolo = map[umidadeSoloColumn];
    status = map[statusColumn] == 0 ? false : true;

  }

  Map toMap() {
    Map<String, dynamic> map = {
      idStationColumn: idStation,
      umidadeArColumn: umidadeAr,
      temperaturaColumn: temperatura,
      isChuvaColumn: isChuva,
      umidadeSoloColumn: umidadeSolo,
      statusColumn: status == false ? 0 : 1
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "{\nid: $id,\n idStation: $idStation,\n umidadeAr: $umidadeAr,\n "
        "temperatura: $temperatura,\n isChvuva: ${isChuva == 0 ? "SIM":"NÃO"},\n umidadeSolo: $umidadeSolo,\n status: $status\n}";
  }

}


class SensorReadHelper {

  static final SensorReadHelper _instance = SensorReadHelper.internal();

  factory SensorReadHelper() => _instance;

  SensorReadHelper.internal();

  Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "SensorRead.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $sensorReadTable($idColumn INTEGER PRIMARY KEY, $idStationColumn INTEGER, $umidadeArColumn INTEGER,"
              "$temperaturaColumn REAL,$isChuvaColumn INTEGER, $umidadeSoloColumn INTEGER, $statusColumn INTEGER)"
      );
    });
  }

  Future<SensorRead> saveSensorRead(SensorRead SensorRead) async {
    Database dbSensorRead = await db;
    SensorRead.id = await dbSensorRead.insert(sensorReadTable, SensorRead.toMap());
    return SensorRead;
  }

  Future<SensorRead> getSensorRead(int id) async {
    Database dbSensorRead = await db;
    List<Map> maps = await dbSensorRead.query(sensorReadTable,
        columns: [idColumn, idStationColumn, umidadeArColumn, temperaturaColumn,isChuvaColumn,umidadeSoloColumn, statusColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if(maps.length > 0){
      return SensorRead.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteSensorRead(int id) async {
    Database dbSensorRead = await db;
    return await dbSensorRead.delete(sensorReadTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> deleteAll() async{
    Database dbSensorRead = await db;
    getAllSensorReads().then((value){
      for(SensorRead r in value){
        deleteSensorRead(r.id);
      }
    });
    return 1;
  }

  Future<int> updateSensorRead(SensorRead SensorRead) async {
    Database dbSensorRead = await db;
    return await dbSensorRead.update(sensorReadTable,
        SensorRead.toMap(),
        where: "$idColumn = ?",
        whereArgs: [SensorRead.id]);
  }

  Future<List> getAllSensorReads() async {
    Database dbSensorRead = await db;
    List listMap = await dbSensorRead.rawQuery("SELECT * FROM $sensorReadTable");
    List<SensorRead> listSensorRead = List();
    for(Map m in listMap){
      listSensorRead.add(SensorRead.fromMap(m));
    }
    return listSensorRead;
  }

  Future<int> getNumber() async {
    Database dbSensorRead = await db;
    return Sqflite.firstIntValue(await dbSensorRead.rawQuery("SELECT COUNT(*) FROM $sensorReadTable"));
  }

  Future<int> getNumNotSend() async {
    Database dbSensorRead = await db;
    return Sqflite.firstIntValue(await dbSensorRead.rawQuery("SELECT COUNT(*) FROM $sensorReadTable WHERE $statusColumn =?",[0]));
  }

  Future close() async {
    Database dbSensorRead = await db;
    dbSensorRead.close();
  }

}