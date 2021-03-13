class FamilyMember {
  String name;
  String relation;
  String age;
  bool isSurveyFilled = false;
  var surveyQuestionResponses = new Map();
  var qualitativeStudyResponses = new Map();
  double totalScreenTime = 0.0;
  var hourlyScreenTimeBreakdown = [];

  FamilyMember({this.name, this.relation, this.age});

  static Map<String, dynamic> toJSON(FamilyMember member) {
    return {
      'name': member.name,
      'relation': member.relation,
      'age': member.age,
      'isSurveyFilled': member.isSurveyFilled,
      'surveyQuestionResponses': member.surveyQuestionResponses,
      'qualitativeStudyResponses': member.qualitativeStudyResponses,
      'totalScreenTime': member.totalScreenTime,
      'hourlyScreenTimeBreakdown': member.hourlyScreenTimeBreakdown,
    };
  }

  void setSurveyQuestions(String questionNumber, String answer) {
    this.surveyQuestionResponses[questionNumber] = answer;
  }

  void setQualitativeStudyResponses(String questionNumber, String answer) {
    this.qualitativeStudyResponses[questionNumber] = answer;
  }

  void changeFamilyMemberName(String newName) {
    this.name = newName;
  }

  void changeFamilyMemberRelation(String newRelation) {
    this.relation = newRelation;
  }

  void changeFamilyMemberAge(String newAge) {
    this.age = newAge;
  }

  void setScreenTimeUsage(
      double totalScreenTime, List hourlyScreenTimeBreakdown) {
    this.totalScreenTime = totalScreenTime;
    this.hourlyScreenTimeBreakdown = hourlyScreenTimeBreakdown;
  }
}
