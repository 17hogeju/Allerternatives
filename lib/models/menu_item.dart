class MenuItem {
  String name;
  String description;

  MenuItem({this.name, this.description});

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      MenuItem(name: json['name'], description: json['description']);
}
