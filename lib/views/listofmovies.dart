import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movieapp/models/Moviemodel.dart';
import 'package:movieapp/views/addmovie.dart';
import 'package:movieapp/views/editmovie.dart';
import 'package:movieapp/views/moviedetail.dart';

import '../main.dart';
import 'Signingoogle.dart';

class ListofMovies extends StatefulWidget{
  @override
  _ListofMoviesState createState() => _ListofMoviesState();
}

class _ListofMoviesState extends State<ListofMovies> {

  late Box<MovieModel> moviebox;

  
 final TextEditingController  name = TextEditingController();
 final TextEditingController  director = TextEditingController();
 final TextEditingController  imgpath = TextEditingController();


  @override
  void initState() {
    moviebox = Hive.box<MovieModel>(moviedata);
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("Movies"),
       centerTitle: true,
       leading:   Padding(
         padding: EdgeInsets.symmetric(horizontal: 10),
         child: InkWell(
           
             splashColor: Colors.blue,
             onTap: (){  Get.to(AddMovie());},
             child: Ink(
               child: Row(
                 children: [
                   Icon(Icons.add),
                  // Text('Add Movie'),
                   SizedBox(width: 10,)
                 ],
               ),
             ),
           ),
       ),

       actions: [
         InkWell(
           onTap: () {
             login = 0;
             SigninGoogle().logout();
             Get.off(SigninGoogle());

           },
           child: Icon(Icons.logout),
         ),

         SizedBox(width: 10,)
       ],
     ),
     backgroundColor: Colors.grey[300],
    
     
     body: Container(
       padding: EdgeInsets.all(10),
       child: ValueListenableBuilder(
         valueListenable: moviebox.listenable(),
         builder: (context,Box<MovieModel> box,_){

          List<int> keys = box.keys.cast<int>().toList();


          return ListView.separated(


            separatorBuilder: (context,int){
              return SizedBox(height: 10,);
            },

            itemCount: keys.length,
            itemBuilder: (context, index){

              final int key = keys[index];
              final MovieModel? model = box.get(key);
              
              return GestureDetector(
                onTap: (){
                  Get.to(MovieDetail(uniquekey: key,));
                },
                child: Container(

                  //padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xff9999ff),
                  ),
                  height: 210,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      ClipRRect(
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(10) ,topRight:Radius.circular(10) ),
                        child: SizedBox(
                          height: 130,
                          width: MediaQuery.of(context).size.width,
                          child: model!.imgpath==""?Image.asset("assets/noimage.png") :Image.file(File(model.imgpath!),fit: BoxFit.fitWidth,),
                        ),
                      ),

                      SizedBox(height: 5,),
              
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(model.name!,style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 18),)),
                      SizedBox(height: 10,),
              
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[ Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(model.director!)),


                          Row(
                            children: [
                              GestureDetector(
                            onTap: (){
                            //  int k = key;
                            //  print(k);
                             Navigator.of(context).push(
                               MaterialPageRoute(builder: (context)=> EditMovie(uniquekey: key,))
                             );
                            },
                            child: Icon(Icons.edit),
                            ),
                            SizedBox(width: 20,),
                            
                            GestureDetector(
                              onTap: ()async{
                                await _delete(model.name.toString(),key);
                              },
                              child: Icon(Icons.delete,color: Colors.red),
                            ),
                            SizedBox(width: 10,)
                              ],
                          )

                        ]
                      )
                     
              
                    ],
                  ),
                ),
              );

            },

          );
           
         },
       )
     ),
   );
  }



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

                // TextField(
                //   controller: imgpath,

                // ),

                ElevatedButton(onPressed: () async{

                  

                   final ImagePicker picker = ImagePicker();

                   final XFile? y = await picker.pickImage(source: ImageSource.gallery);
                
                  if(y!=null){
                   imgpath.text = y.path;

                  }
                  else{
                    imgpath.text = "";
                  }

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





  Future<void> _delete(String moviename,int key) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('This Item will be deleted'),
        content: SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[
              Text('$moviename will be removed'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              moviebox.delete(key);
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}