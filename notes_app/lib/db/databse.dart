import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:notes_app/models/notes_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Database {
  final Future<Database> database;
  Database(this.database);
}
