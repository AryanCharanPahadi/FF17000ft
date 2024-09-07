import 'dart:convert';

import 'package:app17000ft/base_client/base_client.dart';
import 'package:app17000ft/components/custom_appBar.dart';
import 'package:app17000ft/components/custom_dialog.dart';
import 'package:app17000ft/components/custom_snackbar.dart';
import 'package:app17000ft/constants/color_const.dart';
import 'package:app17000ft/forms/fln_observation_form/fln_observation_controller.dart';
import 'package:app17000ft/forms/in_person_quantitative/in_person_quantitative_controller.dart';
import 'package:app17000ft/forms/school_enrolment/school_enrolment_controller.dart';
import 'package:app17000ft/forms/school_recce_form/school_recce_controller.dart';
import 'package:app17000ft/helper/database_helper.dart';
import 'package:app17000ft/services/network_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SchoolRecceSync extends StatefulWidget {
  const SchoolRecceSync({super.key});

  @override
  State<SchoolRecceSync> createState() => _SchoolRecceSync();
}

class _SchoolRecceSync extends State<SchoolRecceSync> {
  final SchoolRecceController _schoolRecceController =
  Get.put(SchoolRecceController());
  final NetworkManager _networkManager = Get.put(NetworkManager());
  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    _schoolRecceController.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldPop =
        await BaseClient().showLeaveConfirmationDialog(context);
        return shouldPop;
      },
      child: Scaffold(
        appBar: const CustomAppbar(title: 'School Recce Sync'),
        body: GetBuilder<SchoolRecceController>(
          builder: (schoolRecceController) {
            if (schoolRecceController.schoolRecceList.isEmpty) {
              return const Center(
                child: Text(
                  'No Records Found',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary),
                ),
              );
            }

            return Obx(() => isLoading.value
                ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
                : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                    itemCount: schoolRecceController
                        .schoolRecceList.length,
                    itemBuilder: (context, index) {
                      final item = schoolRecceController
                          .schoolRecceList[index];
                      return ListTile(
                        title: Text(
                          "${index + 1}. Tour ID: ${item.tourId!}\n    School: ${item.school!}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              color: AppColors.primary,
                              icon: const Icon(Icons.sync),
                              onPressed: () async {
                                IconData icon = Icons.check_circle;
                                showDialog(
                                    context: context,
                                    builder: (_) => Confirmation(
                                        iconname: icon,
                                        title: 'Confirm',
                                        yes: 'Confirm',
                                        no: 'Cancel',
                                        desc:
                                        'Are you sure you want to Sync?',
                                        onPressed: () async {
                                          setState(() {
                                            // isLoadings= true;
                                          });
                                          if (_networkManager
                                              .connectionType.value ==
                                              0) {
                                            customSnackbar(
                                                'Warning',
                                                'You are offline please connect to the internet',
                                                AppColors.secondary,
                                                AppColors.onSecondary,
                                                Icons.warning);
                                          } else {
                                            if (_networkManager
                                                .connectionType
                                                .value ==
                                                1 ||
                                                _networkManager
                                                    .connectionType
                                                    .value ==
                                                    2) {
                                              print('ready to insert');

                                              var rsp =
                                              await insertSchoolRecce(
                                                item.tourId,
                                                item.school,
                                                item.udiseValue,
                                                item.udise_correct,
                                                item.boardImg,
                                                item.buildingImg,
                                                item.gradeTaught,
                                                item.instituteHead,
                                                item.headDesignation,
                                                item.headPhone,
                                                item.headEmail,
                                                item.appointedYear,
                                                item.noTeachingStaff,
                                                item.noNonTeachingStaff,
                                                item.totalStaff,
                                                item.registerImg,
                                                item.smcHeadName,
                                                item.smcPhone,
                                                item.smcQual,
                                                item.qualOther,
                                                item.totalSmc,
                                                item.meetingDuration,
                                                item.meetingOther,
                                                item.smcDesc,
                                                item.noUsableClass,
                                                item.electricityAvailability,
                                                item.networkAvailability,
                                                item.digitalLearning,
                                                item.smartClassImg,
                                                item.projectorImg,
                                                item.computerImg,
                                                item.libraryExisting,
                                                item.libImg,
                                                item.playGroundSpace,
                                                item.spaceImg,
                                                item.enrollmentReport,
                                                item.enrollmentImg,
                                                item.academicYear,
                                                item.gradeReportYear1,
                                                item.gradeReportYear2,
                                                item.gradeReportYear3,
                                                item.DigiLabRoomImg,
                                                item.libRoomImg,
                                                item.remoteInfo,
                                                item.motorableRoad,
                                                item.languageSchool,
                                                item.languageOther,
                                                item.supportingNgo,
                                                item.otherNgo,
                                                item.observationPoint,
                                                item.submittedBy,
                                                item.createdAt,
                                                item.id,
                                              );

                                              if (rsp['status'] == 1) {
                                                customSnackbar(
                                                    'Successfully',
                                                    "${rsp['message']}",
                                                    AppColors.secondary,
                                                    AppColors.onSecondary,
                                                    Icons.check);
                                              } else if (rsp['status'] ==
                                                  0) {
                                                customSnackbar(
                                                    "Error",
                                                    "${rsp['message']}",
                                                    AppColors.error,
                                                    AppColors.onError,
                                                    Icons.warning);
                                              } else {
                                                customSnackbar(
                                                    "Error",
                                                    "Something went wrong, Please contact Admin",
                                                    AppColors.error,
                                                    AppColors.onError,
                                                    Icons.warning);
                                              }
                                            }
                                          }
                                        }));
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          schoolRecceController
                              .schoolRecceList[index].tourId;
                        },
                      );
                    },
                  ),
                ),
              ],
            ));
          },
        ),
      ),
    );
  }
}

