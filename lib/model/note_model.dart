class NoteModel{
  int? id;
  String? note;
  bool? completed;
  DateTime? date;

  NoteModel({this.id,this.note,this.completed,this.date});

  factory NoteModel.fromjson(Map<String, dynamic>json)=>
      NoteModel(
        id: json['id'],
        note: json['note'],
        completed: json['completed'],
        date: json['date'],

      );


}