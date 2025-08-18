
class Experience {
  final String company;
  final String position;
  final String period;
  final String location;
  final List<String> responsibilities;
  final String? logoAsset; // Path to company logo, can be null

  Experience({
    required this.company,
    required this.position,
    required this.period,
    required this.location,
    required this.responsibilities,
    this.logoAsset,
  });
}
