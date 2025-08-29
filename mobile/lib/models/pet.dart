class Pet {
  final String? id;
  final String name;
  final String type;
  final int age;
  final String notes;
  final String? ownerId;

  Pet({
    this.id,
    required this.name,
    required this.type,
    required this.age,
    this.notes = '',
    this.ownerId,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      age: json['age'] ?? 0,
      notes: json['notes'] ?? '',
      ownerId: json['owner_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'type': type, 'age': age, 'notes': notes};
  }
}
