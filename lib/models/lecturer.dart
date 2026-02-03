class Lecturer {
  final String name;
  final String office;
  final String email;

  Lecturer({
    required this.name,
    required this.office,
    required this.email,
  });

  @override
  String toString() {
    return 'Lecturer(name: $name, office: $office, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Lecturer &&
        other.name == name &&
        other.office == office &&
        other.email == email;
  }

  @override
  int get hashCode => name.hashCode ^ office.hashCode ^ email.hashCode;
}
