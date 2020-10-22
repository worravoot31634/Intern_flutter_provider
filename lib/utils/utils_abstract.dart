import 'package:location/location.dart';

abstract class UtilsAbs {

  Future<String> getId();
  Future<String> getUserAgent();
  Future<String> getIpAddress ();
  Future<LocationData> getLocation();

}