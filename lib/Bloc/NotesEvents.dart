import 'package:bloc_notes_app/Models/NotesModel.dart';
import 'package:flutter/cupertino.dart';

abstract class NotesEvents {}

class AddNotesEvents extends NotesEvents {
  NotesModel newnotes;
  AddNotesEvents({required this.newnotes});
}

class FatchEvents extends NotesEvents {}

class UpdateEvents extends NotesEvents {
  int ? id;
  String title;
  String desc;

  UpdateEvents({required this.id, required this.title, required this.desc});
}
 class DeleteEvents extends NotesEvents{
  int id;
  DeleteEvents({required this.id});
 }
