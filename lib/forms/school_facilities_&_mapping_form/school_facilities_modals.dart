import 'dart:convert';

List<SchoolFacilitiesRecords?>? schoolFacilitiesRecordsFromJson(String str) =>
    str.isEmpty ? [] : List<SchoolFacilitiesRecords?>.from(json.decode(str).map((x) => SchoolFacilitiesRecords.fromJson(x)));
String SchoolFacilitiesRecordsToJson(List<SchoolFacilitiesRecords?>? data) =>
    json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));
class SchoolFacilitiesRecords {
  SchoolFacilitiesRecords({
    this.id,
    this.tourId,
    this.school,
    this.udiseCode,
    this.correctUdise,
    this.registerImage,
    this.residential,
    this.electricity,
    this.internet,
    this.projector,
    this.smartClassroom,
    this.noOfClassroom,
    this.playground,
    this.registerImage2,
    this.libraryavailable,
    this.librarylocated,
    this.designatedlibrarian,
    this.libaraianattendent,
    this.registeravailable,
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
  String? registerImage;
  String? residential;
  String? electricity;
  String? internet;
  String? projector;
  String? smartClassroom;
  String? noOfClassroom;
  String? playground;
  String? registerImage2;
  String? libraryavailable;
  String? librarylocated;
  String? designatedlibrarian;
  String? libaraianattendent;
  String? registeravailable;
  String? submittedBy;
  String? uid;
  String? createdAt;
  String? office;
  String? version;
  String? uniqueId;

  factory SchoolFacilitiesRecords.fromJson(Map<String, dynamic> json) => SchoolFacilitiesRecords(
    id: json["id"],
    tourId: json["tour_id"],
    school: json["school"],
    udiseCode: json["udise_code"],
    correctUdise: json["correctUdise"],
    registerImage: json["registerImage"],
    residential: json["residential"],
    electricity: json["electricity"],
    internet: json["internet"],
    projector: json["projector"],
    smartClassroom: json["smartClassroom"],
    noOfClassroom: json["noOfClassroom"],
    playground: json["playground"],
    registerImage2: json["registerImage2"],
    libraryavailable: json["libraryavailable"],
    librarylocated: json["librarylocated"],
    designatedlibrarian: json["designatedlibrarian"],
    libaraianattendent: json["libaraianattendent"],
    registeravailable: json["registeravailable"],
    submittedBy: json["submittedBy"],
    uid: json["uid"],
    createdAt: json["created_at"],
    office: json["office"],
    version: json["version"],
    uniqueId: json["uniqueId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tour_id": tourId,
    "school": school,
    "udise_code": udiseCode,
    "correctUdise": correctUdise,
    "registerImage": registerImage,
    "residential": residential,
    "electricity": electricity,
    "internet": internet,
    "projector": projector,
    "smartClassroom": smartClassroom,
    "noOfClassroom": noOfClassroom,
    "playground": playground,
    "registerImage2": registerImage2,
    "libraryavailable": libraryavailable,
    "librarylocated": librarylocated,
    "designatedlibrarian": designatedlibrarian,
    "libaraianattendent": libaraianattendent,
    "registeravailable": registeravailable,
    "submittedBy": submittedBy,
    "uid": uid,
    "created_at": createdAt,
    "office": office,
    "version": version,
    "uniqueId": uniqueId,
  };
}
