import 'package:simple_permissions/simple_permissions.dart';

Future<bool> requestPermission() async {
  bool checkPermissionRecorAudi =
  await SimplePermissions.checkPermission(Permission.RecordAudio);
  bool checkPermissionWEStorage = await SimplePermissions.checkPermission(
      Permission.WriteExternalStorage);
  if (checkPermissionRecorAudi && checkPermissionWEStorage) {
    return true;
  }
  PermissionStatus psRecorAudi;
  PermissionStatus psWEStorage;
  if (!checkPermissionRecorAudi) {
    psRecorAudi =
    await SimplePermissions.requestPermission(Permission.RecordAudio);
  }
  if (!checkPermissionWEStorage) {
    psWEStorage = await SimplePermissions.requestPermission(
        Permission.WriteExternalStorage);
  }

  if (psRecorAudi == PermissionStatus.authorized &&
      psWEStorage == PermissionStatus.authorized) {
    return true;
  } else {
    return false;
  }
}