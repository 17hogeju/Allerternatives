class Allergens {
  var alternatives;
  var name;

  Allergens({ this.alternatives, this.name});

  getId() {
    return  name != null ? name[0] : null;
  }

  Allergens.fromData(Map<String, dynamic> data)
      : alternatives = data['alternatives'],
        name = data['name'];

  Map<String, dynamic> toJson() {
    return {
      'alternatives' : alternatives,
      'name' : name,
    };
  }

  static Allergens fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Allergens(
      alternatives: map['alternatives'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'alternatives': alternatives,
      'name': name,
    };
  }

}