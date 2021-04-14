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

  FamilyMember({
    this.id,
    this.name,
    this.relation,
    this.age,
    this.gender,
    isSurveyFilled = false,
    totalScreenTime = 0.0,
  });

  FamilyMember.withOtherData(
      String id,
      String name,
      String relation,
      String age,
      String gender,
      bool isSurveyFilled,
      Map<String, String> surveyQuestionResponses,
      Map<String, String> qualitativeStudyResponses,
      double totalScreenTime,
      var hourlyScreenTimeBreakdown) {
    this.name = name;
    this.gender = gender;
    this.relation = relation;
    this.id = id;
    this.age = age;
    this.isSurveyFilled = isSurveyFilled;
    this.surveyQuestionResponses = surveyQuestionResponses;
    this.qualitativeStudyResponses = qualitativeStudyResponses;
    this.totalScreenTime = totalScreenTime;
    this.hourlyScreenTimeBreakdown = hourlyScreenTimeBreakdown;
  }
  Map<String, dynamic> toJSON() {
    return {
      'name': name ?? '',
      'relation': relation ?? '',
      'age': age ?? '',
      'id': id ?? '',
      'gender': gender ?? '',
      'isSurveyFilled': isSurveyFilled,
      'surveyQuestionResponses': surveyQuestionResponses,
      'qualitativeStudyResponses': qualitativeStudyResponses,
      'totalScreenTime': totalScreenTime,
      'hourlyScreenTimeBreakdown': hourlyScreenTimeBreakdown,
    };
  }

  FamilyMember.fromJSON(Map<String, dynamic> json) {
    print(json);
    id = json['id'];
    name = json['name'];
    relation = json['relation'];
    age = json['age'];
  }
}
