class CategoryModel{
  int? id;
  String? category;


  NoteModel({this.id,this.category});

  factory NoteModel.fromjson(Map<String, dynamic>json)=>
      NoteModel(
        id: json['id'],
        category: json['category'],

      );
  toJson()=>{
    'id'= id,
    'category'= category,

  };
}