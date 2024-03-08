
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionsProvider = StateNotifierProvider<PermissionsNotifier, PermissionsState>((ref) {
  return PermissionsNotifier();
});

class PermissionsNotifier extends StateNotifier<PermissionsState> {
  PermissionsNotifier(): super( PermissionsState() );

  Future<void> checkPemissions() async {
    final permissionsArray = await Future.wait([
      Permission.camera.status,
      Permission.photos.status,
      Permission.sensors.status,
      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status,
    ]);

    state = state.copyWith(
      camera              : permissionsArray[0],
      photoLibrary        : permissionsArray[1],
      sensors             : permissionsArray[2],
      location            : permissionsArray[3],
      locationAlways      : permissionsArray[4],
      locationWhenInUse   : permissionsArray[5],
    );
  }
  
  openSettingsScreen() {
    openAppSettings();
  }

  void _checkPermssionState( PermissionStatus status) {
    if (status == PermissionStatus.permanentlyDenied ) {
      openSettingsScreen();
    }
  }

  requestCameraAccess() async {
    final status = await Permission.camera.request();
    state = state.copyWith( camera: status );
    _checkPermssionState(status);
  }

  requestPhotosLibraryAccess() async {
    if (Platform.isAndroid) { 
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) { 
        final status = await Permission.storage.request();
        state = state.copyWith( photoLibrary: status );
        openSettingsScreen();
      } else { 
        final status = await Permission.photos.request();
        state = state.copyWith( photoLibrary: status );
        _checkPermssionState(status);
      }
    }
  }

  requestSensorsAccess() async {
    final status = await Permission.sensors.request();
    state = state.copyWith( sensors: status );
    _checkPermssionState(status);
  }

  requestLocationAccess() async {
    final status = await Permission.location.request();
    state = state.copyWith( location: status );
    _checkPermssionState(status);
  }
}

class PermissionsState {
  final PermissionStatus camera;
  final PermissionStatus photoLibrary;
  final PermissionStatus sensors;
  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

  PermissionsState({
    this.camera             = PermissionStatus.denied, 
    this.photoLibrary       = PermissionStatus.denied, 
    this.sensors            = PermissionStatus.denied, 
    this.location           = PermissionStatus.denied, 
    this.locationAlways     = PermissionStatus.denied, 
    this.locationWhenInUse  = PermissionStatus.denied,
  });

  get cameraGranted {
    return camera == PermissionStatus.granted;
  }
  get photoLibraryGranted {
    return photoLibrary == PermissionStatus.granted;
  }
  get sensorsGranted {
    return sensors == PermissionStatus.granted;
  }
  get locationGranted {
    return location == PermissionStatus.granted;
  }
  get locationAlwaysGranted {
    return locationAlways == PermissionStatus.granted;
  }
  get locationWhenInUseGranted {
    return locationWhenInUse == PermissionStatus.granted;
  }

  PermissionsState copyWith({
    PermissionStatus? camera,
    PermissionStatus? photoLibrary,
    PermissionStatus? sensors,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
  }) => PermissionsState(
    camera            : camera ?? this.camera,
    photoLibrary      : photoLibrary ?? this.photoLibrary,
    sensors           : sensors ?? this.sensors,
    location          : location ?? this.location, 
    locationAlways    : locationAlways ?? this.locationAlways,
    locationWhenInUse : locationWhenInUse ?? this.locationWhenInUse,
  );
}