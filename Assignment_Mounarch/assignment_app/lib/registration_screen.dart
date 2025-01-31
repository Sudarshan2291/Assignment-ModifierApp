import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'db_helper.dart';
import 'user_model.dart';
import 'package:image/image.dart' as img;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  String? imagePath;
  final DBHelper dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras != null && cameras!.isNotEmpty) {
      _cameraController = CameraController(
        cameras![1],
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      if (!mounted) return;

      setState(() {});
    }
  }

  Future<void> _takeSelfie() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    final image = await _cameraController!.takePicture();
    final dir = await getApplicationDocumentsDirectory();
    final newPath = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Read the captured image
    File capturedFile = File(image.path);
    img.Image? capturedImage =
        img.decodeImage(await capturedFile.readAsBytes());

    if (capturedImage != null) {
      // Rotate image 90 degrees clockwise (if needed)
      img.Image rotatedImage = img.copyRotate(capturedImage, angle: 0);

      // Save the rotated image
      File(newPath).writeAsBytesSync(img.encodeJpg(rotatedImage));
    }

    setState(() {
      imagePath = newPath;
    });
  }

  void _saveData() async {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        imagePath != null) {
      final user = UserModel(
        name: nameController.text,
        email: emailController.text,
        imagePath: imagePath!,
      );
      await dbHelper.insertUser(user);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User Registered Successfully')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name')),
              TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email')),
              SizedBox(height: 20),
              _cameraController != null &&
                      _cameraController!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _cameraController!.value.aspectRatio,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(0),
                        child: RotatedBox(
                          quarterTurns:
                              -1, // Rotate counter-clockwise (-90 degrees)
                          child: CameraPreview(_cameraController!),
                        ),
                      ),
                    )
                  : Container(
                      height: 300,
                      color: Colors.grey,
                      child: Center(child: Text("Loading Camera..."))),
              ElevatedButton(
                  onPressed: _takeSelfie, child: Text('Take Selfie')),
              imagePath != null
                  ? Image.file(File(imagePath!), height: 200)
                  : SizedBox(),
              ElevatedButton(onPressed: _saveData, child: Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