var baseurl = "https://mis.17000ft.org/apis/fast_apis/";

Future insertSchoolRecce(
    String? tourId,
    String? school,
    String? udiseValue,
String? udise_correct,
String? boardImg,
String? buildingImg,
String? gradeTaught,
String? instituteHead,
String? headDesignation,
String? headPhone,
String? headEmail,
String? appointedYear,
String? noTeachingStaff,
String? noNonTeachingStaff,
String? totalStaff,
String? registerImg,
String? smcHeadName,
String? smcPhone,
String? smcQual,
String? qualOther,
String? totalSmc,
String? meetingDuration,
String? meetingOther,
String? smcDesc,
String? noUsableClass,
String? electricityAvailability,
String? networkAvailability,
String? digitalLearning,
String? smartClassImg,
String? projectorImg,
String? computerImg,
String? libraryExisting,
String? libImg,
String? playGroundSpace,
String? spaceImg,
String? enrollmentReport,
String? enrollmentImg,
String? academicYear,
String? gradeReportYear1,
String? gradeReportYear2,
String? gradeReportYear3,
String? DigiLabRoomImg,
String? libRoomImg,
String? remoteInfo,
String? motorableRoad,
String? languageSchool,
String? languageOther,
String? supportingNgo,
String? otherNgo,
String? observationPoint,
String? submittedBy,
String? createdAt,
    int? id,
    ) async {
  if (kDebugMode) {
    print('this is In person quantitative DAta');
    print(tourId);
    print(school);
  }

  var request = http.MultipartRequest(
      'POST', Uri.parse('${baseurl}insert_cdpo_survey2024.php'));
  request.headers["Accept"] = "Application/json";

  // Add text fields
  request.fields.addAll({});

  try {
    var response = await request.send();
    var parsedResponse;

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      parsedResponse = json.decode(responseBody);
      if (parsedResponse['status'] == 1) {
        await SqfliteDatabaseHelper().queryDelete(
          arg: id.toString(),
          table: 'inPerson_Qualitative',
          field: 'id',
        );

        await Get.find<FlnObservationController>().fetchData();
      }
    } else {
      var responseBody = await response.stream.bytesToString();
      parsedResponse = json.decode(responseBody);
      print('this is by cdpo firm');
      print(responseBody);
    }
    return parsedResponse;
  } catch (error) {
    print("Error: $error");
    return {
      "status": 0,
      "message": "Something went wrong, Please contact Admin"
    };
  }
}
