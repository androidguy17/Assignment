import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SigninGoogle extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google signin'),
      ),
      body: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: TextButton(child: Text('Google sign in'),
          onPressed: ()async
          {
            print("google signin pressed");
            await signInWithGoogle();

          },
          ),
        ),
      ),
    );
  }


  Future<UserCredential> signInWithGoogle() async {
    print("re");
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(

    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}




}