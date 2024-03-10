// ignore_for_file: must_be_immutable

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_firebase_13/models/note.dart';
import 'package:to_do_list_with_firebase_13/screens/to_do_screens/note_adder_page.dart';
import '../constants/card_colors.dart';
import 'note_data.dart';

class CardExample extends StatefulWidget {
  int? id;
  int? index;
  String? title;
  String? contentOfNote;
  DateTime modifiedTime;
  bool isDone;
  Function(void)? toggleStatus;
  Function(DismissDirection)? deleteNote;
  void Function()? deleteNoteforIcon;

  CardExample({
    this.id,
    this.index,
    required this.title,
    required this.contentOfNote,
    required this.modifiedTime,
    required this.isDone,
    this.toggleStatus,
    this.deleteNote,
    this.deleteNoteforIcon,
    super.key,
  });

  @override
  State<CardExample> createState() => _CardExampleState();
}

class _CardExampleState extends State<CardExample> {
  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: widget.deleteNote,
      child: Card(
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 1, right: 1),
        elevation: widget.isDone ? 1 : 5,
        shadowColor: widget.isDone ? Colors.green.shade800 : Colors.white38,
        color: widget.isDone ? Colors.green.shade300 : getRandomColor(),
        child: ListTile(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditScreen(
                  note:
                      Provider.of<NoteData>(context).noteExample[widget.index!],
                ),
              ),
            );

            if (result != null) {
              setState(() {
                Provider.of<NoteData>(context, listen: false)
                    .noteExample[widget.index!] = Note(
                  title: result[0],
                  contentOfNote: result[1],
                  modifiedTime: DateTime.now(),
                );
              });
            }
          },
          title: RichText(
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: '${widget.title}\n',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  decoration: widget.isDone ? TextDecoration.lineThrough : null,
                  fontSize: 16,
                  height: 1.5),
              children: [
                TextSpan(
                  text: widget.contentOfNote,
                  style: TextStyle(
                      color: Colors.black,
                      decoration:
                          widget.isDone ? TextDecoration.lineThrough : null,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      height: 1.5),
                ),
              ],
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 2),
            child: Text(
              DateFormat('EEE MMM d, yyyy h:mm a').format(widget.modifiedTime),
              style: TextStyle(
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade800),
            ),
          ),
          trailing: IconButton(
            onPressed: () async {
              await buildShowDialog(context);
            },
            icon: const Icon(
              Icons.delete,
              size: 30,
            ),
          ),
          leading: Checkbox(
            value: widget.isDone,
            onChanged: widget.toggleStatus,
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: Colors.grey.shade900,
        icon: const Icon(
          Icons.info_rounded,
          color: Colors.grey,
          size: 25,
        ),
        title: const Text(
          'Silmek istediğinizden emin misiniz?',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.deleteNoteforIcon!();
                  Navigator.pop(context);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: const SizedBox(
                width: 60,
                child: Text(
                  'Evet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade800,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: const SizedBox(
                width: 60,
                child: Text(
                  'Hayır',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
