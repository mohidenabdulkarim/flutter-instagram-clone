import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();
  XFile? _file = await _picker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  // no image selected
}
