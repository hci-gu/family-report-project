import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './services/api.dart';
import 'package:provider/provider.dart';
import './onboarding.dart';
import './providers/familyMemberProvider.dart';
import './testFamily.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = Api('family1');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => FamilyMemberProvider('family1')),
        StreamProvider(
          create: (context) => firestoreService.getFamilyMembersList(),
        ),
      ],
      child: MaterialApp(
        title: "Family Report App",
        home: Onboarding(),
        theme: ThemeData(
          primaryColor: const Color(0xff2B9797),
          accentColor: const Color(0xffD2E5E5),
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: const Color(0xff2B9797),
            ),
          ),
        ),
      ),
    );
  }
}

// return MaterialApp(
//       title: "Family Report App",
//       home: Onboarding(),
//       theme: ThemeData(
//         primaryColor: const Color(0xff2B9797),
//         accentColor: const Color(0xffD2E5E5),
//         textTheme: TextTheme(
//           headline1: TextStyle(
//             fontSize: 36,
//             fontWeight: FontWeight.bold,
//             color: const Color(0xff2B9797),
//           ),
//         ),
//       ),
//     );
