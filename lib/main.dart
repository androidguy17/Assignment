import 'package:flutter/material.dart';
import 'package:movieapp/models/Moviemodel.dart';
import 'package:movieapp/views/movelist.dart';
import 'package:hive/hive.dart';
import 'package:movieapp/views/test.dart';
import 'package:path_provider/path_provider.dart';


const String moviedata = "moviedata";
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(MovieModelAdapter());
  await Hive.openBox<MovieModel>(moviedata);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MovieList(),
    );
  }
}
