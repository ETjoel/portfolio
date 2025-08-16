class Project {
  final String id;
  final String title;
  final String description;
  final List<String> images;
  final List<String> technologies;
  final String? githubLink;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.technologies,
    this.githubLink,
  });
}
