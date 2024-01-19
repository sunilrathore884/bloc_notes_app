import '../Models/NotesModel.dart';

abstract class NotesState {}

class InitalState extends NotesState {}

class LoadingState extends NotesState {}

class LoadedState extends NotesState {
  List<NotesModel> arrnotes;
  LoadedState({required this.arrnotes});
}

class ErrorState extends NotesState {
  String errormsg;
  ErrorState({required this.errormsg});
}
