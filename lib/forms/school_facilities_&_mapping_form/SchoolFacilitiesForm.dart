import 'dart:io';

import 'package:app17000ft/forms/school_facilities_&_mapping_form/school_facilities_controller.dart';
import 'package:app17000ft/forms/school_facilities_&_mapping_form/school_facilities_modals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app17000ft/components/custom_appBar.dart';
import 'package:app17000ft/components/custom_button.dart';
import 'package:app17000ft/components/custom_imagepreview.dart';
import 'package:app17000ft/components/custom_textField.dart';
import 'package:app17000ft/components/error_text.dart';
import 'package:app17000ft/constants/color_const.dart';
import 'package:app17000ft/forms/cab_meter_tracking_form/cab_meter_tracing_controller.dart';
import 'package:app17000ft/helper/responsive_helper.dart';
import 'package:app17000ft/tourDetails/tour_controller.dart';
import 'package:app17000ft/components/custom_dropdown.dart';
import 'package:app17000ft/components/custom_labeltext.dart';
import 'package:app17000ft/components/custom_sizedBox.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import '../../base_client/base_client.dart';
import '../../components/custom_snackbar.dart';
import '../../helper/database_helper.dart';
import '../../home/home_screen.dart';
import '../in_person_quantitative/in_person_quantitative_controller.dart';

class SchoolFacilitiesForm extends StatefulWidget {
  String? userid;
  String? office;
  final SchoolFacilitiesRecords? existingRecord;
  SchoolFacilitiesForm({
    super.key,
    this.userid,
    String? office, this.existingRecord,
  });

  @override
  State<SchoolFacilitiesForm> createState() => _SchoolFacilitiesFormState();
}

