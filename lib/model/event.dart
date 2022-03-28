class Event {
  String id = '';
  String title = '';
  String description = '';
  String address = '';
  double lat = 0.00;
  double lon = 0.00;
  String date = '';
  String public = '';

  Event(this.id, this.title, this.description, this.address, this.lat, this.lon, this.date, this.public);

  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        date = json['date'],
        address = json['address'],
        lat = json['lat'],
        lon = json['lon'],
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