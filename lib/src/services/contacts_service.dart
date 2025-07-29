import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String tableContact = 'contact';
const String columnId = '_id';
const String columnName = 'name';
const String columnAddress = 'address';
const String columnLatitude = 'latitude';
const String columnLongitude = 'longitude';

class Contact {
  int? id;
  String name;
  String address;
  double latitude;
  double longitude;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{columnName: name, columnAddress: address, columnLatitude: latitude, columnLongitude: longitude};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Contact({this.id, required this.name, required this.address, required this.latitude, required this.longitude});

  Contact.fromMap(Map<dynamic, dynamic> map)
      : id = int.parse(map[columnId].toString()),
        name = map[columnName].toString(),
        address = map[columnAddress].toString(),
        latitude = double.parse(map[columnLatitude].toString()),
        longitude = double.parse(map[columnLongitude].toString());


  @override
  String toString() {
    return 'Contact(name: $name, address: $address, latitude: $latitude, longitude: $longitude)';
  }

}

ContactService contactService = ContactService();

class ContactService {
  late Database db;

  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table $tableContact ( 
          $columnId integer primary key autoincrement, 
          $columnName text not null,
          $columnAddress text not null,
          $columnLatitude real,
          $columnLongitude real)
        ''');
    });
  }

  Future<Contact> insert(Contact contact) async {
    contact.id = await db.insert(tableContact, contact.toMap());
    return contact;
  }

  Future<List<Contact>> getContacts() async {
    List<Map> maps = await db
        .query(tableContact, columns: [columnId, columnAddress, columnName, columnLatitude, columnLongitude]);
    return maps.map((map) => Contact.fromMap(map)).toList();
  }

  Future<int> delete(int id) async {
    return await db
        .delete(tableContact, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Contact contact) async {
    return await db.update(tableContact, contact.toMap(),
        where: '$columnId = ?', whereArgs: [contact.id]);
  }

  Future close() async => db.close();
}
