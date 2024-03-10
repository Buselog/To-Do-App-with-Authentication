import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'note.dart';

class NoteData with ChangeNotifier {
  List<Note> noteExample = [
  ];

  static SharedPreferences? _sharedPref;
  final List<String> _notesAsString= [];

  void deleteNote(int index) {
    noteExample.removeAt(index);
    saveNotesToSharedPref(noteExample);
    notifyListeners();
  }

  void addNewNote(String title, String contentOfNote) {
    noteExample.add(
      Note(
          title: title,
          contentOfNote: contentOfNote,
          modifiedTime: DateTime.now(),
          id: noteExample.length,
          isDone: false),
    );
    saveNotesToSharedPref(noteExample);
    notifyListeners();
  }

  void deleteNoteforIcon(int index) {
    noteExample.removeAt(index);
    saveNotesToSharedPref(noteExample);
    notifyListeners();
  }

  void toggleStatus(int index) {
    noteExample[index].toggleStatus();
    saveNotesToSharedPref(noteExample);
    notifyListeners();
  }

  Future<void> createPrefObject() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  void saveNotesToSharedPref(List<Note> notes) {
    // Shared Preferences, String içeren Listeleri save edebilir.
    // Bu nedenle önce Listemizi String içeren bir listeye çevirmeliyiz.

    _notesAsString.clear();

    for(var note in noteExample){
      // Listenin içindeki her veriyi önce Map'e, sonra String'e çevirdi,
      // String listesine kaydetti
      _notesAsString.add(jsonEncode((note.toMap())));
    }
    _sharedPref?.setStringList('toDoList', _notesAsString);


  }
  
  void loadNotesFromSharedPref() {
    
    // Hafızada kayıtlı son veri listesini get ile çekip bir listeye atadık
    List<String> tempList = _sharedPref?.getStringList('toDoList')??[];
    
    noteExample.clear();
    
    
    for(var item in tempList){
      noteExample.add(Note.fromMap(jsonDecode(item)));
    }
    
    
    
  }

}
