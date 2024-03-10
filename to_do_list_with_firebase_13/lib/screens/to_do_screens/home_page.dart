import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_firebase_13/models/card.dart';
import 'package:to_do_list_with_firebase_13/screens/to_do_screens/note_adder_page.dart';
import 'package:to_do_list_with_firebase_13/services/auth.dart';
import 'package:to_do_list_with_firebase_13/services/on_board.dart';
import '../../models/note.dart';
import '../../models/note_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool sorted = false;

  List<Note> sortNotesByModifiedTime(List<Note> notes) {
    if (sorted) {
      notes.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    } else {
      notes.sort((b, a) => a.modifiedTime.compareTo(b.modifiedTime));
    }

    sorted = !sorted;

    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 35, 16, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Notes',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              sortNotesByModifiedTime(
                                  Provider.of<NoteData>(context, listen: false)
                                      .noteExample);
                            });
                          },
                          icon: const Icon(
                            Icons.short_text,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: const Text('Çıkış Yap'),
                              onTap: () {
                                Provider.of<Auth>(context, listen: false)
                                    .signOut();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const OnBoard(),
                                  ),
                                );
                              },
                            ),
                          ],
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white38,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Consumer<NoteData>(
                  builder: (context, NoteDataProvide, child) => Align(
                    alignment:
                        Alignment.topCenter, //yukarıdan aşağı bir görüntü
                    child: ListView.builder(
                      shrinkWrap:
                          true, // Listview'in minimum yer almasını sağlar
                      reverse: true, //yukarıdan ekleme etkin

                      itemCount: NoteDataProvide.noteExample.length,
                      itemBuilder: (context, index) => CardExample(
                        id: NoteDataProvide.noteExample[index].id,
                        title: NoteDataProvide.noteExample[index].title,
                        contentOfNote:
                            NoteDataProvide.noteExample[index].contentOfNote,
                        modifiedTime:
                            NoteDataProvide.noteExample[index].modifiedTime,
                        index: index,
                        isDone: NoteDataProvide.noteExample[index].isDone,
                        deleteNote: (_) {
                          NoteDataProvide.deleteNote(index);
                        },
                        toggleStatus: (_) {
                          NoteDataProvide.toggleStatus(index);
                        },
                        deleteNoteforIcon: () {
                          NoteDataProvide.deleteNoteforIcon(index);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EditScreen(),
          ),
        );
        if (result != null) {
          setState(() {
            Provider.of<NoteData>(context, listen: false)
                .addNewNote(result[0], result[1]);
          });
        }
      },
      backgroundColor: Colors.grey.shade800,
      elevation: 5,
      child: const Icon(
        Icons.add,
        color: Colors.white54,
        size: 25,
      ),
    );
  }
}
