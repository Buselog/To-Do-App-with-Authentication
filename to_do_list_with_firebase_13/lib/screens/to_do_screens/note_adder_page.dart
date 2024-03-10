import 'package:flutter/material.dart';
import 'package:to_do_list_with_firebase_13/models/note.dart';
import 'package:to_do_list_with_firebase_13/screens/to_do_screens/home_page.dart';

class EditScreen extends StatefulWidget {
  final Note? note;
  const EditScreen({super.key, this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.note != null) {
      _titleController = TextEditingController(text: widget.note!.title);
      _contentController =
          TextEditingController(text: widget.note!.contentOfNote);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 45, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800.withOpacity(.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 40,
                      ),
                    ),
                    maxLines: 1,
                    controller: _titleController,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type something here...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 20,
                      ),
                    ),
                    maxLines: null,
                    controller: _contentController,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 19
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.grey.shade800.withOpacity(0.6),
      elevation: 5,
      onPressed: () {
        if(_titleController.text.isNotEmpty || _contentController.text.isNotEmpty){
          Navigator.pop(context, [_titleController.text, _contentController.text]);
        }
      },
      child: const Icon(
        Icons.save,
        color: Colors.white70,
      ),
    );
  }
}
