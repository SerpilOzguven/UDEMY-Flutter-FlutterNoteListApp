import 'package:flutter/material.dart';
import 'package:flutter_note_list/model/category_model.dart';
import 'package:flutter_note_list/service/database_helper.dart';
import 'package:flutter_note_list/ui/notes_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Not Defterim'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dialog('add');
        },
        child: const Icon(
          FontAwesomeIcons.plus,
          size: 26,
        ),
      ),
      body: FutureBuilder<List<CategoryModel>?>(future: DatabaseHelper.instance.getCategories(),
          builder:(context,snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
                );
            } else {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Kategori yok'),
                );
              } else {
                return ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                    CategoryModel category = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (
                          context) => const NotesPage()));
                    },
                    child: ListTile(
                      title:   Text(
                        category.category!,
                        style: TextStyle(fontSize: 18),),
                      leading: GestureDetector(onTap: () {
                        dialog(false);
                      }, child: const FaIcon(FontAwesomeIcons.penToSquare,
                        size: 22,)),
                      trailing: GestureDetector(onTap: () {

                      }, child: const FaIcon(FontAwesomeIcons.trashCan,
                        size: 22,)),
                    ),
                  );
                });
              }
            }
          }),
    ) ;
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