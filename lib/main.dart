import 'package:family_report_project/models/model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import './screens/wrapper.dart';
import './services/auth.dart';
import './models/model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final firestoreService = Api('family1');
    return StreamProvider<FamilyMember>.value(
      value: AuthService().familyMemberUser,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
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

// MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//             create: (context) => FamilyMemberProvider('family1')),
//         StreamProvider(
//           create: (context) => firestoreService.getFamilyMembersList(),
//         ),
//       ],
//       child: MaterialApp(
//         title: "Family Report App",
//         home: Wrapper(),
//         theme: ThemeData(
//           primaryColor: const Color(0xff2B9797),
//           accentColor: const Color(0xffD2E5E5),
//           textTheme: TextTheme(
//             headline1: TextStyle(
//               fontSize: 36,
//               fontWeight: FontWeight.bold,
//               color: const Color(0xff2B9797),
//             ),
//           ),
//         ),
//       ),
//     );
