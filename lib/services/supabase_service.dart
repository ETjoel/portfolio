import 'package:portfolio/core/constants.dart';
import 'package:portfolio/models/experience.dart';
import 'package:portfolio/models/project.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client;
  final String supabaseKey;

  SupabaseService({required this.supabaseKey}) : _client = SupabaseClient(
    Constants.supabaseUrl,
    supabaseKey,
  );

  SupabaseClient get client => _client;

static const String _projectsTable = 'projects';
static const String _experienceTable = 'experience';

  Future<List<Project>> fetchProjects() async {
    try {
      final response = await _client.from(_projectsTable).select();
      if (response.isNotEmpty) {
        return (response as List).map((item) => Project.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch projects');
      }
    } catch (e) {
      throw Exception('Error fetching projects: $e');
    }
  }

  Future<void> createProject(Project project) async {
    try {
      final response = await _client.from(_projectsTable).insert(project.toJson());
      if (response.error != null) {
        throw Exception('Failed to create project');
      }
    } catch (e) {
      throw Exception('Error creating project: $e');
    }
  }

  Future<void> addProject(Project project) async {
    try {
      final response = await _client.from(_projectsTable).insert(project.toJson());
      if (response.error != null) {
        throw Exception('Failed to add project');
      }
    } catch (e) {
      throw Exception('Error adding project: $e');
    }
  }

  Future<void> editProject(Project project) async {
    try {
      final response = await _client.from(_projectsTable).update(project.toJson()).eq('id', project.id);
      if (response.error != null) {
        throw Exception('Failed to update project');
      }
    } catch (e) {
      throw Exception('Error updating project: $e');
    }
  }

  Future<void> deleteProject(String projectId) async {
    try {
      final response = await _client.from(_projectsTable).delete().eq('id', projectId);
      if (response.error != null) {
        throw Exception('Failed to delete project');
      }
    } catch (e) {
      throw Exception('Error deleting project: $e');
    }
  }

  Future<List<Experience>> fetchExperiences() async {
    try {
      final response = await _client.from(_experienceTable).select();
      if (response.isNotEmpty) {
        return (response as List).map((item) => Experience.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch experiences');
      }
    } catch (e) {
      throw Exception('Error fetching experiences: $e');
    }
  }

    Future<void> addExperience(Experience experience) async {
      try {
        final response = await _client.from(_experienceTable).insert(experience.toJson());
        if (response.error != null) {
          throw Exception('Failed to add experience');
        }
      } catch (e) {
        throw Exception('Error adding experience: $e');
      }
    }

    Future<void> updateExperience(Experience experience) async {
      try {
        final response = await _client.from(_experienceTable).update(experience.toJson()).eq('id', experience.id);
        if (response.error != null) {
          throw Exception('Failed to update experience');
        }
      } catch (e) {
        throw Exception('Error updating experience: $e');
      }
    }

    Future<void> deleteExperience(String experienceId) async {
      try {
        final response = await _client.from(_experienceTable).delete().eq('id', experienceId);
        if (response.error != null) {
          throw Exception('Failed to delete experience');
        }
      } catch (e) {
        throw Exception('Error deleting experience: $e');
      }
    }
  }
  