class Unnamed {
  String name;
  int count;
  bool? isPacked;

  Unnamed(this.name, this.count, [this.isPacked]) {
    isPacked = isPacked ?? false;
  }

  Map toJson() => {
    'name': name,
    'count': count,
    'isPacked': isPacked,
  };

  factory Unnamed.fromMap(Map<String, dynamic> map) {
    return Unnamed(
      map['name'],
      map['count'],
      map['isPacked'] ?? false,
    );
  }

  void incrementCount() {
    count++;
  }

  void decrementCount() {
    count--;
  }

  void setIsPacked(bool newValue) {
    isPacked = newValue;
  }
}
