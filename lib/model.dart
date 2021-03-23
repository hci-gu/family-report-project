class FamilyMember {
  String id;
  String name;
  String relation;
  String age;
  String gender;
  bool isSurveyFilled = false;
  var surveyQuestionResponses = new Map();
  var qualitativeStudyResponses = new Map();
  double totalScreenTime = 0.0;
  var hourlyScreenTimeBreakdown = [];

  FamilyMember(
    this.id,
    this.name,
    this.relation,
    this.age,
    this.gender, {
    isSurveyFilled = false,
    totalScreenTime = 0.0,
  });

  static Map<String, dynamic> toJSON(FamilyMember member) {
    return {
      'name': member.name ?? '',
      'relation': member.relation ?? '',
      'age': member.age ?? '',
      'gender': member.gender ?? '',
      'isSurveyFilled': member.isSurveyFilled,
      'surveyQuestionResponses': member.surveyQuestionResponses,
      'qualitativeStudyResponses': member.qualitativeStudyResponses,
      'totalScreenTime': member.totalScreenTime,
      'hourlyScreenTimeBreakdown': member.hourlyScreenTimeBreakdown,
    };
  }

  void fromJSON(Map<String, dynamic> json, String id) {
    id = json['id'];
    name = json['name'];
    relation = json['relation'];
    age = json['age'];
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
