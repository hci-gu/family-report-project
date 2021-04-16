import 'package:family_report_project/models/model.dart';
import 'package:family_report_project/services/api.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FamilyMemberProvider with ChangeNotifier {
  var firestoreService;
  var uuid = Uuid();

  FamilyMemberProvider(String collectionName) {
    this.firestoreService = Api(collectionName);
  }

  //this is to save temporary states till we decide to save the states in firebase
  String _name;
  String _relation;
  String _age;
  String _gender;
  String _id;
  bool _isSurveyFilled;
  var _surveyQuestionResponses = new Map();
  var _qualitativeStudyResponses = new Map();
  double _totalScreenTime;
  var _hourlyScreenTimeBreakdown;

  //Getters
  String get name => _name;
  String get relation => _relation;
  String get age => _age;
  String get gender => _gender;
  bool get isSurveyFilled => _isSurveyFilled;
  Map get surveyQuestionResponses => _surveyQuestionResponses;
  Map get qualitativeStudyResponses => _qualitativeStudyResponses;
  double get totalScreenTime => _totalScreenTime;
  List get hourlyScreenTimeBreakdown => _hourlyScreenTimeBreakdown;

  //Setters
  changeFamilyMemberName(String value) {
    _name = value;
    notifyListeners();
  }

  changeFamilyMemberRelation(String value) {
    _relation = value;
    notifyListeners();
  }

  changeFamilyMemberAge(String value) {
    _age = value;
    notifyListeners();
  }

  changeFamilyMemberGender(String value) {
    _gender = value;
    notifyListeners();
  }

  changeIsSurveyFilled(bool value) {
    _isSurveyFilled = value;
    notifyListeners();
  }

  changeSurveyQuestionResponses(Map value) {
    _surveyQuestionResponses = value;
    notifyListeners();
  }

  changeQualitativeStudyResponses(Map value) {
    _qualitativeStudyResponses = value;
    notifyListeners();
  }

  changeTotalScreenTime(double value) {
    _totalScreenTime = value;
    notifyListeners();
  }

  changeHourlyScreenTimeBreakdown(List value) {
    _hourlyScreenTimeBreakdown = value;
    notifyListeners();
  }

  loadFamilyMemberData(FamilyMember member) {
    _name = member.name;
    _id = member.id;
    _relation = member.relation;
    _age = member.age;
    _gender = member.gender;
    _isSurveyFilled = member.isSurveyFilled;
    _surveyQuestionResponses = member.surveyQuestionResponses;
    _qualitativeStudyResponses = member.qualitativeStudyResponses;
    _totalScreenTime = member.totalScreenTime;
    _hourlyScreenTimeBreakdown = member.hourlyScreenTimeBreakdown;
  }

  saveFamilyMember() {
    print(name);
    print(_id);
    if (_id == null) {
      //create new family member
      var newFamilyMember = FamilyMember(
          id: uuid.v4(),
          name: name,
          relation: relation,
          age: age,
          gender: gender);
      firestoreService.saveFamilyMember(newFamilyMember);
    } else {
      //Update existing family member
      var updatedFamilyMember = FamilyMember.withOtherData(
          _id,
          _name,
          _relation,
          _age,
          _gender,
          _isSurveyFilled,
          _surveyQuestionResponses,
          _qualitativeStudyResponses,
          _totalScreenTime,
          _hourlyScreenTimeBreakdown);
      firestoreService.saveFamilyMember(updatedFamilyMember);
    }
  }

  removeFamilyMember(String id) {
    firestoreService.removeFamilyMember(id);
  }
}
