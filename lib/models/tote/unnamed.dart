class Unnamed {
  String name;
  int count;

  Unnamed(this.name, this.count);

  Map toJson() => {
    'name': name,
    'count': count,
  };

  void incrementCount() {
    count++;
  }
}
