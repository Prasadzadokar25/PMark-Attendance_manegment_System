import 'dart:io';
import 'package:connectivity/connectivity.dart';

class IpAddress {
  String _ipAddress = 'Unknown';

  Future<String> _getIpAddress() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // Get the IP address of the mobile network
      var ipAddress = await _getMobileIpAddress();

      _ipAddress = ipAddress ?? 'Unknown';
      return _ipAddress;
    } else {
      _ipAddress = 'Not connected to a mobile network';
      return "emulator";
    }
  }

  Future<String?> _getMobileIpAddress() async {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        if (addr.address.isNotEmpty && !addr.address.startsWith('127.')) {
          return addr.address;
        }
      }
    }
    return null;
  }
}
