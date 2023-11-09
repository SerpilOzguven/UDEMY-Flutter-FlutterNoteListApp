import 'package:flutter/material.dart';
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
        onPressed: () {},
        child: const Icon(
          FontAwesomeIcons.plus,
          size: 26,
        ),
      ),
      body: ListView.builder(itemCount: 4, itemBuilder: (context,index){
        return  GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NotesPage());
          },
          child: const ListTile(
            title: Text('Ev Esyalari', style: TextStyle(fontSize: 18),),
            leading: FaIcon(FontAwesomeIcons.penToSquare,size: 22,),
            trailing: FaIcon(FontAwesomeIcons.trashCan,size: 22,),
          ),
        );
      }),
    ) ;
  }


}
