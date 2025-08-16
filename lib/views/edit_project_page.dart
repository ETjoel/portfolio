import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/project_controller.dart';
import '../models/project.dart';
import '../widgets/themed_app_bar.dart';

class EditProjectPage extends StatefulWidget {
  final String projectId;
  const EditProjectPage({super.key, required this.projectId});

  @override
  State<EditProjectPage> createState() => _EditProjectPageState();
}

class _EditProjectPageState extends State<EditProjectPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late List<String> _originalImageUrls;
  late List<Uint8List> _newlyPickedImages;
  late TextEditingController _technologiesController;
  late TextEditingController _githubLinkController;

  @override
  void initState() {
    super.initState();
    final project = Provider.of<ProjectController>(context, listen: false)
        .projects
        .firstWhere((p) => p.id == widget.projectId);

    _titleController = TextEditingController(text: project.title);
    _descriptionController = TextEditingController(text: project.description);
    _originalImageUrls = [];
    _newlyPickedImages = [];

    for (var imageString in project.images) {
      try {
        base64Decode(imageString);
        _newlyPickedImages.add(base64Decode(imageString));
      } catch (e) {
        _originalImageUrls.add(imageString);
      }
    }

    _technologiesController = 
        TextEditingController(text: project.technologies.join(', '));
    _githubLinkController = TextEditingController(text: project.githubLink);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _technologiesController.dispose();
    _githubLinkController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
      withData: true,
    );
    if (result != null) {
      setState(() {
        _newlyPickedImages.addAll(result.files
            .where((f) => f.bytes != null)
            .map((f) => f.bytes!));
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final allImages = <String>[];
      allImages.addAll(_originalImageUrls);
      allImages.addAll(_newlyPickedImages.map((bytes) => base64Encode(bytes)));

      final updatedProject = Project(
        id: widget.projectId,
        title: _titleController.text,
        description: _descriptionController.text,
        images: allImages,
        technologies: _technologiesController.text
            .split(',')
            .map((e) => e.trim())
            .toList(),
        githubLink: _githubLinkController.text,
      );

      Provider.of<ProjectController>(context, listen: false)
          .updateProject(updatedProject);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Project updated successfully!')), 
      );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemedAppBar(title: 'Edit Project'),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(
                    'assets/images/wallpaperflare.com_wallpaper.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                        width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Edit Project',
                            style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                              labelText: 'Treasure\'s Name (Title)'),
                          validator: (value) => value!.isEmpty
                              ? 'Every treasure needs a name!'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                              labelText:
                                  'The Tale of This Treasure (Description)'),
                          maxLines: 5,
                          validator: (value) => value!.isEmpty
                              ? 'A treasure\'s tale must be told!'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.image),
                          label: const Text('Pick Images'),
                          onPressed: _pickImages,
                        ),
                        const SizedBox(height: 12),
                        // Display original image URLs
                        if (_originalImageUrls.isNotEmpty)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: List.generate(
                                _originalImageUrls.length,
                                (idx) => Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            _originalImageUrls[idx],
                                            width: 100,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: 2,
                                          right: 2,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _originalImageUrls.removeAt(idx);
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(Icons.close,
                                                  color: Colors.white,
                                                  size: 18),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                          ),
                        // Display newly picked images
                         
                        if (_newlyPickedImages.isNotEmpty) ...[
                           const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: List.generate(
                                _newlyPickedImages.length,
                                (idx) => Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.memory(
                                            _newlyPickedImages[idx],
                                            width: 100,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: 2,
                                          right: 2,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _newlyPickedImages.removeAt(idx);
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(Icons.close,
                                                  color: Colors.white,
                                                  size: 18),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                          ),],
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _technologiesController,
                          decoration: const InputDecoration(
                              labelText:
                                  'Ancient Runes (Technologies, comma-separated)'),
                          validator: (value) => value!.isEmpty
                              ? 'What ancient runes were used?'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _githubLinkController,
                          decoration: const InputDecoration(
                              labelText:
                                  'Secret Chart (GitHub Link, optional)'),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: _submitForm,
                          child: const Text('Update Project'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
