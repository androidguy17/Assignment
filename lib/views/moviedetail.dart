import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movieapp/models/Moviemodel.dart';

import '../main.dart';

class MovieDetail extends StatefulWidget{

  late final int uniquekey;
  late MovieModel m;

  MovieDetail({required this.uniquekey});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {

  late Box<MovieModel> moviebox;
  late MovieModel m;

  @override
  void initState() { 
    super.initState();
    moviebox = Hive.box<MovieModel>(moviedata);
    m = moviebox.get(widget.uniquekey)!;
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Detail"),
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // height: 200,
                 width: MediaQuery.of(context).size.width,
                child: m.imgpath==""?Image.asset("assets/noimage.png") :Image.file(File(m.imgpath!),fit: BoxFit.cover,),
              ),

              SizedBox(height: 20,),

              Row( children:[SizedBox(width: 20,),Text("Movie Name: ",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 18),),SizedBox(width: 20,), Text("${m.name!}",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 20),)]),
              SizedBox(height: 10,),
              Row( children:[SizedBox(width: 20,),Text("Directed By: ",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 18),),SizedBox(width: 20,), Text("${m.director!}",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 20),)]),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Movie Description : ",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 18),)
                ],
              ),

              SizedBox(height: 5,),

              Padding( 
                padding: EdgeInsets.symmetric(horizontal: 20,vertical:5),
                child: Text(m.description!,style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 15),)),

                SizedBox(height: 10,)

          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //        children:[SizedBox(width: 20,),Text("Movie Description: "),SizedBox(width: 20,),Text(m.description!,style: GoogleFonts.poppins()) ]),
          //    // Padding(padding: EdgeInsets.symmetric(horizontal: 10)
            ],
           ),

        ),
      );
  }
}