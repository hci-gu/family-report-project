import 'package:flutter/material.dart';
import './homescreen.dart';

class CreateFamilyID extends StatefulWidget {
  @override
  _CreateFamilyIDState createState() => new _CreateFamilyIDState();
}

class _CreateFamilyIDState extends State<CreateFamilyID> {
  List<Step> steps = [
    Step(
      title: Text("Create Family Profile"),
      subtitle: Text("This will help others in your family join the app"),
      content: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Enter a Family Name'),
          ),
        ],
      ),
    ),
    Step(
      title: Text("Create your Profile"),
      content: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            enableSuggestions: false,
            decoration: InputDecoration(labelText: 'Enter your Name'),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Enter your Age'),
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            decoration:
                InputDecoration(labelText: 'Enter your family relation'),
          ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Function onFinishProfileForm = (context) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    };
    int currentStep = 0;
    bool isFormComplete = false;

    void goTo(int updatedStep) {
      setState(() => currentStep = updatedStep);
    }

    void cancel() {
      if (currentStep > 0) {
        goTo(currentStep - 1);
      }
    }

    void next() {
      (currentStep + 1) != steps.length
          ? goTo(currentStep + 1)
          : setState(() => isFormComplete = true);
      if (currentStep + 1 == steps.length) {
        onFinishProfileForm(context);
      }
    }

    return Container(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColor,
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).primaryColor,
            title: Text(
              "Create an Account",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          body: Column(
            children: [
              Stepper(
                controlsBuilder: (context, {onStepContinue, onStepCancel}) {
                  return Row(
                    children: [
                      TextButton(
                        onPressed: onStepContinue,
                        child: const Text(
                          'Next',
                        ),
                      ),
                      TextButton(
                        onPressed: cancel,
                        child: const Text('Cancel'),
                      ),
                    ],
                  );
                },
                steps: steps,
                currentStep: currentStep,
                onStepContinue: next,
                onStepCancel: cancel,
                onStepTapped: (step) => goTo(step),
              ),
            ],
          )),
    );
  }
}

// Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(
//                   left: width / 30, right: width / 30, top: height / 10),
//               child: Text(
//                 "Welcome! Let’s create a Family ID",
//                 style: TextStyle(
//                   fontSize: height / 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                   left: width / 30, right: width / 30, top: height / 40),
//               child: Text(
//                 "What would you like to call your family?",
//                 style: TextStyle(
//                   fontSize: height / 40,
//                 ),
//               ),
//             ),
//             Spacer(),
//             Container(
//               margin: EdgeInsets.only(
//                   right: width / 30, left: width / 30, bottom: 30),
//               child: RegularGreenButton("Next", () {}),
//             ),
//           ],
//         ),
