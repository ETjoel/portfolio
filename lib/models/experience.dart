class Experience {
  final String id;
  final String company;
  final String position;
  final String period;
  final String location;
  final List<String> responsibilities;
  final String? logoAsset; // Path to company logo, can be null

  Experience({
    required this.id,
    required this.company,
    required this.position,
    required this.period,
    required this.location,
    required this.responsibilities,
    this.logoAsset,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'] as String,
      company: json['company'] as String,
      position: json['position'] as String,
      period: json['period'] as String,
      location: json['location'] as String,
      responsibilities: List<String>.from(json['responsibilities'] ?? []),
      logoAsset: json['logo_asset'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'position': position,
      'period': period,
      'location': location,
      'responsibilities': responsibilities,
      'logo_asset': logoAsset,
    };
  }
}
