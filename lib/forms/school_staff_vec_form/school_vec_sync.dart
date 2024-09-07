import 'dart:convert';

import 'package:app17000ft/base_client/base_client.dart';
import 'package:app17000ft/components/custom_appBar.dart';
import 'package:app17000ft/components/custom_dialog.dart';
import 'package:app17000ft/components/custom_snackbar.dart';
import 'package:app17000ft/constants/color_const.dart';
import 'package:app17000ft/forms/school_enrolment/school_enrolment.dart';
import 'package:app17000ft/forms/school_enrolment/school_enrolment_controller.dart';
import 'package:app17000ft/forms/school_facilities_&_mapping_form/school_facilities_controller.dart';
import 'package:app17000ft/forms/school_staff_vec_form/school_vec_controller.dart';
import 'package:app17000ft/forms/school_staff_vec_form/school_vec_from.dart';
import 'package:app17000ft/helper/database_helper.dart';
import 'package:app17000ft/services/network_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SchoolStaffVecSync extends StatefulWidget {
  const SchoolStaffVecSync({super.key});

  @override
  State<SchoolStaffVecSync> createState() => _SchoolStaffVecSyncState();
}

class _SchoolStaffVecSyncState extends State<SchoolStaffVecSync> {
  final _schoolStaffVecController = Get.put(SchoolStaffVecController());
  final NetworkManager _networkManager = Get.put(NetworkManager());
  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    _schoolStaffVecController.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        bool shouldPop =
            await BaseClient().showLeaveConfirmationDialog(context);
        return shouldPop;
      },
      child: Scaffold(
        appBar: const CustomAppbar(title: 'School Staff & SMC/VEC Details'),
        body: GetBuilder<SchoolStaffVecController>(
          builder: (schoolStaffVecController) {
            return Obx(() => isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : schoolStaffVecController.schoolStaffVecList.isEmpty
                    ? const Center(
                        child: Text(
                          'No Records Found',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary),
                        ),
                      )
                    : Column(
                        children: [
                          schoolStaffVecController.schoolStaffVecList.isNotEmpty
                              ? Expanded(
                                  child: ListView.separated(
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(),
                                    itemCount: schoolStaffVecController
                                        .schoolStaffVecList.length,
                                    itemBuilder: (context, index) {
                                      final item = schoolStaffVecController
                                          .schoolStaffVecList[index];
                                      return ListTile(
                                        title: Text(
                                          "${index + 1}. Tour ID: ${item.tourId!}\n    School ${item.school}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              color: AppColors.primary,
                                              icon: const Icon(Icons.edit),
                                              onPressed: () async {
                                                final existingRecord =
                                                schoolStaffVecController
                                                    .schoolStaffVecList[
                                                index];

                                                // Debug prints
                                                print(
                                                    'Navigating to Enrollment');
                                                print(
                                                    'Existing Record: $existingRecord');

                                                IconData icon = Icons.edit;

                                                // Show the confirmation dialog
                                                bool? shouldNavigate =
                                                await showDialog<bool>(
                                                  context: context,
                                                  builder: (_) => Confirmation(
                                                    iconname: icon,
                                                    title: 'Confirm Update',
                                                    yes: 'Confirm',
                                                    no: 'Cancel',
                                                    desc:
                                                    'Are you sure you want to Update this record?',
                                                    onPressed: () {
                                                      // Close the dialog and return true to indicate confirmation
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    },
                                                  ),
                                                );

                                                // Check if the user confirmed the action
                                                if (shouldNavigate == true) {
                                                  // Debug print before navigation
                                                  print('Navigating now');

                                                  // Navigate to CabMeterTracingForm using Navigator.push
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SchoolStaffVecForm(
                                                            userid: 'userid',

                                                            existingRecord:
                                                            existingRecord,
                                                          ),
                                                    ),
                                                  );

                                                  // Debug print after navigation
                                                  print('Navigation completed');
                                                } else {
                                                  // User canceled the action
                                                  print('Navigation canceled');
                                                }
                                              },
                                            ),
                                            IconButton(
                                              color: AppColors.primary,
                                              icon: const Icon(Icons.sync),
                                              onPressed: () async {
                                                IconData icon =
                                                    Icons.check_circle;
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
                                                          if (_networkManager
                                                                  .connectionType
                                                                  .value ==
                                                              0) {
                                                            customSnackbar(
                                                                'Warning',
                                                                'You are offline please connect to the internet',
                                                                AppColors
                                                                    .secondary,
                                                                AppColors
                                                                    .onSecondary,
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
                                                              print(
                                                                  'ready to insert');
                                                              var rsp = await insertSchoolStaffVec(
                                                                  item.tourId,
                                                                  item.school,
                                                                  item.udiseCode,
                                                                  item.correctUdise,
                                                                  item.nameOfHoi,
                                                                  item.genderofHoi,
                                                                  item.mobileOfHoi,
                                                                  item.emailOfHoi,
                                                                  item.desgnationOfHoi,
                                                                  item.totalTeachingStaff,
                                                                  item.totalNonTeachingStaff,
                                                                  item.totalStaff,
                                                                  item.nameOfSmc,
                                                                  item.genderOfSmc,
                                                                  item.mobileOfSmc,
                                                                  item.emailOfSmc,
                                                                  item.qualificationOfSmc,
                                                                  item.totalSmcStaff,
                                                                  item.SmcStaffMeeting,
                                                                  item.submittedBy,
                                                                  item.uid,
                                                                  item.createdAt,
                                                                  item.office,
                                                                  item.version,
                                                                  item.uniqueId,
                                                                  item.id);
                                                              if (rsp['status'] ==
                                                                  1) {
                                                                customSnackbar(
                                                                    'Successfully',
                                                                    "${rsp['message']}",
                                                                    AppColors
                                                                        .secondary,
                                                                    AppColors
                                                                        .onSecondary,
                                                                    Icons
                                                                        .check);
                                                              } else if (rsp[
                                                                      'status'] ==
                                                                  0) {
                                                                customSnackbar(
                                                                    "Error",
                                                                    "${rsp['message']}",
                                                                    AppColors
                                                                        .error,
                                                                    AppColors
                                                                        .onError,
                                                                    Icons
                                                                        .warning);
                                                              } else {
                                                                customSnackbar(
                                                                    "Error",
                                                                    "Something went wrong, Please contact Admin",
                                                                    AppColors
                                                                        .error,
                                                                    AppColors
                                                                        .onError,
                                                                    Icons
                                                                        .warning);
                                                              }
                                                            }
                                                          }
                                                        }));
                                              },
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          schoolStaffVecController
                                              .schoolStaffVecList[index].tourId;
                                        },
                                      );
                                    },
                                  ),
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(top: 340.0),
                                  child: Center(
                                    child: Text(
                                      'No Data Found',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                        ],
                      ));
          },
        ),
      ),
    );
  }
}

