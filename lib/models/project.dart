

class Project {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String? githubLink;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.githubLink,
  });
}