class _SchoolFacilitiesFormState extends State<SchoolFacilitiesForm> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Start of selecting Field
  String? _selectedValue = ''; // For the UDISE code
  String? _selectedValue2 = ''; // For the Residential School
  String? _selectedValue3 = ''; // For the Electricity Available
  String? _selectedValue4 = ''; // For the Internet Connectivity
  String? _selectedValue5 = ''; // For the Projector
  String? _selectedValue6 = ''; // For the Smart Classroom
  String? _selectedValue7 = ''; // For the Playground Available
  String? _selectedValue8 = ''; // For the Library Available
  String? _selectedValue9 = ''; // For the librarian training
  String? _selectedValue10 = ''; // For the librarian register
  // End of selecting Field error

  // Start of radio Field
  bool _radioFieldError = false; // For the UDISE code
  bool _radioFieldError2 = false; // For the Residential School
  bool _radioFieldError3 = false; // For the Electricity Available
  bool _radioFieldError4 = false; // For the Internet Connectivity
  bool _radioFieldError5 = false; // For the Projector
  bool _radioFieldError6 = false; // For the Smart Classroom
  bool _radioFieldError7 = false; // For the Playground Available
  bool _radioFieldError8 = false; // For the Library Available
  bool _radioFieldError9 = false; // For the librarian training
  bool _radioFieldError10 = false; // For the librarian register
  // End of radio Field error

  List<String> splitSchoolLists = [];
  String? _selectedDesignation;

  // Start of Showing Fields
  bool showBasicDetails = true; // For show Basic Details
  bool showSchoolFacilities = false; //For show and hide School Facilities
  bool showLibrary = false; //For show and hide Library
  // End of Showing Fields
  var jsonData = <String, Map<String, String>>{};
  bool validateRegister = false;
  bool _isImageUploaded = false;

  bool validateRegister2 = false;
  bool _isImageUploaded2 = false;


    @override
  void initState() {
    super.initState();

    if (!Get.isRegistered<SchoolFacilitiesController>()) {
      Get.put(SchoolFacilitiesController());
    }

    final schoolFacilitiesController =
        Get.find<SchoolFacilitiesController>();

    if (widget.existingRecord != null) {
      final existingRecord = widget.existingRecord!;

      schoolFacilitiesController.correctUdiseCodeController
          .text = existingRecord.correctUdise ?? '';
      schoolFacilitiesController.nameOfLibrarianController.text =
          existingRecord.designatedlibrarian ?? '';
      schoolFacilitiesController.noOfFunctionalClassroomController.text =
          existingRecord.noOfClassroom ?? '';
      schoolFacilitiesController.setTour(existingRecord.tourId);
   schoolFacilitiesController.setSchool(existingRecord.school);


// make this code that user can also edit the participant string
      _selectedValue = existingRecord.udiseCode;
      _selectedValue2 = existingRecord.residential;
      _selectedValue3 = existingRecord.electricity;
      _selectedValue4 = existingRecord.internet;
      _selectedValue5 = existingRecord.projector;
      _selectedValue6 = existingRecord.smartClassroom;
      _selectedValue7 = existingRecord.playground;
      _selectedValue8 = existingRecord.libraryavailable;
      _selectedValue9 = existingRecord.libaraianattendent;
      _selectedValue10 = existingRecord.registeravailable;
      _selectedDesignation = existingRecord.librarylocated;



    }
  }



  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return WillPopScope(
        onWillPop: () async {
          bool shouldPop =
              await BaseClient().showLeaveConfirmationDialog(context);
          return shouldPop;
        },
        child: Scaffold(
            appBar: const CustomAppbar(
              title: 'School Facilities & Mapping Form',
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(children: [
                      GetBuilder<SchoolFacilitiesController>(
                          init: SchoolFacilitiesController(),
                          builder: (schoolFacilitiesController) {
                            return Form(
                                key: _formKey,
                                child: GetBuilder<TourController>(
                                    init: TourController(),
                                    builder: (tourController) {
                                      tourController.fetchTourDetails();
                                      return Column(
                                        children: [
                                          if (showBasicDetails) ...[
                                            LabelText(
                                              label: 'Basic Details',
                                            ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            LabelText(
                                              label: 'Tour ID',
                                              astrick: true,
                                            ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            CustomDropdownFormField(
                                              focusNode:
                                                  schoolFacilitiesController
                                                      .tourIdFocusNode,
                                              options: tourController
                                                  .getLocalTourList
                                                  .map((e) => e.tourId)
                                                  .toList(),
                                              selectedOption:
                                                  schoolFacilitiesController
                                                      .tourValue,
                                              onChanged: (value) {
                                                splitSchoolLists =
                                                    tourController
                                                        .getLocalTourList
                                                        .where((e) =>
                                                            e.tourId == value)
                                                        .map((e) => e.allSchool
                                                            .split('|')
                                                            .toList())
                                                        .expand((x) => x)
                                                        .toList();
                                                setState(() {
                                                  schoolFacilitiesController
                                                      .setSchool(null);
                                                  schoolFacilitiesController
                                                      .setTour(value);
                                                });
                                              },
                                              labelText: "Select Tour ID",
                                            ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            LabelText(
                                              label: 'School',
                                              astrick: true,
                                            ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            DropdownSearch<String>(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Please Select School";
                                                }
                                                return null;
                                              },
                                              popupProps: PopupProps.menu(
                                                showSelectedItems: true,
                                                showSearchBox: true,
                                                disabledItemFn: (String s) =>
                                                    s.startsWith('I'),
                                              ),
                                              items: splitSchoolLists,
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  labelText: "Select School",
                                                  hintText: "Select School ",
                                                ),
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  schoolFacilitiesController
                                                      .setSchool(value);
                                                });
                                              },
                                              selectedItem:
                                                  schoolFacilitiesController
                                                      .schoolValue,
                                            ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            LabelText(
                                              label:
                                                  'Is this UDISE code is correct?',
                                              astrick: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 300),
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value: 'Yes',
                                                    groupValue: _selectedValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Yes'),
                                                ],
                                              ),
                                            ),
                                            CustomSizedBox(
                                              value: 150,
                                              side: 'width',
                                            ),
                                            // make it that user can also edit the tourId and school
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 300),
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value: 'No',
                                                    groupValue: _selectedValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('No'),
                                                ],
                                              ),
                                            ),
                                            if (_radioFieldError)
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 16.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Please select an option',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            if (_selectedValue == 'No') ...[
                                              LabelText(
                                                label:
                                                    'Write Correct UDISE school code',
                                                astrick: true,
                                              ),
                                              CustomSizedBox(
                                                value: 20,
                                                side: 'height',
                                              ),
                                              CustomTextFormField(
                                                textController:
                                                    schoolFacilitiesController
                                                        .correctUdiseCodeController,
                                                textInputType:
                                                    TextInputType.number,
                                                labelText:
                                                    'Enter correct UDISE code',
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please fill this field';
                                                  }
                                                  if (!RegExp(r'^[0-9]+$')
                                                      .hasMatch(value)) {
                                                    return 'Please enter a valid number';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              CustomSizedBox(
                                                value: 20,
                                                side: 'height',
                                              ),
                                            ],
                                            CustomButton(
                                              title: 'Next',
                                              onPressedButton: () {
                                                setState(() {
                                                  _radioFieldError =
                                                      _selectedValue == null ||
                                                          _selectedValue!
                                                              .isEmpty;
                                                });

                                                if (_formKey.currentState!
                                                        .validate() &&
                                                    !_radioFieldError) {
                                                  setState(() {
                                                    showBasicDetails = false;
                                                    showSchoolFacilities = true;
                                                  });
                                                }
                                              },
                                            ),
                                          ],
                                          // End of Basic Details

                                          // Start of School Facilities
                                          if (showSchoolFacilities) ...[
                                            LabelText(
                                              label: 'School Facilities',
                                              astrick: true,
                                            ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            LabelText(
                                              label: 'Residential School',
                                              astrick: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 300),
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value: 'Yes',
                                                    groupValue: _selectedValue2,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue2 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Yes'),
                                                ],
                                              ),
                                            ),
                                            CustomSizedBox(
                                              value: 150,
                                              side: 'width',
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 300),
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value: 'No',
                                                    groupValue: _selectedValue2,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue2 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('No'),
                                                ],
                                              ),
                                            ),
                                            if (_radioFieldError2)
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 16.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Please select an option',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            LabelText(
                                              label: 'Electricity Available',
                                              astrick: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 300),
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value: 'Yes',
                                                    groupValue: _selectedValue3,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue3 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Yes'),
                                                ],
                                              ),
                                            ),
                                            CustomSizedBox(
                                              value: 150,
                                              side: 'width',
                                            ),
                                            // make it that user can also edit the tourId and school
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 300),
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value: 'No',
                                                    groupValue: _selectedValue3,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue3 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('No'),
                                                ],
                                              ),
                                            ),
                                            if (_radioFieldError3)
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 16.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Please select an option',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            LabelText(
                                              label: 'Internet Connectivity',
                                              astrick: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 300),
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value: 'Yes',
                                                    groupValue: _selectedValue4,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue4 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Yes'),
                                                ],
                                              ),
                                            ),
                                            CustomSizedBox(
                                              value: 150,
                                              side: 'width',
                                            ),
                                            // make it that user can also edit the tourId and school
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 300),
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value: 'No',
                                                    groupValue: _selectedValue4,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue4 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('No'),
                                                ],
                                              ),
                                            ),
                                            if (_radioFieldError4)
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 16.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Please select an option',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            LabelText(
                                              label: 'Projector',
                                              astrick: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 300),
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value: 'Yes',
                                                    groupValue: _selectedValue5,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue5 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Yes'),
                                                ],
                                              ),
                                            ),
                                            CustomSizedBox(
                                              value: 150,
                                              side: 'width',
                                            ),
                                            // make it that user can also edit the tourId and school
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 300),
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value: 'No',
                                                    groupValue: _selectedValue5,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue5 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('No'),
                                                ],
                                              ),
                                            ),
                                            if (_radioFieldError5)
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 16.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Please select an option',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            LabelText(
                                              label: 'Smart Classroom',
                                              astrick: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 300),
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value: 'Yes',
                                                    groupValue: _selectedValue6,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue6 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Yes'),
                                                ],
                                              ),
                                            ),
                                            CustomSizedBox(
                                              value: 150,
                                              side: 'width',
                                            ),
                                            // make it that user can also edit the tourId and school
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 300),
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value: 'No',
                                                    groupValue: _selectedValue6,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue6 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('No'),
                                                ],
                                              ),
                                            ),
                                            if (_radioFieldError6)
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 16.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Please select an option',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            LabelText(
                                              label:
                                                  'Number of functional Classroom ',
                                              astrick: true,
                                            ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),

                                            CustomTextFormField(
                                              textController:
                                                  schoolFacilitiesController
                                                      .noOfFunctionalClassroomController,
                                              labelText: 'Enter number',
                                              textInputType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    3),
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please fill this field';
                                                }
                                                if (!RegExp(r'^[0-9]+$')
                                                    .hasMatch(value)) {
                                                  return 'Please enter a valid number';
                                                }
                                                return null;
                                              },
                                              showCharacterCount: true,
                                            ),

                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            LabelText(
                                              label: 'Playground Available',
                                              astrick: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 300),
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value: 'Yes',
                                                    groupValue: _selectedValue7,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue7 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Yes'),
                                                ],
                                              ),
                                            ),
                                            CustomSizedBox(
                                              value: 150,
                                              side: 'width',
                                            ),
                                            // make it that user can also edit the tourId and school
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 300),
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value: 'No',
                                                    groupValue: _selectedValue7,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue7 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('No'),
                                                ],
                                              ),
                                            ),
                                            if (_radioFieldError7)
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 16.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Please select an option',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            if (_selectedValue7 == 'Yes') ...[
                                              LabelText(
                                                label:
                                                    'Upload photos of Playground',
                                                astrick: true,
                                              ),
                                              CustomSizedBox(
                                                value: 20,
                                                side: 'height',
                                              ),
                                              Container(
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: _isImageUploaded ==
                                                              false
                                                          ? AppColors.primary
                                                          : AppColors.error),
                                                ),
                                                child: ListTile(
                                                    title: _isImageUploaded ==
                                                            false
                                                        ? const Text(
                                                            'Click or Upload Image',
                                                          )
                                                        : const Text(
                                                            'Click or Upload Image',
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .error),
                                                          ),
                                                    trailing: const Icon(
                                                        Icons.camera_alt,
                                                        color: AppColors
                                                            .onBackground),
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                          backgroundColor:
                                                              AppColors.primary,
                                                          context: context,
                                                          builder: ((builder) =>
                                                              schoolFacilitiesController
                                                                  .bottomSheet(
                                                                      context)));
                                                    }),
                                              ),
                                              ErrorText(
                                                isVisible: validateRegister,
                                                message:
                                                    'Playground Image Required',
                                              ),
                                              CustomSizedBox(
                                                value: 20,
                                                side: 'height',
                                              ),
                                              schoolFacilitiesController
                                                      .multipleImage.isNotEmpty
                                                  ? Container(
                                                      width: responsive
                                                          .responsiveValue(
                                                              small: 600.0,
                                                              medium: 900.0,
                                                              large: 1400.0),
                                                      height: responsive
                                                          .responsiveValue(
                                                              small: 170.0,
                                                              medium: 170.0,
                                                              large: 170.0),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child:
                                                          schoolFacilitiesController
                                                                  .multipleImage
                                                                  .isEmpty
                                                              ? const Center(
                                                                  child: Text(
                                                                      'No images selected.'),
                                                                )
                                                              : ListView
                                                                  .builder(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  itemCount:
                                                                      schoolFacilitiesController
                                                                          .multipleImage
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return SizedBox(
                                                                      height:
                                                                          200,
                                                                      width:
                                                                          200,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                CustomImagePreview.showImagePreview(schoolFacilitiesController.multipleImage[index].path, context);
                                                                              },
                                                                              child: Image.file(
                                                                                File(schoolFacilitiesController.multipleImage[index].path),
                                                                                width: 190,
                                                                                height: 120,
                                                                                fit: BoxFit.fill,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                schoolFacilitiesController.multipleImage.removeAt(index);
                                                                              });
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.delete,
                                                                              color: Colors.red,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                    )
                                                  : const SizedBox(),
                                              CustomSizedBox(
                                                value: 40,
                                                side: 'height',
                                              ),
                                            ],
                                            Row(
                                              children: [
                                                CustomButton(
                                                    title: 'Back',
                                                    onPressedButton: () {
                                                      setState(() {
                                                        showBasicDetails = true;
                                                        showSchoolFacilities =
                                                            false;
                                                      });
                                                    }),
                                                const Spacer(),
                                                CustomButton(
                                                  title: 'Next',
                                                  onPressedButton: () {
                                                    setState(() {
                                                      _radioFieldError2 =
                                                          _selectedValue2 ==
                                                                  null ||
                                                              _selectedValue2!
                                                                  .isEmpty;
                                                      _radioFieldError3 =
                                                          _selectedValue3 ==
                                                                  null ||
                                                              _selectedValue3!
                                                                  .isEmpty;
                                                      _radioFieldError4 =
                                                          _selectedValue4 ==
                                                                  null ||
                                                              _selectedValue4!
                                                                  .isEmpty;
                                                      _radioFieldError5 =
                                                          _selectedValue5 ==
                                                                  null ||
                                                              _selectedValue5!
                                                                  .isEmpty;
                                                      _radioFieldError6 =
                                                          _selectedValue6 ==
                                                                  null ||
                                                              _selectedValue6!
                                                                  .isEmpty;
                                                      _radioFieldError7 =
                                                          _selectedValue7 ==
                                                                  null ||
                                                              _selectedValue7!
                                                                  .isEmpty;

                                                      // Validate the upload photo playground only if "Yes" is selected
                                                      if (_selectedValue7 ==
                                                          'Yes') {
                                                        validateRegister =
                                                            schoolFacilitiesController
                                                                .multipleImage
                                                                .isEmpty;
                                                      } else {
                                                        validateRegister =
                                                            false;
                                                      }
                                                    });

                                                    if (_formKey.currentState!
                                                            .validate() &&
                                                        !_radioFieldError2 &&
                                                        !_radioFieldError3 &&
                                                        !_radioFieldError4 &&
                                                        !_radioFieldError5 &&
                                                        !_radioFieldError6 &&
                                                        !_radioFieldError7 &&
                                                        !validateRegister) {
                                                      setState(() {
                                                        showSchoolFacilities =
                                                            false;
                                                        showLibrary = true;
                                                      });
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                            CustomSizedBox(
                                              value: 40,
                                              side: 'height',
                                            ),
                                          ],
                                          if (showLibrary) ...[
                                            LabelText(
                                              label: 'Teacher Capacity',
                                            ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            LabelText(
                                              label: '1. Library Available?',
                                              astrick: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 300),
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value: 'Yes',
                                                    groupValue: _selectedValue8,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue8 =
                                                            value as String?;
                                                        _radioFieldError8 =
                                                            false; // Reset error state
                                                      });
                                                    },
                                                  ),
                                                  const Text('Yes'),
                                                ],
                                              ),
                                            ),
                                            CustomSizedBox(
                                              value: 150,
                                              side: 'width',
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 300),
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value: 'No',
                                                    groupValue: _selectedValue8,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue8 =
                                                            value as String?;
                                                        _radioFieldError8 =
                                                            false; // Reset error state
                                                      });
                                                    },
                                                  ),
                                                  const Text('No'),
                                                ],
                                              ),
                                            ),
                                            if (_radioFieldError8)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: const Text(
                                                    'Please select an option',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            if (_selectedValue8 == 'Yes') ...[
                                              LabelText(
                                                label:
                                                    'Where is the Library located?',
                                                astrick: true,
                                              ),
                                              CustomSizedBox(
                                                  value: 20, side: 'height'),
                                              DropdownButtonFormField<String>(
                                                decoration: InputDecoration(
                                                  labelText: 'Select an option',
                                                  border: OutlineInputBorder(),
                                                ),
                                                value: _selectedDesignation,
                                                items: [
                                                  DropdownMenuItem(
                                                      value: 'Corridor',
                                                      child: Text('Corridor')),
                                                  DropdownMenuItem(
                                                      value: 'HMs Room',
                                                      child: Text('HMs Room')),
                                                  DropdownMenuItem(
                                                      value: 'DigiLab Room',
                                                      child:
                                                          Text('DigiLab Room')),
                                                  DropdownMenuItem(
                                                      value: 'Classroom',
                                                      child: Text('Classroom')),
                                                  DropdownMenuItem(
                                                      value:
                                                          'Separate Library room',
                                                      child: Text(
                                                          'Separate Library room')),
                                                ],
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedDesignation =
                                                        value;
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Please select a designation';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              CustomSizedBox(
                                                  value: 20, side: 'height'),
                                              LabelText(
                                                label:
                                                    'Name of Designated Librarian',
                                                astrick: true,
                                              ),
                                              CustomSizedBox(
                                                  value: 20, side: 'height'),
                                              CustomTextFormField(
                                                textController:
                                                    schoolFacilitiesController
                                                        .nameOfLibrarianController,
                                                labelText: 'Enter Name',
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Write Name';
                                                  }
                                                  return null;
                                                },
                                                showCharacterCount: true,
                                              ),
                                              CustomSizedBox(
                                                  value: 20, side: 'height'),
                                              LabelText(
                                                label:
                                                    'Has the Librarian attended 17000ft centralized training?',
                                                astrick: true,
                                              ),
                                              CustomSizedBox(
                                                  value: 20, side: 'height'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 300),
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      value: 'Yes',
                                                      groupValue:
                                                          _selectedValue9,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _selectedValue9 =
                                                              value as String?;
                                                          _radioFieldError9 =
                                                              false; // Reset error state
                                                        });
                                                      },
                                                    ),
                                                    const Text('Yes'),
                                                  ],
                                                ),
                                              ),
                                              CustomSizedBox(
                                                value: 150,
                                                side: 'width',
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 300),
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      value: 'No',
                                                      groupValue:
                                                          _selectedValue9,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _selectedValue9 =
                                                              value as String?;
                                                          _radioFieldError9 =
                                                              false; // Reset error state
                                                        });
                                                      },
                                                    ),
                                                    const Text('No'),
                                                  ],
                                                ),
                                              ),
                                              if (_radioFieldError9)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: const Text(
                                                      'Please select an option',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                ),
                                              CustomSizedBox(
                                                value: 20,
                                                side: 'height',
                                              ),
                                              LabelText(
                                                label:
                                                    'Is the Librarian Register available?',
                                                astrick: true,
                                              ),
                                              CustomSizedBox(
                                                  value: 20, side: 'height'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 300),
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      value: 'Yes',
                                                      groupValue:
                                                          _selectedValue10,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _selectedValue10 =
                                                              value as String?;
                                                          _radioFieldError10 =
                                                              false; // Reset error state
                                                        });
                                                      },
                                                    ),
                                                    const Text('Yes'),
                                                  ],
                                                ),
                                              ),
                                              CustomSizedBox(
                                                value: 150,
                                                side: 'width',
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 300),
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      value: 'No',
                                                      groupValue:
                                                          _selectedValue10,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _selectedValue10 =
                                                              value as String?;
                                                          _radioFieldError10 =
                                                              false; // Reset error state
                                                        });
                                                      },
                                                    ),
                                                    const Text('No'),
                                                  ],
                                                ),
                                              ),
                                              if (_radioFieldError10)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: const Text(
                                                      'Please select an option',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                ),
                                              CustomSizedBox(
                                                value: 20,
                                                side: 'height',
                                              ),
                                              if (_selectedValue10 ==
                                                  'Yes') ...[
                                                LabelText(
                                                  label:
                                                      'Upload photos of Library Register',
                                                  astrick: true,
                                                ),
                                                CustomSizedBox(
                                                  value: 20,
                                                  side: 'height',
                                                ),
                                                Container(
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    border: Border.all(
                                                        width: 2,
                                                        color:
                                                            _isImageUploaded2 ==
                                                                    false
                                                                ? AppColors
                                                                    .primary
                                                                : AppColors
                                                                    .error),
                                                  ),
                                                  child: ListTile(
                                                      title:
                                                          _isImageUploaded2 ==
                                                                  false
                                                              ? const Text(
                                                                  'Click or Upload Image',
                                                                )
                                                              : const Text(
                                                                  'Click or Upload Image',
                                                                  style: TextStyle(
                                                                      color: AppColors
                                                                          .error),
                                                                ),
                                                      trailing: const Icon(
                                                          Icons.camera_alt,
                                                          color: AppColors
                                                              .onBackground),
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                            backgroundColor:
                                                                AppColors
                                                                    .primary,
                                                            context: context,
                                                            builder: ((builder) =>
                                                                schoolFacilitiesController
                                                                    .bottomSheet2(
                                                                        context)));
                                                      }),
                                                ),
                                                ErrorText(
                                                  isVisible: validateRegister2,
                                                  message:
                                                      'library Register Image Required',
                                                ),
                                                CustomSizedBox(
                                                  value: 20,
                                                  side: 'height',
                                                ),
                                                schoolFacilitiesController
                                                        .multipleImage2
                                                        .isNotEmpty
                                                    ? Container(
                                                        width: responsive
                                                            .responsiveValue(
                                                                small: 600.0,
                                                                medium: 900.0,
                                                                large: 1400.0),
                                                        height: responsive
                                                            .responsiveValue(
                                                                small: 170.0,
                                                                medium: 170.0,
                                                                large: 170.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child:
                                                            schoolFacilitiesController
                                                                    .multipleImage2
                                                                    .isEmpty
                                                                ? const Center(
                                                                    child: Text(
                                                                        'No images selected.'),
                                                                  )
                                                                : ListView
                                                                    .builder(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    itemCount: schoolFacilitiesController
                                                                        .multipleImage2
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return SizedBox(
                                                                        height:
                                                                            200,
                                                                        width:
                                                                            200,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: GestureDetector(
                                                                                onTap: () {
                                                                                  CustomImagePreview2.showImagePreview2(schoolFacilitiesController.multipleImage2[index].path, context);
                                                                                },
                                                                                child: Image.file(
                                                                                  File(schoolFacilitiesController.multipleImage2[index].path),
                                                                                  width: 190,
                                                                                  height: 120,
                                                                                  fit: BoxFit.fill,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  schoolFacilitiesController.multipleImage2.removeAt(index);
                                                                                });
                                                                              },
                                                                              child: const Icon(
                                                                                Icons.delete,
                                                                                color: Colors.red,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                      )
                                                    : const SizedBox(),
                                                CustomSizedBox(
                                                  value: 40,
                                                  side: 'height',
                                                ),
                                              ],
                                            ],
                                            Row(
                                              children: [
                                                CustomButton(
                                                    title: 'Back',
                                                    onPressedButton: () {
                                                      setState(() {
                                                        showSchoolFacilities =
                                                            true;
                                                        showLibrary = false;
                                                      });
                                                    }),
                                                const Spacer(),
                                                CustomButton(
                                                    title: 'Submit',
                                                    onPressedButton: () async {
                                                      setState(() {
                                                        _radioFieldError8 =
                                                            _selectedValue8 ==
                                                                    null ||
                                                                _selectedValue8!
                                                                    .isEmpty;
                                                        _radioFieldError9 =
                                                            _selectedValue8 ==
                                                                    'Yes' &&
                                                                (_selectedValue9 ==
                                                                        null ||
                                                                    _selectedValue9!
                                                                        .isEmpty);

                                                        _radioFieldError10 =
                                                            _selectedValue8 ==
                                                                    'Yes' &&
                                                                (_selectedValue10 ==
                                                                        null ||
                                                                    _selectedValue10!
                                                                        .isEmpty);

                                                        if (_selectedValue10 ==
                                                            'Yes') {
                                                          validateRegister2 =
                                                              schoolFacilitiesController
                                                                  .multipleImage2
                                                                  .isEmpty;
                                                        } else {
                                                          validateRegister2 =
                                                              false;
                                                        }
                                                      });

                                                      if (_formKey.currentState!
                                                              .validate() &&
                                                          !_radioFieldError8 &&
                                                          !_radioFieldError9 &&
                                                          !_radioFieldError10 &&
                                                          !validateRegister2) {
                                                        print('Inserted');
                                                        DateTime now =
                                                            DateTime.now();
                                                        String formattedDate =
                                                            DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(now);
                                                        SchoolFacilitiesRecords enrolmentCollectionObj = SchoolFacilitiesRecords(
                                                            tourId: schoolFacilitiesController.tourValue ??
                                                                '',
                                                            school: schoolFacilitiesController.schoolValue ??
                                                                '',
                                                            registerImage:
                                                                schoolFacilitiesController
                                                                    .imagePaths
                                                                    .toString(),
                                                            correctUdise: schoolFacilitiesController
                                                                .correctUdiseCodeController
                                                                .text,
                                                            noOfClassroom:
                                                                schoolFacilitiesController
                                                                    .noOfFunctionalClassroomController
                                                                    .text,
                                                            designatedlibrarian:
                                                                schoolFacilitiesController
                                                                    .nameOfLibrarianController
                                                                    .text,
                                                            registerImage2:
                                                                schoolFacilitiesController
                                                                    .imagePaths2
                                                                    .toString(),
                                                            udiseCode:
                                                                _selectedValue!,
                                                            residential:
                                                                _selectedValue2!,
                                                            electricity:
                                                                _selectedValue3!,
                                                            internet:
                                                                _selectedValue4!,
                                                            projector:
                                                                _selectedValue5!,
                                                            smartClassroom:
                                                                _selectedValue6!,
                                                            playground:
                                                                _selectedValue7!,
                                                            libraryavailable:
                                                                _selectedValue8!,
                                                            librarylocated:
                                                                _selectedDesignation,
                                                            libaraianattendent:
                                                                _selectedValue9!,
                                                            registeravailable:
                                                                _selectedValue10!,
                                                            createdAt:
                                                                formattedDate.toString(),
                                                            submittedBy: widget.userid.toString());

                                                        int result =
                                                            await LocalDbController()
                                                                .addData(
                                                                    schoolFacilitiesRecords:
                                                                        enrolmentCollectionObj);
                                                        if (result > 0) {
                                                          schoolFacilitiesController
                                                              .clearFields();
                                                          setState(() {
                                                            jsonData = {};
                                                          // Clear the image list
                                                            _isImageUploaded = false;
                                                            _isImageUploaded2 = false;
                                                            // Clear the image list
                                                            _selectedValue = '';
                                                            _selectedValue2 = '';
                                                            _selectedValue3 = '';
                                                            _selectedValue4 = '';
                                                            _selectedValue5 = '';
                                                            _selectedValue6 = '';
                                                            _selectedValue7 = '';
                                                            _selectedValue8 = '';
                                                            _selectedValue9 = '';
                                                            _selectedValue10 = '';


                                                          });

                                                          customSnackbar(

                                                              'Submitted Successfully',
                                                              'Submitted',
                                                              AppColors.primary,
                                                              AppColors
                                                                  .onPrimary,
                                                              Icons.verified);

                                                          // Navigate to HomeScreen
                                                          Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    HomeScreen()),
                                                          );
                                                        } else {
                                                          customSnackbar(
                                                              'Error',
                                                              'Something went wrong',
                                                              AppColors.error,
                                                              Colors.white,
                                                              Icons.error);
                                                        }
                                                      } else {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                FocusNode());
                                                      }
                                                    }),
                                              ],
                                            ),
                                          ] // end of the library
                                        ],
                                      );
                                    }));
                          })
                    ])))));
  }
}
