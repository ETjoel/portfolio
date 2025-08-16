import 'package:flutter/material.dart';
import '../models/project.dart';

class ProjectController with ChangeNotifier {
  final List<Project> _projects = [
    Project(
      id: '1',
      title: 'Portfolio Website',
      description:
          'A personal portfolio website built with Flutter Web to showcase my projects and skills. It features a clean, modern design with smooth animations and is fully responsive.',
      images: [
        'https://picsum.photos/seed/p1/400/300',
        'https://picsum.photos/seed/p1b/400/300',
        'https://picsum.photos/seed/p1c/400/300',
        'https://picsum.photos/seed/p1d/400/300',
      ],
      technologies: ['Flutter', 'Dart', 'Provider'],
      githubLink: 'https://github.com/your_username/portfolio',
    ),
    Project(
      id: '2',
      title: 'E-commerce App',
      description:
          'A feature-rich e-commerce application for both iOS and Android. It includes product browsing, a shopping cart, user authentication, and a secure checkout process.',
      images: [
        'https://picsum.photos/seed/p2/400/300',
        'https://picsum.photos/seed/p2b/400/300',
        'https://picsum.photos/seed/p2c/400/300',
      ],
      technologies: ['Flutter', 'Firebase', 'Stripe'],
    ),
    Project(
      id: '3',
      title: 'Task Management Tool',
      description:
          'A productivity tool to help users organize tasks, set deadlines, and track progress. It includes features like drag-and-drop reordering and notifications.',
      images: [
        'https://picsum.photos/seed/p3/400/300',
        'https://picsum.photos/seed/p3b/400/300',
      ],
      technologies: ['Flutter', 'SQLite', 'GetX'],
    ),
  ];

  List<Project> get projects => _projects;

  Project? getProjectById(String id) {
    try {
      return _projects.firstWhere((proj) => proj.id == id);
    } catch (e) {
      return null;
    }
  }

  void addProject(Project project) {
    final newProject = Project(
      id: (_projects.length + 1).toString(),
      title: project.title,
      description: project.description,
      images: project.images,
      technologies: project.technologies,
      githubLink: project.githubLink,
    );
    _projects.add(newProject);
    notifyListeners();
  }

  void updateProject(Project project) {
    final index = _projects.indexWhere((p) => p.id == project.id);
    if (index != -1) {
      _projects[index] = project;
      notifyListeners();
    }
  }

  void deleteProject(String projectId) {
    _projects.removeWhere((p) => p.id == projectId);
    notifyListeners();
  }
}
