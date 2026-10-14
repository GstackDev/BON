import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestMicPermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted || status.isLimited;
  }
}
