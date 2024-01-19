import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../Models/NotesModel.dart';


class DbHelper {
  DbHelper._();
  static final DbHelper instance = DbHelper._();
  Database? _database;
  static const note_table = "notes";
  static const note_id = "note_id";
  static const note_desc = "note_desc";
  static const note_title = "note_title";
  Future<Database>getDb()async{
    if (_database != null) {
      return _database!;
    }
    else{
      return await initDb();
    }
  }
  Future<Database>initDb()async{
    Directory directory= await getApplicationDocumentsDirectory();
    var dbPath=join(directory.path+"notesdb.db");
    return openDatabase(dbPath,version: 1,onCreate:(db,version){
      return db.execute("Create table $note_table ( $note_id integer primary key autoincrement, $note_title text, $note_desc text )");
    });
  }
  insertNote(NotesModel notemodel)async{
    var db= await  getDb();
    db.insert(note_table,notemodel.toMap());
  }
  Future<List<NotesModel>>getData()async{
    var db=await getDb();
    List<NotesModel>listNotes=[];
    var data=await db.query(note_table);
    for(Map<String,dynamic>fatchdata in data){
      NotesModel notesModel=NotesModel.fromMap(fatchdata);
      listNotes.add(notesModel);
    }
    return listNotes;
  }
  Future<bool>updateNotes(NotesModel notes)async{
    var db=await getDb();
    var count=await db.update(note_table, notes.toMap(),where: "$note_id=${notes.id}");
    return count>0;


  }
  Future<bool> deleteNotes (int id)async {
    var db= await getDb();
    var count= await db.delete(note_table, where:" note_id=?",whereArgs:[id] );
    return count>0;
  }

}

