import 'dart:convert';

import 'package:app17000ft/base_client/base_client.dart';
import 'package:app17000ft/components/custom_appBar.dart';
import 'package:app17000ft/components/custom_dialog.dart';
import 'package:app17000ft/components/custom_snackbar.dart';
import 'package:app17000ft/constants/color_const.dart';
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

import 'alfa_observation_controller.dart';



class AlfaObservationSync extends StatefulWidget {
  const AlfaObservationSync({super.key});

  @override
  State<AlfaObservationSync> createState() => _AlfaObservationSync();
}

class _AlfaObservationSync extends State<AlfaObservationSync> {
  final AlfaObservationController _alfaObservationController = Get.put(AlfaObservationController());
  final NetworkManager _networkManager = Get.put(NetworkManager());
  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    _alfaObservationController.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldPop = await BaseClient().showLeaveConfirmationDialog(context);
        return shouldPop;
      },
      child: Scaffold(
        appBar: const CustomAppbar(title: 'Alfa Observation Sync'),
        body: GetBuilder<AlfaObservationController>(
          builder: (alfaObservationController) {
            if (alfaObservationController.alfaObservationList.isEmpty) {
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
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                    itemCount: alfaObservationController.alfaObservationList.length,
                    itemBuilder: (context, index) {
                      final item = alfaObservationController.alfaObservationList[index];
                      return ListTile(
                        title: Text(
                          "${index + 1}. Tour ID: ${item.tourId!}\n    School: ${item.school!}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
                                        desc: 'Are you sure you want to Sync?',
                                        onPressed: () async {
                                          setState(() {
                                            // isLoadings= true;
                                          });
                                          if (_networkManager.connectionType.value == 0) {
                                            customSnackbar(
                                                'Warning',
                                                'You are offline please connect to the internet',
                                                AppColors.secondary,
                                                AppColors.onSecondary,
                                                Icons.warning);
                                          } else {
                                            if (_networkManager.connectionType.value == 1 ||
                                                _networkManager.connectionType.value == 2) {
                                              print('ready to insert');
                                              print(item.submittedAt);
                                              var rsp = await insertAlfaObservation(
                                                item.tourId,
                                                item.school,
                                                item.udiseValue,
                                                item.correctUdise,
                                                item.noStaffTrained,
                                                item.imgNurTimeTable,
                                                item.imgLKGTimeTable,
                                                item.imgUKGTimeTable,
                                                item.bookletValue,
                                                item.moduleValue,
                                                item.numeracyBooklet,
                                                item.numeracyValue,
                                                item.pairValue,
                                                item.alfaActivityValue,
                                                item.alfaGradeReport,
                                                item.imgAlfa,
                                                item.refresherTrainingValue,
                                                item.noTrainedTeacher,
                                                item.imgTraining,
                                                item.readingValue,
                                                item.libGradeReport,
                                                item.imgLibrary,
                                                item.tlmKitValue,
                                                item.imgTlm,
                                                item.classObservation,
                                                item.createdAt,
                                                item.submittedAt,
                                                item.createdBy,
                                                item.id,

                                              );

                                              if (rsp['status'] == 1) {
                                                customSnackbar(
                                                    'Successfully',
                                                    "${rsp['message']}",
                                                    AppColors.secondary,
                                                    AppColors.onSecondary,
                                                    Icons.check);
                                              } else if (rsp['status'] == 0) {
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
                          alfaObservationController.alfaObservationList[index].tourId;
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


var baseurl = "https://mis.17000ft.org/17000ft_apis/alfaObservation/insert_alfa.php";
Future insertAlfaObservation(
    String? tourId,
    String? school,
    String? udiseValue,
    String? correctUdise,
    String? noStaffTrained,
    String? imgNurTimeTable,
    String? imgLKGTimeTable,
    String? imgUKGTimeTable,
    String? bookletValue,
    String? moduleValue,
    String? numeracyBooklet,
    String? numeracyValue,
    String? pairValue,
    String? alfaActivityValue,
    String? alfaGradeReport,
    String? imgAlfa,
    String? refresherTrainingValue,
    String? noTrainedTeacher,
    String? imgTraining,
    String? readingValue,
    String? libGradeReport,
    String? imgLibrary,
    String? tlmKitValue,
    String? imgTLM,
    String? classObservation,
    String? createdAt,
    String? submittedAt,
    String? createdBy,
    int? id,

    ) async {
  if (kDebugMode) {
    print('Inserting Alfa Observation Data');
    print(tourId);
    print(school);
    print(id);
    print(imgTraining);

  }

  var request = http.MultipartRequest(
    'POST',
    Uri.parse(baseurl),
  );
  request.headers["Accept"] = "Application/json";

  // Add text fields with null checks
  request.fields.addAll({

    'tourId': tourId ?? '',
    'school': school ?? '',
    'udiseValue': udiseValue ?? '',
    'correctUdise': correctUdise ?? '',
    'noStaffTrained': noStaffTrained ?? '',
    'imgNurTimeTable': imgNurTimeTable ?? '',
    'imgLKGTimeTable': imgLKGTimeTable ?? '',
    'imgUKGTimeTable': imgUKGTimeTable ?? '',
    'bookletValue': bookletValue ?? '',
    'moduleValue': moduleValue ?? '',
    'numeracyBooklet': numeracyBooklet ?? '',
    'numeracyValue': numeracyValue ?? '',
    'pairValue': pairValue ?? '',
    'alfaActivityValue': alfaActivityValue ?? '',
    'alfaGradeReport': alfaGradeReport ?? '',
    'imgAlfa': imgAlfa ?? '',
    'refresherTrainingValue': refresherTrainingValue ?? '',
    'noTrainedTeacher': noTrainedTeacher ?? '',
    'imgTraining': imgTraining ?? '',
    'readingValue': readingValue ?? '',
    'libGradeReport': libGradeReport ?? '',
    'imgLibrary': imgLibrary ?? '',
    'tlmKitValue': tlmKitValue ?? '',
    'imgTLM': imgTLM ?? '',
    'classObservation': classObservation ?? '',
    'createdAt': createdAt ?? '',
    'submittedAt': submittedAt ?? '',
    'createdBy': createdBy ?? '',
    'id': id?.toString() ?? '0',  // Default to '0' if id is null
  });

  try {
    var response = await request.send();
    var parsedResponse;

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      if (responseBody.isEmpty) {
        return {"status": 0, "message": "Empty response from server"};
      }
      try {
        parsedResponse = json.decode(responseBody);
      } catch (e) {
        print('Error decoding JSON: $e');
        return {"status": 0, "message": "Invalid response format"};
      }

      // If sync is successful
      if (parsedResponse['status'] == 1) {
        // Delete the record from local database
        await SqfliteDatabaseHelper().queryDelete(
          arg: id.toString(),
          table: 'alfaObservation',
          field: 'id',
        );
        print("Record with id $id deleted from local database.");

        // Fetch the updated data
        await Get.find<AlfaObservationController>().fetchData();
      }
    } else {
      var responseBody = await response.stream.bytesToString();
      print('Server Error Response Body: $responseBody');
      return {"status": 0, "message": "Server returned an error"};
    }
    return parsedResponse;
  } catch (error) {
    print("Error: $error");
    return {"status": 0, "message": "Something went wrong, Please contact Admin"};
  }
}
