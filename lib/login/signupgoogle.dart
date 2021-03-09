// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:task/homepage.dart';

// import 'package:firebase_auth/firebase_auth.dart';

// class SignUpWith extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: ChangeNotifierProvider(
//           create: (context) => GoogleSignInProvider(),
//           child: StreamBuilder(
//             stream: FirebaseAuth.instance.authStateChanges(),
//             builder: (context, snapshot) {
//               final provider = Provider.of<GoogleSignInProvider>(context);

//               if (provider.isSigningIn) {
//                 return buildLoading();
//               } else if (snapshot.hasData) {
//                 return Homepage();
//               } else {
//                 return Signinpage();
//               }
//             },
//           ),
//         ),
//       );
// }
