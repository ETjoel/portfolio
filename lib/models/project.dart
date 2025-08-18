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

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      images: List<String>.from(json['images'] ?? []),
      technologies: List<String>.from(json['technologies'] ?? []),
      githubLink: json['github_link'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'images': images,
      'technologies': technologies,
      'github_link': githubLink,
    };
  }
}
