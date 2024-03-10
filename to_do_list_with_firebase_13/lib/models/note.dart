class Note {
  int? id;
  String title;
  String contentOfNote;
  DateTime modifiedTime;
  bool isDone;

  Note(
      {this.id,
      required this.title,
      required this.contentOfNote,
      required this.modifiedTime,
      this.isDone = false});

  void toggleStatus() {
    isDone = !isDone;
  }

  Note.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        contentOfNote = map['contentOfNote'],
        modifiedTime = DateTime.parse(map['modifiedTime']),
        isDone = map['isDone'];


  Map<String, dynamic> toMap() => {
        'title': title,
        'contentOfNote': contentOfNote,
        'modifiedTime': modifiedTime.toUtc().toIso8601String(),
    /*
    DateTime nesnesini bir stringe dönüştürerek, JSON'a uygun hale getirir.
    JSON, tarih ve saat bilgisini doğrudan desteklemediği için,
    bu tür bir dönüşüm gereklidir. Bu şekilde, modifiedTime alanını
    uygun bir şekilde JSON'a çevirmiş oluyoruz.
     */
        'isDone': isDone
      };
}
