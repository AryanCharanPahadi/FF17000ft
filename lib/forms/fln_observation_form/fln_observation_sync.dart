import 'dart:convert';

import 'package:app17000ft/base_client/base_client.dart';
import 'package:app17000ft/components/custom_appBar.dart';
import 'package:app17000ft/components/custom_dialog.dart';
import 'package:app17000ft/components/custom_snackbar.dart';
import 'package:app17000ft/constants/color_const.dart';
import 'package:app17000ft/forms/fln_observation_form/fln_observation_controller.dart';
import 'package:app17000ft/forms/in_person_quantitative/in_person_quantitative_controller.dart';
import 'package:app17000ft/forms/school_enrolment/school_enrolment_controller.dart';
import 'package:app17000ft/helper/database_helper.dart';
import 'package:app17000ft/services/network_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FlnObservationSync extends StatefulWidget {
  const FlnObservationSync({super.key});

  @override
  State<FlnObservationSync> createState() => _FlnObservationSync();
}

class _FlnObservationSync extends State<FlnObservationSync> {
  final FlnObservationController _flnObservationController =
      Get.put(FlnObservationController());
  final NetworkManager _networkManager = Get.put(NetworkManager());
  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    _flnObservationController.fetchData();
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
        appBar: const CustomAppbar(title: 'FLN Observation Sync'),
        body: GetBuilder<FlnObservationController>(
          builder: (flnObservationController) {
            if (flnObservationController.flnObservationList.isEmpty) {
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
                          itemCount: flnObservationController
                              .flnObservationList.length,
                          itemBuilder: (context, index) {
                            final item = flnObservationController
                                .flnObservationList[index];
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
                                                    print(item.submittedAt);
                                                    var rsp =
                                                        await insertAlfaObservation(
                                                      item.tourId,
                                                      item.school,
                                                      item.udiseValue,
                                                      item.correctUdise,
                                                      item.noStaffTrained,
                                                      item.imgNurTimeTable,
                                                      item.imgLKGTimeTable,
                                                      item.imgUKGTimeTable,
                                                      item.lessonPlanValue,
                                                      item.activityValue,
                                                      item.imgActvity,
                                                      item.imgTLM,
                                                      item.baselineValue,
                                                      item.baselineGradeReport,
                                                      item.flnConductValue,
                                                      item.flnGadeReport,
                                                      item.imgFLN,
                                                      item.refresherValue,
                                                      item.numTrainedTeacher,
                                                      item.imgTraining,
                                                      item.readingValue,
                                                      item.libGradeReport,
                                                      item.imglib,
                                                      item.methodologyValue,
                                                      item.imgClass,
                                                      item.observation,
                                                      item.created_by,
                                                      item.createdAt,
                                                      item.submittedAt,
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
                                flnObservationController
                                    .flnObservationList[index].tourId;
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

Future insertAlfaObservation(
  String? tourId,
  String? school,
  String? udiseValue,
  String? correctUdise,
  String? noStaffTrained,
  String? imgNurTimeTable,
  String? imgLKGTimeTable,
  String? imgUKGTimeTable,
  String? lessonPlanValue,
  String? activityValue,
  String? imgActvity,
  String? imgTLM,
  String? baselineValue,
  String? baselineGradeReport,
  String? flnConductValue,
  String? flnGadeReport,
  String? imgFLN,
  String? refresherValue,
  String? numTrainedTeacher,
  String? imgTraining,
  String? readingValue,
  String? libGradeReport,
  String? imglib,
  String? methodologyValue,
  String? imgClass,
  String? observation,
  String? created_by,
  String? createdAt,
  String? submittedAt,
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
