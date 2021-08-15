
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movieapp/main.dart';
import 'package:movieapp/models/Moviemodel.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import "package:path/path.dart";

class MovieList extends StatefulWidget{
  
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {

 String? _image;

 final TextEditingController  name = TextEditingController();
 final TextEditingController  director = TextEditingController();
 final TextEditingController  imgpath = TextEditingController();

  late Box<MovieModel> moviebox;

  @override
  void initState() {
    moviebox = Hive.box<MovieModel>(moviedata);
    imgpath.text="dsdsf";
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie List"),
        centerTitle: true,

      ),
      backgroundColor: Colors.white,

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
         await _showMyDialog(context);

        },
        child: Icon(Icons.add),
      ),

      body: Container(
        child: WatchBoxBuilder(
          box: moviebox, 
          builder: (context,box){
            
            List<int> keys = box.keys.cast<int>().toList();

           //moviebox.clear();

          

            return ListView.separated(
              itemBuilder: (context,index){

                final int key = keys[index];
                final MovieModel model = box.get(key);

                return ListTile(
                 
                  onLongPress: (){
                    print("hi");
                    box.delete(key);
                  },
                  onTap: ()async{

                    await _editMyDialog(context, key, box);

                  },
                  title: Text(model.name??"NA"),
                  subtitle: Text(model.director??"NA"),
                  leading: SizedBox(height: 20,width: 20,
                    child: model.imgpath==""?Image.asset("assets/ggg.png") :Image.file(File(model.imgpath!)),
                  )
                    
                  
                );
              },
              separatorBuilder: (context,index)=> Divider(),
              itemCount: keys.length);

          }
          )
      ),


    );
  }

   Future<void> _editMyDialog(context,int index, Box<dynamic> model) async {

    MovieModel t = model.get(index);

    String gname = t.name!;

      name.text=  gname;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a Movie'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
               // Center(child: Text('Please Fill the Form'),),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: "Name",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.grey)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.blue)
                    )
                  ),
                ),

                SizedBox(height: 20,),

                 TextField(
                  controller: director,
                   decoration: InputDecoration(
                    labelText: "Director By",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.grey)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.blue)
                    )
                  ),
                ),

                 TextField(
                  controller: imgpath,

                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                
                final String name1 = name.text;
                final String director1 = director.text;
                final String img  = imgpath.text;
                
                name.text = "";
                director.text = "";
                imgpath.text = "";

                MovieModel model = MovieModel(name: name1,director: director1,imgpath: img);
                
                moviebox.put(index, model);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


    //original

    Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a Movie'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
               // Center(child: Text('Please Fill the Form'),),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: "Name",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.grey)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.blue)
                    )
                  ),
                ),

                SizedBox(height: 20,),

                 TextField(
                  controller: director,
                   decoration: InputDecoration(
                    labelText: "Director By",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.grey)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.blue)
                    )
                  ),
                ),

                TextField(
                  controller: imgpath,

                ),

                ElevatedButton(onPressed: () async{

                  

                   final ImagePicker picker = ImagePicker();

                   final XFile? y = await picker.pickImage(source: ImageSource.gallery);
                
                  _image = y!.path;
                  imgpath.text = _image!;

                  setState(() {
                    
                  });
                  


                }, child: Text("Select Image"))
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                
                final String name1 = name.text;
                final String director1 = director.text;
                final String img  = imgpath.text;
                
                name.text = "";
                director.text = "";
                imgpath.text = "";

                MovieModel model = MovieModel(name: name1,director: director1,imgpath: img);
                moviebox.add(model);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}