var baseurl = "https://mis.17000ft.org/apis/fast_apis/";

Future insertSchoolStaffVec(
  String? tour,
  String? school,
  String? udiseCode,
  String? correctUdise,
  String? nameOfHoi,
  String? genderofHoi,
  String? mobileOfHoi,
  String? emailOfHoi,
  String? desgnationOfHoi,
  int? totalTeachingStaff,
  int? totalNonTeachingStaff,
  int? totalStaff,
  String? nameOfSmc,
  String? genderOfSmc,
  String? mobileOfSmc,
  String? emailOfSmc,
  String? qualificationOfSmc,
  String? totalSmcStaff,
  String? SmcStaffMeeting,
  String? submittedBy,
  String? uid,
  String? createdAt,
  String? office,
  String? version,
  String? uniqueId,
  int? id,
) async {
  print('this is enrolment DAta');
  print(tour);
  print(school);
  print(createdAt);
  print(id);

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
          table: 'new_enrolmentCollection',
          field: 'id',
        );

        await Get.find<SchoolFacilitiesController>().fetchData();
      }
    } else {
      var responseBody = await response.stream.bytesToString();
      parsedResponse = json.decode(responseBody);
      print('this is by cdpo firm');
      print(responseBody);
    }
    return parsedResponse;
  } catch (error) {}
}
