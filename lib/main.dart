import 'package:flutter/material.dart';
import 'app.dart';

import 'package:permission_handler/permission_handler.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(await createApp());
}