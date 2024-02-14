import 'package:brookwoodapp/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import '../provider/provider_page.dart';

List<CameraDescription> allCameras = [];
Future<void> main()async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    allCameras = await availableCameras();
  } on CameraException catch (errorMessage) {
    print(errorMessage.description);
  }
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>Provider_class(),
      child:  MaterialApp(
        home: MyHomepage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

