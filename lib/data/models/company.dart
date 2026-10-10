class Company {
  const Company({
    required this.id,
    required this.name,
    required this.location,
    required this.specialty,
    required this.rating,
    required this.imageUrl,
    required this.about,
    required this.phone,
    required this.foundedYear,
  });

  final String id;
  final String name;
  final String location;
  final String specialty;
  final String rating;
  final String imageUrl;
  final String about;
  final String phone;
  final int foundedYear;
}
