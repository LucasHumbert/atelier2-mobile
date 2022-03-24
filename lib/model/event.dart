class Event {
  String id = '';
  String title = '';
  String description = '';
  DateTime date = DateTime.now();
  bool public = false;

  Event(this.id, this.title, this.description, this.date, this.public);

  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        date = json['date'],
        public = json['date'];

  //prepare json data from Dart object to send to API
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date,
    'public': public,
  };

}