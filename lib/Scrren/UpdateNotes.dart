import 'package:bloc_notes_app/Bloc/NotesEvents.dart';
import 'package:bloc_notes_app/Bloc/NotesState.dart';
import 'package:bloc_notes_app/Bloc/Notes_Bloc.dart';
import 'package:bloc_notes_app/Widget/uihelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateNotes extends StatefulWidget {
  String title;
  String desc;
  int ? id;


  UpdateNotes({super.key,required this.id,required this.title,required this.desc });


  @override
  State<UpdateNotes> createState() => _UpdateNotesState();
}


class _UpdateNotesState extends State<UpdateNotes> {
  TextEditingController UpdatetitleController = TextEditingController();
  TextEditingController UpdatedescController = TextEditingController();
  @override
  void initState() {
    UpdatetitleController=TextEditingController(text: widget.title);
    UpdatedescController = TextEditingController(text: widget.desc);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc,NotesState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Updates Notes"),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UiHelper.CustomTextField(
                  UpdatetitleController, "${widget.title}",
                  Icons.title_rounded),
              UiHelper.CustomTextField(UpdatedescController, "${widget.desc}",
                  Icons.description_outlined),
              SizedBox(
                  height: 30),
              ElevatedButton(onPressed: () {
                BlocProvider.of<NotesBloc>(context).add(UpdateEvents(id: widget.id!, title:UpdatetitleController.text.toString(), desc: UpdatedescController.text.toString(), ));
                Navigator.pop(context,{
                  'noteid':widget.id,
                  'notetitle':UpdatetitleController.text,
                  'notedesc':UpdatedescController.text,
                });
              }, child: Text("UpdateNotes"))
            ],
          ),
        );
      }
    );
  }
}
