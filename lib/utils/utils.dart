import 'dart:developer';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_ip/get_ip.dart';
import 'package:location/location.dart';
import 'package:provider_flutter_application/shared_preferences/SharedPref.dart';
import 'package:provider_flutter_application/utils/utils_abstract.dart';

class Utils implements UtilsAbs {
  @override
  Future<String> getId() async{
    SharedPref pref = new SharedPref();
    return await pref.getId();
  }

  @override
  Future<String> getUserAgent() async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceName;
    if (Platform.isAndroid) {
      // Android-specific code
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model.toString();
      print('Running on ${androidInfo.model}');
    } else {
      // iOS-specific code
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.utsname.machine.toString();
      print('Running on ${iosInfo.utsname.machine}');
    }
    return deviceName;
  }

  @override
  Future<String> getIpAddress() async{
    return await GetIp.ipAddress;
  }

  @override
  Future<LocationData> getLocation() async {
    Location location = Location();
    LocationData currentLocation;
    try {
      currentLocation = await location.getLocation();
      return currentLocation;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        log("Permission denied");
      }
      return null;
    }
  }
}
