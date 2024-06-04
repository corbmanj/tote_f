class Unnamed {
  String name;
  int count;

  Unnamed(this.name, this.count);

  Map toJson() => {
    'name': name,
    'count': count,
  };

  factory Unnamed.fromMap(Map<String, dynamic> map) {
    return Unnamed(
      map['name'],
      map['count'],
    );
  }

  void incrementCount() {
    count++;
  }
}
