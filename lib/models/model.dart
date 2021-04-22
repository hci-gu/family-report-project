class FamilyMember {
  String id;
  String name;
  String relation;
  String age;
  String gender;
  bool isSurveyFilled = false;
  var surveyQuestionResponses = new Map();
  var qualitativeStudyResponses = new Map();
  var totalScreenTime = new Map();
  var hourlyScreenTimeBreakdown = new Map();

  FamilyMember({
    this.id,
    this.name,
    this.relation,
    this.age,
    this.gender,
    this.qualitativeStudyResponses,
    this.surveyQuestionResponses,
    this.hourlyScreenTimeBreakdown,
    this.totalScreenTime,
    this.isSurveyFilled,
  });
}
