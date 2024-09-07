import 'dart:convert';

List<SchoolStaffVecRecords?>? schoolStaffVecRecordsFromJson(String str) =>
    str.isEmpty ? [] : List<SchoolStaffVecRecords?>.from(json.decode(str).map((x) => SchoolStaffVecRecords.fromJson(x)));

String schoolStaffVecRecordsToJson(List<SchoolStaffVecRecords?>? data) =>
    json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class SchoolStaffVecRecords {
  SchoolStaffVecRecords({
    this.id,
    this.tourId,
    this.school,
    this.udiseCode,
    this.correctUdise,
    this.nameOfHoi,
    this.genderofHoi,
    this.mobileOfHoi,
    this.emailOfHoi,
    this.desgnationOfHoi,
    this.totalTeachingStaff,
    this.totalNonTeachingStaff,
    this.totalStaff,
    this.nameOfSmc,
    this.genderOfSmc,
    this.mobileOfSmc,
    this.emailOfSmc,
    this.qualificationOfSmc,
    this.totalSmcStaff,
    this.SmcStaffMeeting,
    this.submittedBy,
    this.uid,
    this.createdAt,
    this.office,
    this.version,
    this.uniqueId,
  });

  int? id;
  String? tourId;
  String? school;
  String? udiseCode;
  String? correctUdise;
  String? nameOfHoi;
  String? genderofHoi;
  String? mobileOfHoi;
  String? emailOfHoi;
  String? desgnationOfHoi;
  int? totalTeachingStaff;
  int? totalNonTeachingStaff;
  int? totalStaff;
  String? nameOfSmc;
  String? genderOfSmc;
  String? mobileOfSmc;
  String? emailOfSmc;
  String? qualificationOfSmc;
  String? totalSmcStaff;
  String? SmcStaffMeeting;
  String? submittedBy;
  String? uid;
  String? createdAt;
  String? office;
  String? version;
  String? uniqueId;

  // Factory method to create an instance from JSON
  factory SchoolStaffVecRecords.fromJson(Map<String, dynamic> json) => SchoolStaffVecRecords(
    id: json["id"],
    tourId: json["tour_id"],
    school: json["school"],
    udiseCode: json["udise_code"],
    correctUdise: json["correctUdise"],
    nameOfHoi: json["nameOfHoi"],
    genderofHoi: json["genderofHoi"],
    mobileOfHoi: json["mobileOfHoi"],
    emailOfHoi: json["emailOfHoi"],
    desgnationOfHoi: json["desgnationOfHoi"],
    totalTeachingStaff: int.tryParse(json['totalTeachingStaff']?.toString() ?? '0'),
    totalNonTeachingStaff: int.tryParse(json['totalNonTeachingStaff']?.toString() ?? '0'),
    totalStaff: int.tryParse(json['totalStaff']?.toString() ?? '0'),
    genderOfSmc: json["genderOfSmc"],
    mobileOfSmc: json["mobileOfSmc"],
    emailOfSmc: json["emailOfSmc"],
    qualificationOfSmc: json["qualificationOfSmc"],
    totalSmcStaff: json["totalSmcStaff"],
    SmcStaffMeeting: json["SmcStaffMeeting"],
    submittedBy: json["submittedBy"],
    uid: json["uid"],
    createdAt: json["created_at"],
    office: json["office"],
    version: json["version"],
    uniqueId: json["uniqueId"],
  );

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "tour_id": tourId,
    "school": school,
    "udise_code": udiseCode,
    "correctUdise": correctUdise,
    "nameOfHoi": nameOfHoi,
    "genderofHoi": genderofHoi,
    "mobileOfHoi": mobileOfHoi,
    "emailOfHoi": emailOfHoi,
    "desgnationOfHoi": desgnationOfHoi,
    "totalTeachingStaff": totalTeachingStaff,
    "totalNonTeachingStaff": totalNonTeachingStaff,
    "totalStaff": totalStaff,
    "nameOfSmc": nameOfSmc,
    "genderOfSmc": genderOfSmc,
    "mobileOfSmc": mobileOfSmc,
    "emailOfSmc": emailOfSmc,
    "qualificationOfSmc": qualificationOfSmc,
    "totalSmcStaff": totalSmcStaff,
    "SmcStaffMeeting": SmcStaffMeeting,
    "submittedBy": submittedBy,
    "uid": uid,
    "created_at": createdAt,
    "office": office,
    "version": version,
    "uniqueId": uniqueId,
  };
}
