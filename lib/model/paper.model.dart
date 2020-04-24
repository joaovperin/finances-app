/// Paper
class Paper {
  String name;
  DateTime date;
  num quantity;
  num value;

  Paper({String name}) : this.name = name;

  Map<String, dynamic> get asMap {
    return {"name": name, "date": date.toIso8601String(), "quantity": quantity, "value": value};
  }
}
