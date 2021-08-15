import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Test extends StatefulWidget{
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  File? t;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('dfsdf'),),

      body: GestureDetector(
        onTap: ()async {
          final ImagePicker p = ImagePicker();
          var i =  await p.getImage(source: ImageSource.gallery);
          t = File(i!.path);
          setState(() {
            
          });
         
        },
        child:t==null? Container(
          height: 500,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.red,
            image: DecorationImage(image: AssetImage("assets/ggg.png"))
      
          ),
        ):
        Image.file(t!)
      ),
    );
  }
}