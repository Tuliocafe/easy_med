// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class ServicoAutenticacaoGoogle extends ChangeNotifier {
//   final googleautenticacao = GoogleSignIn();
//
//   GoogleSignInAccount? _user;
//
//   GoogleSignInAccount get user => _user!;
//
//   Future googleLogin() async {
//     try {
//       final googleUser = await googleautenticacao.signIn();
//       if (googleUser == null) {
//         return;
//       }
//       _user = googleUser;
//
//       final googleAuth = await googleUser.authentication;
//
//       final credencial = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
//
//       await FirebaseAuth.instance.signInWithCredential(credencial);
//     } catch (e) {
//       print(e.toString());
//     }
//     notifyListeners();
//   }
//
//   Future logout() async {
//     await googleautenticacao.disconnect();
//     FirebaseAuth.instance.signOut();
//   }
// }
