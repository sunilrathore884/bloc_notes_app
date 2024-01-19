import 'package:bloc_notes_app/Bloc/NotesEvents.dart';
import 'package:bloc_notes_app/Bloc/NotesState.dart';
import 'package:bloc_notes_app/Database/DbHelper.dart';
import 'package:bloc_notes_app/Models/NotesModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class NotesBloc extends Bloc<NotesEvents,NotesState>{
DbHelper dbHelper;
NotesBloc({required this.dbHelper}):super(InitalState()) {
    on<AddNotesEvents>((event, emit) async {
    emit(LoadingState());
     await dbHelper.insertNote(event.newnotes);

      var arrnotes = await dbHelper.getData();
      emit(LoadedState(arrnotes: arrnotes));
  });
  on<DeleteEvents>(((event, emit)async {
    emit (LoadingState());
    await dbHelper.deleteNotes(event.id);
   var arrnotes= await dbHelper.getData();
    emit(LoadedState(arrnotes: arrnotes));
  }));

  on<UpdateEvents>((event,emit)async{
    emit(LoadingState());
    await dbHelper.updateNotes(NotesModel(id: event.id,title:event.title,desc : event.desc) );
    var arrNotes = await dbHelper.getData();
    emit(LoadedState(arrnotes: arrNotes));
  });
}
}