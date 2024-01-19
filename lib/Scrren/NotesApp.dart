import 'dart:math';

import 'package:bloc_notes_app/Bloc/NotesEvents.dart';
import 'package:bloc_notes_app/Bloc/NotesState.dart';
import 'package:bloc_notes_app/Bloc/Notes_Bloc.dart';
import 'package:bloc_notes_app/Models/NotesModel.dart';
import 'package:bloc_notes_app/Scrren/AddData.dart';
import 'package:bloc_notes_app/Scrren/UpdateNotes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NotesApp"),
        centerTitle: true,
      ),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              child: GridView.custom(
                gridDelegate: SliverWovenGridDelegate.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  pattern: [
                    WovenGridTile(1),
                    WovenGridTile(
                      5 / 7,
                      crossAxisRatio: 0.9,
                      alignment: AlignmentDirectional.centerEnd,
                    ),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate((context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateNotes
                        (title:state.arrnotes![index].title,desc:state.arrnotes![index].desc,id:state.arrnotes![index].id))).then((value){
                          if(value!=null){
                            int nid=value['noteid'];
                            String ntitle =value['notetitle'];
                            String ndesc=value['notedesc'];
                            BlocProvider.of<NotesBloc>(context).add(AddNotesEvents(newnotes: NotesModel(title: ntitle, desc: ndesc,id: nid)));
                          }
                      });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAlias,
                        height: 230,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Stack(
                          children: [
                            ListTile(
                              title: Text(state.arrnotes[index].title),
                              subtitle: Text(state.arrnotes[index].desc),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () {
                                  context.read<NotesBloc>().add(DeleteEvents(id: state.arrnotes[index].id!));
                                },
                                icon: Icon(Icons.delete),
                              ),
                            )
                          ],
                        )),
                  );
                }, childCount: state.arrnotes.length),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddData()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
