
class Todo {
  String? title;
  bool isDone;
  String? uid;
  Todo({required this.title, required this.isDone,required this.uid});

  factory Todo.fromJson(Map<String, dynamic> json)
  {
    return Todo(title: json['title'], isDone: json['isDone'], uid: json['uid']);
  }

  Map<String, dynamic> toJson()
  {
    return{
      'title':title,
      'isDone':isDone,
      'uid':uid
    };
  }
}

class UserModel{
  String? name;
  String? uid;
  UserModel({required this.name,required this.uid});

  factory UserModel.fromJson(Map<String, dynamic> json)
  {
    return UserModel(name: json['name'], uid: json['uid']);
  }

  Map<String, dynamic> toJson()
  {
    return{
      'name':name,
      'uid':uid
    };
  }

}