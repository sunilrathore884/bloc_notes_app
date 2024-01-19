import 'package:bloc_notes_app/Bloc/NotesEvents.dart';
import 'package:bloc_notes_app/Bloc/NotesState.dart';
import 'package:bloc_notes_app/Bloc/Notes_Bloc.dart';
import 'package:bloc_notes_app/Models/NotesModel.dart';
import 'package:bloc_notes_app/Widget/uihelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();

}

class _AddDataState extends State<AddData> {
  TextEditingController titileController = TextEditingController();
  TextEditingController descController = TextEditingController();

  DateTime date = DateTime.now();
//  String formattedDate=DateFormat("kk:mm:ss\n DD MM YYYY").format.now();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("AddData"),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${date}'),
              UiHelper.CustomTextField(
                  titileController, "Enter Titlle", Icons.title_rounded),
              UiHelper.CustomTextField(descController, "Enter Descreption",
                  Icons.description_rounded),
              SizedBox(height: 30, ),
              ElevatedButton(onPressed: (){
                var title=titileController.text.toString();
                var desc= descController.text.toString();
                if(title==""&& desc==""){
                   showDialog(context: context,builder:(BuildContext context){
                    return AlertDialog(
                      title: Text("Enter Required Fields"),
                      actions: [
                        TextButton(onPressed: (){}, child: Text("ok"))
                      ],);
                  });
                }
                else{
                  BlocProvider.of<NotesBloc>(context).add(AddNotesEvents(newnotes:NotesModel(title: title,desc: desc)));
                  context.read<NotesBloc>().dbHelper.getData();
                  Navigator.pop(context);
                }

              }, child: Text("Add Data"))
            ],
          ),
        );
      },
    );
  }
}
