import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/familyMemberProvider.dart';
import '../models/model.dart';

class EditFamily extends StatefulWidget {
  final FamilyMember familyMember;

  EditFamily([this.familyMember]);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditFamily> {
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  final relationController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    relationController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.familyMember == null) {
      //New Record
      nameController.text = "";
      ageController.text = "";
      relationController.text = "";
      genderController.text = "";
      new Future.delayed(Duration.zero, () {
        final familyProvider =
            Provider.of<FamilyMemberProvider>(context, listen: false);
        familyProvider.loadFamilyMemberData(FamilyMember());
      });
    } else {
      //Controller Update
      nameController.text = widget.familyMember.name;
      genderController.text = widget.familyMember.gender;
      ageController.text = widget.familyMember.age;
      relationController.text = widget.familyMember.relation;
      //State Update
      new Future.delayed(Duration.zero, () {
        final familyProvider =
            Provider.of<FamilyMemberProvider>(context, listen: false);
        familyProvider.loadFamilyMemberData(widget.familyMember);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<FamilyMemberProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Edit familyMember')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'familyMember Name'),
              onChanged: (value) {
                productProvider.changeFamilyMemberName(value);
              },
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(hintText: 'familyMember Price'),
              onChanged: (value) =>
                  productProvider.changeFamilyMemberAge(value),
            ),
            TextField(
              controller: genderController,
              decoration: InputDecoration(hintText: 'familyMember Price'),
              onChanged: (value) =>
                  productProvider.changeFamilyMemberGender(value),
            ),
            TextField(
              controller: relationController,
              decoration: InputDecoration(hintText: 'familyMember Price'),
              onChanged: (value) =>
                  productProvider.changeFamilyMemberRelation(value),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: () {
                productProvider.saveFamilyMember();
                Navigator.of(context).pop();
              },
            ),
            (widget.familyMember != null)
                ? RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text('Delete'),
                    onPressed: () {
                      productProvider
                          .removeFamilyMember(widget.familyMember.id);
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
