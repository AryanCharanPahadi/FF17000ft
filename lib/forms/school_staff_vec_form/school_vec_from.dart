import 'dart:convert';
import 'dart:io';

import 'package:app17000ft/forms/school_facilities_&_mapping_form/school_facilities_controller.dart';
import 'package:app17000ft/forms/school_facilities_&_mapping_form/school_facilities_modals.dart';
import 'package:app17000ft/forms/school_staff_vec_form/school_vec_controller.dart';
import 'package:app17000ft/forms/school_staff_vec_form/school_vec_modals.dart';
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

class SchoolStaffVecForm extends StatefulWidget {
  String? userid;
  String? office;
  final SchoolStaffVecRecords? existingRecord;
  SchoolStaffVecForm({
    super.key,
    this.userid,
    String? office,
    this.existingRecord,
  });
  @override
  State<SchoolStaffVecForm> createState() => _SchoolStaffVecFormState();
}

class _SchoolStaffVecFormState extends State<SchoolStaffVecForm> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> splitSchoolLists = [];
  String? _selectedDesignation;
  String? _selected2Designation;
  String? _selected3Designation;
  // Start of Showing Fields
  bool showBasicDetails = true; // For show Basic Details
  bool showStaffDetails = false; //For show and hide School Facilities
  bool showSmcVecDetails = false; //For show and hide Library
  // End of Showing Fields

  // Start of selecting Field
  String? _selectedValue = ''; // For the UDISE code
  String? _selectedValue2 = ''; // For the Gender
  String? _selectedValue3 = ''; // For the Gender2
  // End of selecting Field error

  // Start of radio Field
  bool _radioFieldError = false; // For the UDISE code
  bool _radioFieldError2 = false; // For the Gender
  bool _radioFieldError3 = false; // For the Gender2

  // End of radio Field error

  final SchoolStaffVecController _controllers = SchoolStaffVecController();



  @override
  void initState() {
    super.initState();

    // Ensure the controller is registered
    if (!Get.isRegistered<SchoolStaffVecController>()) {
      Get.put(SchoolStaffVecController());
    }

    // Get the controller instance
    final schoolStaffVecController = Get.find<SchoolStaffVecController>();

    // Check if this is in edit mode (i.e., if an existing record is provided)
    if (widget.existingRecord != null) {
      final existingRecord = widget.existingRecord!;
      print("This is edit mode: ${existingRecord.tourId.toString()}");
      print(jsonEncode(existingRecord));

      // Populate the controllers with existing data
      schoolStaffVecController.correctUdiseCodeController.text =
          existingRecord.correctUdise ?? '';
      schoolStaffVecController.nameOfHoiController.text =
          existingRecord.nameOfHoi ?? '';
      schoolStaffVecController.staffPhoneNumberController.text =
          existingRecord.mobileOfHoi ?? ''; // Use mobileOfHoi for staffPhoneNumber
      schoolStaffVecController.emailController.text =
          existingRecord.emailOfHoi ?? '';
      schoolStaffVecController.nameOfchairpersonController.text =
          existingRecord.nameOfSmc ?? '';
      schoolStaffVecController.email2Controller.text =
          existingRecord.emailOfSmc ?? '';
      schoolStaffVecController.totalVecStaffController.text =
          existingRecord.totalSmcStaff ?? '';
      schoolStaffVecController.chairPhoneNumberController.text =
          existingRecord.mobileOfSmc ?? '';
      _controllers.totalTeachingStaffController.text = (existingRecord.totalTeachingStaff?.toString() ?? '0');
      _controllers.totalNonTeachingStaffController.text = (existingRecord.totalNonTeachingStaff?.toString() ?? '0');
      _controllers.totalStaffController.text = (existingRecord.totalStaff?.toString() ?? '0');
      // Set other dropdown values
      _selectedValue = existingRecord.udiseCode;
      _selectedValue2 = existingRecord.genderofHoi;
      _selectedValue3 = existingRecord.genderOfSmc;
      _selectedDesignation = existingRecord.desgnationOfHoi;
      _selected2Designation = existingRecord.qualificationOfSmc;
      _selected3Designation = existingRecord.SmcStaffMeeting;

      // Set other fields related to tour and school
      schoolStaffVecController.setTour(existingRecord.tourId);
      schoolStaffVecController.setSchool(existingRecord.school);
    }
  }

  void _updateTotalStaff() {
    final totalTeachingStaff =
        int.tryParse(_controllers.totalTeachingStaffController.text) ?? 0;
    final totalNonTeachingStaff =
        int.tryParse(_controllers.totalNonTeachingStaffController.text) ?? 0;
    final totalStaff = totalTeachingStaff + totalNonTeachingStaff;

    _controllers.totalStaffController.text = totalStaff.toString();
  }
  @override
  void dispose() {
    _controllers.totalTeachingStaffController.dispose();
    _controllers.totalNonTeachingStaffController.dispose();
    _controllers.totalStaffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsive = Responsive(context);
    return WillPopScope(
      onWillPop: () async {
        bool shouldPop =
            await BaseClient().showLeaveConfirmationDialog(context);
        return shouldPop;
      },
      child: Scaffold(
          appBar: const CustomAppbar(
            title: 'School Staff & SMC/VEC Details',
          ),
          body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(children: [
                    GetBuilder<SchoolStaffVecController>(
                        init: SchoolStaffVecController(),
                        builder: (schoolStaffVecController) {
                          return Form(
                              key: _formKey,
                              child: GetBuilder<TourController>(
                                  init: TourController(),
                                  builder: (tourController) {
                                    tourController.fetchTourDetails();
                                    return Column(children: [
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
                                          focusNode: schoolStaffVecController
                                              .tourIdFocusNode,
                                          options: tourController
                                              .getLocalTourList
                                              .map((e) => e.tourId)
                                              .toList(),
                                          selectedOption:
                                              schoolStaffVecController
                                                  .tourValue,
                                          onChanged: (value) {
                                            splitSchoolLists = tourController
                                                .getLocalTourList
                                                .where((e) => e.tourId == value)
                                                .map((e) => e.allSchool
                                                    .split('|')
                                                    .toList())
                                                .expand((x) => x)
                                                .toList();
                                            setState(() {
                                              schoolStaffVecController
                                                  .setSchool(null);
                                              schoolStaffVecController
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
                                              const DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              labelText: "Select School",
                                              hintText: "Select School ",
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              schoolStaffVecController
                                                  .setSchool(value);
                                            });
                                          },
                                          selectedItem: schoolStaffVecController
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
                                          padding:
                                              const EdgeInsets.only(right: 300),
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
                                          padding:
                                              const EdgeInsets.only(right: 300),
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
                                              alignment: Alignment.centerLeft,
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
                                                schoolStaffVecController
                                                    .correctUdiseCodeController,
                                            textInputType: TextInputType.number,
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
                                            print('submit Basic Details');
                                            setState(() {
                                              _radioFieldError =
                                                  _selectedValue == null ||
                                                      _selectedValue!.isEmpty;
                                            });

                                            if (_formKey.currentState!
                                                    .validate() &&
                                                !_radioFieldError) {
                                              setState(() {
                                                showBasicDetails = false;
                                                showStaffDetails = true;
                                              });
                                            }
                                          },
                                        ),

                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                      ],
                                      // End of Basic Details

                                      //start of staff Details
                                      if (showStaffDetails) ...[
                                        LabelText(
                                          label: 'Staff Details',
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        LabelText(
                                          label: 'Name Of Head Of Institute',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                            value: 20, side: 'height'),
                                        CustomTextFormField(
                                          textController:
                                              schoolStaffVecController
                                                  .nameOfHoiController,
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
                                          label: 'Gender',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                            value: 20, side: 'height'),

                                        // Wrapping in a LayoutBuilder to adjust based on available width
                                        LayoutBuilder(
                                          builder: (context, constraints) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Radio(
                                                      value: 'Male',
                                                      groupValue:
                                                          _selectedValue2,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _selectedValue2 =
                                                              value as String?;
                                                          _radioFieldError2 =
                                                              false; // Reset error state
                                                        });
                                                      },
                                                    ),
                                                    const Text('Male'),
                                                  ],
                                                ),
                                                SizedBox(
                                                    width: screenWidth *
                                                        0.1), // Adjust spacing based on screen width
                                                Row(
                                                  children: [
                                                    Radio(
                                                      value: 'Female',
                                                      groupValue:
                                                          _selectedValue2,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _selectedValue2 =
                                                              value as String?;
                                                          _radioFieldError2 =
                                                              false; // Reset error state
                                                        });
                                                      },
                                                    ),
                                                    const Text('Female'),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        ),

                                        if (_radioFieldError2)
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        CustomSizedBox(
                                            value: 20, side: 'height'),

                                        LabelText(
                                          label: 'Mobile Number',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        CustomTextFormField(
                                          textController:
                                              schoolStaffVecController
                                                  .staffPhoneNumberController,
                                          labelText: 'Enter Mobile Number',
                                          textInputType: TextInputType.number,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                10),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please Enter Mobile';
                                            }

                                            // Regex for validating Indian phone number
                                            String pattern = r'^[6-9]\d{9}$';
                                            RegExp regex = RegExp(pattern);

                                            if (!regex.hasMatch(value)) {
                                              return 'Enter a valid Mobile number';
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
                                          label: 'Email ID',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        CustomTextFormField(
                                          textController:
                                              schoolStaffVecController
                                                  .emailController,
                                          labelText: 'Enter Email',
                                          textInputType:
                                              TextInputType.emailAddress,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please Enter Email';
                                            }

                                            // Regular expression for validating email
                                            final emailRegex = RegExp(
                                              r'^[^@]+@[^@]+\.[^@]+$',
                                              caseSensitive: false,
                                            );

                                            if (!emailRegex.hasMatch(value)) {
                                              return 'Please Enter a Valid Email Address';
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
                                          label: 'Designation',
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
                                                value:
                                                    'HeadMaster/HeadMistress',
                                                child: Text(
                                                    'HeadMaster/HeadMistress')),
                                            DropdownMenuItem(
                                                value: 'Principal',
                                                child: Text('Principal')),
                                            DropdownMenuItem(
                                                value: 'Incharge',
                                                child: Text('Incharge')),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedDesignation = value;
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
                                              'Total Teaching Staff (Including Head Of Institute)',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                            value: 20, side: 'height'),
                                        CustomTextFormField(
                                          textController: _controllers
                                              .totalTeachingStaffController,
                                          labelText: 'Enter Teaching Staff',
                                          textInputType: TextInputType.number,

                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please Enter Number';
                                            }
                                            return null;
                                          },
                                          showCharacterCount: true,
                                          onChanged: (value) =>
                                              _updateTotalStaff(), // Update total staff when this field changes
                                        ),
                                        CustomSizedBox(
                                            value: 20, side: 'height'),
                                        LabelText(
                                          label: 'Total Non Teaching Staff',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                            value: 20, side: 'height'),
                                        CustomTextFormField(
                                          textController: _controllers
                                              .totalNonTeachingStaffController,
                                          labelText: 'Enter Teaching Staff',
                                          textInputType: TextInputType.number,

                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please Enter Number';
                                            }
                                            return null;
                                          },
                                          showCharacterCount: true,
                                          onChanged: (value) =>
                                              _updateTotalStaff(), // Update total staff when this field changes
                                        ),
                                        CustomSizedBox(
                                            value: 20, side: 'height'),
                                        LabelText(
                                          label: 'Total Staff',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                            value: 20, side: 'height'),
                                        CustomTextFormField(
                                          textController:
                                              _controllers.totalStaffController,
                                          labelText: 'Enter Teaching Staff',

                                          showCharacterCount: true,
                                          readOnly:
                                              true, // Make this field read-only
                                        ),
                                        CustomSizedBox(
                                            value: 20, side: 'height'),
                                        Row(
                                          children: [
                                            CustomButton(
                                                title: 'Back',
                                                onPressedButton: () {
                                                  setState(() {
                                                    showBasicDetails = true;
                                                    showStaffDetails = false;
                                                    false;
                                                  });
                                                }),
                                            const Spacer(),
                                            CustomButton(
                                              title: 'Next',
                                              onPressedButton: () {
                                                print(_controllers
                                                    .totalTeachingStaffController);
                                                print(_controllers
                                                    .totalNonTeachingStaffController);
                                                print('submit staff details');
                                                setState(() {
                                                  _radioFieldError2 =
                                                      _selectedValue2 == null ||
                                                          _selectedValue2!
                                                              .isEmpty;
                                                });

                                                if (_formKey.currentState!
                                                        .validate() &&
                                                    !_radioFieldError2) {
                                                  setState(() {
                                                    showStaffDetails = false;
                                                    showSmcVecDetails = true;
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
                                      ], //end of staff details

                                      // start of staff vec details
                                      if (showSmcVecDetails) ...[
                                        LabelText(
                                          label: 'SMC VEC Details',
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        LabelText(
                                          label: 'Name Of SMC/VEC chairperson',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                            value: 20, side: 'height'),
                                        CustomTextFormField(
                                          textController:
                                              schoolStaffVecController
                                                  .nameOfchairpersonController,
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
                                    label: 'Gender',
                                    astrick: true,
                                    ),
                                    CustomSizedBox(value: 20, side: 'height'),

                                    // Wrapping in a LayoutBuilder to adjust based on available width
                                    LayoutBuilder(
                                    builder: (context, constraints) {
                                    return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                    Row(
                                    children: [
                                    Radio(
                                    value: 'Male',
                                    groupValue: _selectedValue3,
                                    onChanged: (value) {
                                    setState(() {
                                    _selectedValue3 = value as String?;
                                    _radioFieldError3 = false; // Reset error state
                                    });
                                    },
                                    ),
                                    const Text('Male'),
                                    ],
                                    ),
                                    SizedBox(width: screenWidth * 0.1), // Adjust spacing based on screen width
                                    Row(
                                    children: [
                                    Radio(
                                    value: 'Female',
                                    groupValue: _selectedValue3,
                                    onChanged: (value) {
                                    setState(() {
                                    _selectedValue3 = value as String?;
                                    _radioFieldError3 = false; // Reset error state
                                    });
                                    },
                                    ),
                                    const Text('Female'),
                                    ],
                                    ),
                                    ],
                                    );
                                    },
                                    ),

                                    if (_radioFieldError3)
                                    Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: const Text(
                                    'Please select an option',
                                    style: TextStyle(color: Colors.red),
                                    ),
                                    ),
                                    CustomSizedBox(value: 20, side: 'height'),

                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        LabelText(
                                          label: 'Mobile Number',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        CustomTextFormField(
                                          textController:
                                              schoolStaffVecController
                                                  .chairPhoneNumberController,
                                          labelText: 'Enter Mobile Number',
                                          textInputType: TextInputType.number,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                10),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please Enter Mobile';
                                            }

                                            // Regex for validating Indian phone number
                                            String pattern = r'^[6-9]\d{9}$';
                                            RegExp regex = RegExp(pattern);

                                            if (!regex.hasMatch(value)) {
                                              return 'Enter a valid Mobile number';
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
                                          label: 'Email ID',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        CustomTextFormField(
                                          textController:
                                              schoolStaffVecController
                                                  .email2Controller,
                                          labelText: 'Enter Email',
                                          textInputType:
                                              TextInputType.emailAddress,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please Enter Email';
                                            }

                                            // Regular expression for validating email
                                            final emailRegex = RegExp(
                                              r'^[^@]+@[^@]+\.[^@]+$',
                                              caseSensitive: false,
                                            );

                                            if (!emailRegex.hasMatch(value)) {
                                              return 'Please Enter a Valid Email Address';
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
                                          label:
                                              'Highest Education Qualification',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                            value: 20, side: 'height'),
                                        DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Select an option',
                                            border: OutlineInputBorder(),
                                          ),
                                          value: _selected2Designation,
                                          items: [
                                            DropdownMenuItem(
                                                value: 'Non Graduate',
                                                child: Text('Non Graduate')),
                                            DropdownMenuItem(
                                                value: 'Graduate',
                                                child: Text('Graduate')),
                                            DropdownMenuItem(
                                                value: 'Post Graduate',
                                                child: Text('Post Graduate')),
                                            DropdownMenuItem(
                                                value: 'Others',
                                                child: Text('Others')),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              _selected2Designation = value;
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
                                          label: 'Total SMC VEC Staff',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                            value: 20, side: 'height'),
                                        CustomTextFormField(
                                          textController:
                                              schoolStaffVecController
                                                  .totalVecStaffController,
                                          labelText:
                                              'Enter Total SMC VEC member',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Write Number';
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
                                          label:
                                              'How often does the school hold an SMC/VEC meeting',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                            value: 20, side: 'height'),
                                        DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Select an option',
                                            border: OutlineInputBorder(),
                                          ),
                                          value: _selected3Designation,
                                          items: [
                                            DropdownMenuItem(
                                                value: 'Once a month',
                                                child: Text('Once a month')),
                                            DropdownMenuItem(
                                                value: 'Once a quarter',
                                                child: Text('Once a quarter')),
                                            DropdownMenuItem(
                                                value: 'Once in 6 months',
                                                child:
                                                    Text('Once in 6 months')),
                                            DropdownMenuItem(
                                                value: 'Once a year',
                                                child: Text('Once a year')),
                                            DropdownMenuItem(
                                                value: 'Others',
                                                child: Text('Others')),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              _selected3Designation = value;
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
                                        Row(
                                          children: [
                                            CustomButton(
                                                title: 'Back',
                                                onPressedButton: () {
                                                  setState(() {
                                                    showStaffDetails = true;
                                                    showSmcVecDetails = false;
                                                  });
                                                }),
                                            const Spacer(),
                                            CustomButton(
                                                title: 'Submit',
                                                onPressedButton: () async {
                                                  print(_controllers
                                                      .totalTeachingStaffController);
                                                  print(_controllers
                                                      .totalNonTeachingStaffController);
                                                  setState(() {
                                                    _radioFieldError3 =
                                                        _selectedValue3 ==
                                                                null ||
                                                            _selectedValue3!
                                                                .isEmpty;
                                                  });
                                                  if (_formKey.currentState!
                                                          .validate() &&
                                                      !_radioFieldError3) {
                                                    print('Submit Vec Details');

                                                    DateTime now =
                                                        DateTime.now();
                                                    String formattedDate =
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(now);
                                                    SchoolStaffVecRecords enrolmentCollectionObj = SchoolStaffVecRecords(
                                                        tourId: schoolStaffVecController.tourValue ??
                                                            '',
                                                        school: schoolStaffVecController.schoolValue ??
                                                            '',
                                                        udiseCode:
                                                            _selectedValue!,
                                                        correctUdise: schoolStaffVecController
                                                            .correctUdiseCodeController
                                                            .text,
                                                        nameOfHoi: schoolStaffVecController
                                                            .nameOfHoiController
                                                            .text,
                                                        mobileOfHoi: schoolStaffVecController
                                                            .staffPhoneNumberController
                                                            .text,
                                                        emailOfHoi:
                                                            schoolStaffVecController
                                                                .emailController
                                                                .text,
                                                        totalTeachingStaff: int.tryParse(_controllers.totalTeachingStaffController.text) ?? 0,
                                                        totalNonTeachingStaff: int.tryParse(_controllers.totalNonTeachingStaffController.text) ?? 0,
                                                        totalStaff: int.tryParse(_controllers.totalStaffController.text) ?? 0,
                                                        mobileOfSmc: schoolStaffVecController.chairPhoneNumberController.text,
                                                        emailOfSmc: schoolStaffVecController.email2Controller.text,
                                                        totalSmcStaff: schoolStaffVecController.totalVecStaffController.text,
                                                        genderofHoi: _selectedValue2!,
                                                        genderOfSmc: _selectedValue3!,
                                                        desgnationOfHoi: _selectedDesignation!,
                                                        SmcStaffMeeting: _selected3Designation!,
                                                        qualificationOfSmc: _selected2Designation!,
                                                        createdAt: formattedDate.toString(),
                                                        submittedBy: widget.userid.toString());

                                                    int result =
                                                        await LocalDbController()
                                                            .addData(
                                                                schoolStaffVecRecords:
                                                                    enrolmentCollectionObj);
                                                    if (result > 0) {
                                                      schoolStaffVecController
                                                          .clearFields();
                                                      setState(() {
                                                        // Clear the image list
                                                        _selectedValue = '';
                                                        _selectedValue2 = '';
                                                        _selectedValue3 = '';
                                                      });

                                                      customSnackbar(
                                                          'Submitted Successfully',
                                                          'Submitted',
                                                          AppColors.primary,
                                                          AppColors.onPrimary,
                                                          Icons.verified);

                                                      // Navigate to HomeScreen
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const HomeScreen()),
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
                                      ] // End of staff vec details
                                    ]);
                                  }));
                        })
                  ])))),
    );
  }
}
