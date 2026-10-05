import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final ImagePicker _imagePicker = ImagePicker();

  List<XFile> selectedImages = [];

  Future<void> _pickImages() async {
    final List<XFile> images = await _imagePicker.pickMultiImage();

    if (images.isEmpty) {
      return;
    }

    setState(() {
      selectedImages = images;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Gallery')),
      body: Column(
        children: [
          Expanded(
            child: selectedImages.isEmpty
                ? const Center(
                    child: Text(
                      'No images selected',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: selectedImages.length,
                    itemBuilder: (context, index) {
                      final image = selectedImages[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        clipBehavior: Clip.antiAlias,
                        child: Image.file(
                          File(image.path),
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _pickImages,
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Pick Image'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
