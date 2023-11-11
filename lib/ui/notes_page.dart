// TODO Implement this library.import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_note_list/model/note_model.dart';
import 'package:flutter_note_list/service/database_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotesPage extends StatefulWidget {
  final id;
  NotesPage({Key? key,this.id}): super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  var liste = [0xfff28c8f, 0xfff2b8a4, 0xff558fa7, 0xff2d6073];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Not Sayfasi', style:TextStyle(color: Colors.black),),
        backgroundColor:Colors.white,
        elevation: 0,
        iconTheme:  const IconThemeData(color: Colors.black),
        actions: [    Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              onPressed: () {
                dialog('add');
              },
              icon: FaIcon(
                FontAwesomeIcons.plus,
                color: Colors.red.shade500,
              )),
        ),

        ],
      ),
      body: FutureBuilder<List<NoteModel>>(future: DatabaseHelper.instance.getNote(widget.id) ,builder: (context, snapshot){
        if(!snapshot.hasData){
          return const Center(child: CircularProgressIndicator(),);

        }else{
          if(snapshot.data!.isEmpty){
            return const Center(child: Text('Henuz notumuz yok'),);

        }else{
            return GridView.builder(
              padding:  const EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (context,index) {
                NoteModel oneNote = snapshot.data!.[index];
              return GestureDetector(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (context)=>AlertDialog(
                    actions: [
                      ElevatedButton(
                        onPressed: (){
                        back();
                        dialog('edit');
                      },
                      child: const Text('Guncelle'),
                      ),
                      ElevatedButton(
                        onPressed: (){
                        back();
                        dialog('delete');

                      },
                      child: const Text('Sil'),
                      ),
                      ElevatedButton(
                        onPressed: (){
                        back();
                        },
                      child: const Text('Vazgec'),
                      ),
                      ],
                    ));
                  },
                  child: Container(
                    padding:  const EdgeInsets.all(10),
                    color: Color(liste[index % 4]),
                    child:  Text(
                      oneNote.note!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    ),
                  ),
                );
              }
              );
            }
        }
      }),
    );
  }
  dialog(result) {
    if (result == 'edit') {
      return showDialog(
          context: context,
          builder: (context) =>AlertDialog(
            title: TextFormField(
              decoration:
              const InputDecoration(border: OutlineInputBorder()),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {},
                  child: const Text('Kaydet')),
              ElevatedButton(onPressed: () {
                back();
              },
                child: const Text('delete'),
              ),
            ],
          ));
    } else if (result == 'delete') {
      return showDialog(context: context,
          builder: (context) =>
              AlertDialog(
                title: const Text('Emin misiniz?'),
                actions: [
                  ElevatedButton(onPressed: () {}, child: const Text('Sil'),),
                  ElevatedButton(onPressed: () {
                    back();
                  },
                    child: const FaIcon(FontAwesomeIcons.trashCan,
                      size: 22,),
                  ),
                ],
              ));
    } else {
      return showDialog(context: context,
          builder: (context) =>
              AlertDialog(
                title : const Text('Kategori Giriniz'),
                content: TextFormField(decoration: const InputDecoration(border: OutlineInputBorder()),),

                actions: [
                  ElevatedButton(onPressed: () {}, child: const Text('Ekle'),),
                  ElevatedButton(onPressed: () {
                    back();
                  },
                    child: const FaIcon(FontAwesomeIcons.trashCan,
                      size: 22,),
                  ),
                ],
              ));
    }

  }
  back(){
    Navigator.of(context).pop();
  }
}
