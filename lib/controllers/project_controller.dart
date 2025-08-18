import 'package:flutter/material.dart';
import 'package:portfolio/services/supabase_service.dart';
import '../models/project.dart';

class ProjectController with ChangeNotifier {
  final SupabaseService supabaseService;
  ProjectController({required this.supabaseService});

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

  bool _isCreatingProjectLoading = false;
  bool _isfetchingProjects = false;
  bool _showError = false;
  String _errorMessage = '';

  List<Project> get projects => _projects;
  bool get isCreatingProjectLoading => _isCreatingProjectLoading;
  bool get isfetchingProjects => _isfetchingProjects;
  bool get showError => _showError;
  String get errorMessage => _errorMessage;

  Project? getProjectById(String id) {
    try {
      return _projects.firstWhere((proj) => proj.id == id);
    } catch (e) {
      return null;
    }
  }

  void updateIsCreatingProjectLoading(bool value) {
    _isCreatingProjectLoading = value;
    notifyListeners();
  }

  void updateIsfetchingProjects(bool value) {
    _isfetchingProjects = value;
    notifyListeners();
  }
  void updateShowError(bool value) {
    _showError = value;
    notifyListeners();
  }
  void updateErrorMessage(String value) {
    _errorMessage = value;
    notifyListeners();
  }

  void fetchProjects() async {
    updateIsfetchingProjects(true);
    try {
      final projects = await supabaseService.fetchProjects();
      _projects.clear();
      _projects.addAll(projects);
    } catch (e) {
      updateShowError(true);
      updateErrorMessage('Error fetching projects: $e');
    }
    updateIsfetchingProjects(false);
    notifyListeners();
  }



  void updateProject(Project project) async {
    try {
      await supabaseService.editProject(project);
      final index = _projects.indexWhere((p) => p.id == project.id);
      if (index != -1) {
        _projects[index] = project;
        notifyListeners(); // Notify listeners after updating the local list
      }
    } catch (e) {
      updateShowError(true);
      updateErrorMessage('Error updating project: $e');
    }
  }

  void deleteProject(String projectId) async {
    try {
      await supabaseService.deleteProject(projectId);
      _projects.removeWhere((p) => p.id == projectId);
    } catch (e) {
      updateShowError(true);
      updateErrorMessage('Error deleting project: $e');
    }
    notifyListeners();
  }

  void createProject(Project project) async {
    updateIsCreatingProjectLoading(true);
    try {
      await supabaseService.createProject(project);
      fetchProjects();
    } catch (e) {
      updateShowError(true);
      updateErrorMessage('Error creating project: $e');
    }
    updateIsCreatingProjectLoading(false);
  }

}