import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:uuid/uuid.dart';  // Import the uuid package
import 'package:app17000ft/forms/issue_tracker/issue_tracker_modal.dart';
import 'package:app17000ft/forms/issue_tracker/play_issue_modal.dart';
import 'package:app17000ft/forms/school_staff_vec_form/school_vec_controller.dart';
import 'package:http/http.dart' as http;
import 'package:app17000ft/forms/school_staff_vec_form/school_vec_modals.dart';
import 'package:app17000ft/home/home_controller.dart';
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
import 'issue_tracker_controller.dart';
import 'lib_issue_modal.dart';

class IssueTrackerForm extends StatefulWidget {
  String? userid;
  String? office;
  final SchoolStaffVecRecords? existingRecord;
  IssueTrackerForm({
    super.key,
    this.userid,
    String? office,
    this.existingRecord,
  });
  @override
  State<IssueTrackerForm> createState() => _IssueTrackerFormState();
}

class _IssueTrackerFormState extends State<IssueTrackerForm> {

  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> splitSchoolLists = [];
  List<Map<String, dynamic>> issues = [];

  late final String uniqueId;





  String? _selectedResolvedBy;
  List<String> _filteredStaffNames2 = []; // for alexa
  String? _selectedResolvedBy2;
  List<String> _filteredStaffNames = []; // for classroom
  String? _selectedResolvedBy3;
  List<String> _filteredStaffNames3 = []; // for li brary
  String? _selectedResolvedBy4;
  List<String> _filteredStaffNames4 = []; // for playground
  String? _selectedResolvedBy5;
  List<String> _filteredStaffNames5 = []; // for digiLab
  bool _isLoading = true;

  final HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    _fetchFilteredStaffNames();
    _fetchFilteredStaffNames2();
    _fetchFilteredStaffNames3();
    _fetchFilteredStaffNames4();
    _fetchFilteredStaffNames5();
    uniqueId = UniqueIdGenerator.generate(8); // Generate a 6-digit ID
    print('Generated Unique ID: $uniqueId');
  }

  Future<void> _fetchFilteredStaffNames() async {
    const String url = 'https://mis.17000ft.org/17000ft_apis/allStaff.php';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        String? office =
            controller.office; // Get the office value from HomeController

        // Filter the staff based on matching location and office
        List<String> filteredStaff = data.where((item) {
          String location = item['location'] ?? '';
          return location == office;
        }).map<String>((item) {
          String firstName = item['first_name'] ?? '';
          String lastName = item['last_name'] ?? '';
          return '$firstName $lastName';
        }).toList();

        setState(() {
          _filteredStaffNames = filteredStaff;
          _isLoading = false;
        });
      } else {
        print(
            'Failed to load staff names. Status code: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching staff names: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchFilteredStaffNames2() async {
    const String url = 'https://mis.17000ft.org/17000ft_apis/allStaff.php';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        String? office =
            controller.office; // Get the office value from HomeController

        // Filter the staff based on matching location and office
        List<String> filteredStaff2 = data.where((item) {
          String location = item['location'] ?? '';
          return location == office;
        }).map<String>((item) {
          String firstName = item['first_name'] ?? '';
          String lastName = item['last_name'] ?? '';
          return '$firstName $lastName';
        }).toList();

        setState(() {
          _filteredStaffNames2 = filteredStaff2;
          _isLoading = false;
        });
      } else {
        print(
            'Failed to load staff names. Status code: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching staff names: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchFilteredStaffNames3() async {
    const String url = 'https://mis.17000ft.org/17000ft_apis/allStaff.php';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        String? office =
            controller.office; // Get the office value from HomeController

        // Filter the staff based on matching location and office
        List<String> filteredStaff3 = data.where((item) {
          String location = item['location'] ?? '';
          return location == office;
        }).map<String>((item) {
          String firstName = item['first_name'] ?? '';
          String lastName = item['last_name'] ?? '';
          return '$firstName $lastName';
        }).toList();

        setState(() {
          _filteredStaffNames3 = filteredStaff3;
          _isLoading = false;
        });
      } else {
        print(
            'Failed to load staff names. Status code: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching staff names: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchFilteredStaffNames4() async {
    const String url = 'https://mis.17000ft.org/17000ft_apis/allStaff.php';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        String? office =
            controller.office; // Get the office value from HomeController

        // Filter the staff based on matching location and office
        List<String> filteredStaff4 = data.where((item) {
          String location = item['location'] ?? '';
          return location == office;
        }).map<String>((item) {
          String firstName = item['first_name'] ?? '';
          String lastName = item['last_name'] ?? '';
          return '$firstName $lastName';
        }).toList();

        setState(() {
          _filteredStaffNames4 = filteredStaff4;
          _isLoading = false;
        });
      } else {
        print(
            'Failed to load staff names. Status code: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching staff names: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchFilteredStaffNames5() async {
    const String url = 'https://mis.17000ft.org/17000ft_apis/allStaff.php';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        String? office =
            controller.office; // Get the office value from HomeController

        // Filter the staff based on matching location and office
        List<String> filteredStaff5 = data.where((item) {
          String location = item['location'] ?? '';
          return location == office;
        }).map<String>((item) {
          String firstName = item['first_name'] ?? '';
          String lastName = item['last_name'] ?? '';
          return '$firstName $lastName';
        }).toList();

        setState(() {
          _filteredStaffNames5 = filteredStaff5;
          _isLoading = false;
        });
      } else {
        print(
            'Failed to load staff names. Status code: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching staff names: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  var jsonData = <String, Map<String, String>>{};
  bool validateRegister = false;
  bool _isImageUploaded = false;

  bool validateRegister2 = false;
  bool _isImageUploaded2 = false;

  bool validateRegister3 = false;
  bool _isImageUploaded3 = false;

  bool validateRegister4 = false;
  bool _isImageUploaded4 = false;

  bool validateRegister5 = false;
  bool _isImageUploaded5 = false;

  // Start of Showing Fields
  bool showBasicDetails = true; // For show Basic Details
  bool showLibrary = false; // For show Library
  bool showPlayground = false; // For show Playground
  bool showDigiLab = false; // For show Playground
  bool showClassroom = false; // For show classroom
  bool showAlexa = false; // For show alexa

  // End of Showing Fields

  String? _selectedValue = ''; // For the UDISE code
  String? _selectedValue2 = ''; // For the issue of library
  String? _selectedValue3 = ''; // For the which part of library issue
  String? _selectedValue4 = ''; // For the issue reported by
  String? _selectedValue5 = ''; // For the library issue status
  String? _selectedValue6 = ''; // For the issue of playground
  String? _selectedValue7 = ''; // For the  which part of playground issue
  String? _selectedValue8 = ''; // For the  issue reported by playground
  String? _selectedValue9 = ''; // For the  playground issue status
  String? _selectedValue10 = ''; // For the issue of DigiLab
  String? _selectedValue11 = ''; // For the issue reported by digiLab
  String? _selectedValue12 = ''; // For the digiLab issue status
  String? _selectedValue13 = ''; // For the part of digilab issue
  String? _selectedValue14 = ''; // For the issue of Classroom
  String? _selectedValue15 = ''; // For the part of classroom issue
  String? _selectedValue16 = ''; // For the issue reported by Clssssroom
  String? _selectedValue17 = ''; // For the Classroom issue status
  String? _selectedValue18 = ''; // For the issue of alexa
  String? _selectedValue19 = ''; // For the part of alexa issue
  String? _selectedValue20 = ''; // For the issue reported by alexa
  String? _selectedValue21 = ''; // For the alexa issue status

  // End of selecting Field error

  // Start of radio Field
  bool _radioFieldError = false; // For the UDISE code
  bool _radioFieldError2 = false; // For the issue of library
  bool _radioFieldError3 = false; // For the which part of library issue
  bool _radioFieldError4 = false; // For the  issue reported by
  bool _radioFieldError5 = false; // For the  library issue status
  bool _radioFieldError6 = false; // For the  issue of playground
  bool _radioFieldError7 = false; // For the  which part of playground issue
  bool _radioFieldError8 = false; // For the  issue reported by playground
  bool _radioFieldError9 = false; // For the  playground issue status
  bool _radioFieldError10 = false; // For the issue of DigiLab
  bool _radioFieldError11 = false; // For the issue reported by digiLab
  bool _radioFieldError12 = false; // For the digiLab issue status
  bool _radioFieldError13 = false; // For the part of digilab issue
  bool _radioFieldError14 = false; // For the issue of Classroom
  bool _radioFieldError15 = false; // For the part of classroom issue
  bool _radioFieldError16 = false; // For the issue reported by Clssssroom
  bool _radioFieldError17 = false; // For the Classroom issue status
  bool _radioFieldError18 = false; // For the issue of alexa
  bool _radioFieldError19 = false; // For the part of alexa issue
  bool _radioFieldError20 = false; // For the issue reported by alexa
  bool _radioFieldError21 = false; // For the alexa issue status

  bool _dateFieldError = false; // For the date
  bool _dateFieldError2 = false; // For the date
  bool _dateFieldError3 = false; // For the date
  bool _dateFieldError4 = false; // For the date
  bool _dateFieldError5 = false; // For the date
  bool _dateFieldError6 = false; // For the date
  bool _dateFieldError7 = false; // For the date
  bool _dateFieldError8 = false; // For the date
  bool _dateFieldError9 = false; // For the date
  bool _dateFieldError10 = false; // For the date

  // End of radio Field error

  final IssueTrackerController issueTrackerController =
      Get.put(IssueTrackerController());

  Future<void> _selectDate(BuildContext context) async {
    // library issue reported on
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        issueTrackerController.dateController.text =
            "${picked.toLocal()}".split(' ')[0];
        _dateFieldError = false;
      });
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    // library issue resolved on
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        issueTrackerController.dateController2.text =
            "${picked.toLocal()}".split(' ')[0];
        _dateFieldError2 = false;
      });
    }
  }

  Future<void> _selectDate3(BuildContext context) async {
    // library issue resolved on
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        issueTrackerController.dateController3.text =
            "${picked.toLocal()}".split(' ')[0];
        _dateFieldError3 = false;
      });
    }
  }

  Future<void> _selectDate4(BuildContext context) async {
    // library issue resolved on
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        issueTrackerController.dateController4.text =
            "${picked.toLocal()}".split(' ')[0];
        _dateFieldError4 = false;
      });
    }
  }

  Future<void> _selectDate5(BuildContext context) async {
    // library issue resolved on
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        issueTrackerController.dateController5.text =
            "${picked.toLocal()}".split(' ')[0];
        _dateFieldError5 = false;
      });
    }
  }

  Future<void> _selectDate6(BuildContext context) async {
    // library issue resolved on
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        issueTrackerController.dateController6.text =
            "${picked.toLocal()}".split(' ')[0];
        _dateFieldError6 = false;
      });
    }
  }

  Future<void> _selectDate7(BuildContext context) async {
    // library issue resolved on
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        issueTrackerController.dateController7.text =
            "${picked.toLocal()}".split(' ')[0];
        _dateFieldError7 = false;
      });
    }
  }

  Future<void> _selectDate8(BuildContext context) async {
    // library issue resolved on
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        issueTrackerController.dateController8.text =
            "${picked.toLocal()}".split(' ')[0];
        _dateFieldError8 = false;
      });
    }
  }

  Future<void> _selectDate9(BuildContext context) async {
    // library issue resolved on
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        issueTrackerController.dateController9.text =
            "${picked.toLocal()}".split(' ')[0];
        _dateFieldError9 = false;
      });
    }
  }

  Future<void> _selectDate10(BuildContext context) async {
    // library issue resolved on
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        issueTrackerController.dateController10.text =
            "${picked.toLocal()}".split(' ')[0];
        _dateFieldError10 = false;
      });
    }
  }

  List<Map<String, String?>> lib_issuesList = [];

  void _addIssue() {
    // Validate form fields
    bool isValid = true;

    // If "Did you find any issues in the Library?" is 'No', set all fields to null
    if (_selectedValue2 == 'No') {
      setState(() {
        _selectedValue3 = null;
        _selectedValue4 = null;
        _selectedValue5 = null;
        _selectedResolvedBy3 = null;
        issueTrackerController.libraryDescriptionController.clear();
        issueTrackerController.multipleImage.clear();
        issueTrackerController.dateController.clear();
        issueTrackerController.dateController2.clear();
      });

      lib_issuesList.add({
        'lib_issue': 'No',
        'lib_issue_value': null,
        'lib_desc': null,
        'reported_on': null,
        'resolved_on': null,
        'reported_by': null,
        'resolved_by': null,
        'issue_status': null,
        'lib_issue_img': null,
        'unique_id': uniqueId, // Add unique ID here
      });

      // Reset form for next input
      _resetForm();
    } else {
      // Validate "Did you find any issues in the Library?" field
      if (_selectedValue2 == null || _selectedValue2!.isEmpty) {
        setState(() {
          _radioFieldError2 = true;
        });
        isValid = false;
      } else {
        setState(() {
          _radioFieldError2 = false;
        });
      }

      // Validate Library part selection if the user answered "Yes"
      if (_selectedValue2 == 'Yes') {
        if (_selectedValue3 == null || _selectedValue3!.isEmpty) {
          setState(() {
            _radioFieldError3 = true;
          });
          isValid = false;
        } else {
          setState(() {
            _radioFieldError3 = false;
          });
        }
      }

      // Validate Issue Reported By selection
      if (_selectedValue4 == null || _selectedValue4!.isEmpty) {
        setState(() {
          _radioFieldError4 = true;
        });
        isValid = false;
      } else {
        setState(() {
          _radioFieldError4 = false;
        });
      }

      // Validate "Resolved On" date field if the issue status is 'Closed'
      if (_selectedValue5 == 'Closed' && issueTrackerController.dateController2.text.isEmpty) {
        setState(() {
          _dateFieldError2 = true;
        });
        isValid = false;
      } else {
        setState(() {
          _dateFieldError2 = false;
        });
      }

      // Validate image upload
      if (issueTrackerController.multipleImage.isEmpty) {
        setState(() {
          validateRegister = true;
        });
        isValid = false;
      } else {
        setState(() {
          validateRegister = false;
        });
      }

      // Validate "Library Issue Reported On" date field
      if (issueTrackerController.dateController.text.isEmpty) {
        setState(() {
          _dateFieldError = true;
        });
        isValid = false;
      } else {
        setState(() {
          _dateFieldError = false;
        });
      }

      // If all validations pass, add the issue
      if (isValid && (_formKey.currentState!.validate())) {
        setState(() {
          List<String> imagePaths = issueTrackerController.multipleImage
              .map((imageFile) => imageFile.path)
              .toList();

          // Add issue to the list
          lib_issuesList.add({
            'lib_issue': _selectedValue2 ?? 'No', // Default to 'No' if null
            'lib_issue_value': _selectedValue3 ?? '', // Default to empty if null
            'lib_desc': issueTrackerController.libraryDescriptionController.text,
            'reported_on': issueTrackerController.dateController.text,
            'resolved_on': issueTrackerController.dateController2.text,
            'reported_by': _selectedValue4 ?? '', // Default to empty if null
            'resolved_by': _selectedResolvedBy3 ?? '', // Default to empty if null
            'issue_status': _selectedValue5 ?? '', // Default to empty if null
            'lib_issue_img': imagePaths.join(', '),
            'unique_id': uniqueId, // Add unique ID here
          });

          // Reset form for next input
          _resetForm();
        });
      }
    }
  }

  void _resetForm() {
    _selectedValue2 = '';
    _selectedValue3 = '';
    _selectedValue4 = '';
    _selectedValue5 = '';
    _selectedResolvedBy3 = null; // Reset staff name selection
    issueTrackerController.libraryDescriptionController.clear();
    issueTrackerController.multipleImage.clear();
    issueTrackerController.dateController.clear();
    issueTrackerController.dateController2.clear();
  }


  List<Map<String, String>> issuesList2 = [];
  void _addIssue2() {
    // Validate form fields
    bool isValid = true;

    // Validate Library part selection
    if (_selectedValue7 == null || _selectedValue7!.isEmpty) {
      setState(() {
        _radioFieldError7 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _radioFieldError7 = false;
      });
    }

    // Validate Issue Reported By selection
    if (_selectedValue8 == null || _selectedValue8!.isEmpty) {
      setState(() {
        _radioFieldError8 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _radioFieldError8 = false;
      });
    }

    if (_dateFieldError4 = _selectedValue9 == 'Closed' &&
        issueTrackerController.dateController4.text.isEmpty) {
      setState(() {
        _dateFieldError4 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _dateFieldError4 = false;
      });
    }

    if (_selectedValue9 == null || _selectedValue9!.isEmpty) {
      setState(() {
        _radioFieldError9 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _radioFieldError9 = false;
      });
    }

    // Validate image upload
    if (issueTrackerController.multipleImage2.isEmpty) {
      setState(() {
        validateRegister2 = true;
      });
      isValid = false;
    } else {
      setState(() {
        validateRegister2 = false;
      });
    }

    // Validate "Library Issue Reported On" date field
    if (issueTrackerController.dateController3.text.isEmpty) {
      setState(() {
        _dateFieldError3 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _dateFieldError3 = false;
      });
    }

    // If all validations pass, add the issue
    if (isValid && (_formKey.currentState!.validate())) {
      setState(() {
        List<String> imagePaths2 = issueTrackerController.multipleImage2
            .map((imageFile) => imageFile.path)
            .toList();
        String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
        issuesList2.add({
          'play_issue': _selectedValue6!,
          'play_issue_value': _selectedValue7!,
          'play_desc':
              issueTrackerController.playgroundDescriptionController.text,
          'reported_on': issueTrackerController.dateController3.text,
          'resolved_on': issueTrackerController.dateController4.text,
          'reported_by': _selectedValue8!,
          'resolved_by': _selectedResolvedBy4 ?? '',
          'issue_status': _selectedValue9!,
          'play_issue_img': imagePaths2.join(', '),
          'unique_id': uniqueId, // Add unique ID here
        });

        _resetForm2();
      });
    }
  }

  void _resetForm2() {
    _selectedValue6 = '';
    _selectedValue7 = '';
    _selectedValue8 = '';
    _selectedValue9 = '';
    _selectedResolvedBy4 = null;
    issueTrackerController.playgroundDescriptionController.clear();
    issueTrackerController.multipleImage2.clear();
    issueTrackerController.dateController3.clear();
    issueTrackerController.dateController4.clear();
  }

  List<Map<String, String>> issuesList3 = [];
  void _addIssue3() {
    // Validate form fields
    bool isValid = true;

    // Validate Library part selection
    if (_selectedValue13 == null || _selectedValue13!.isEmpty) {
      setState(() {
        _radioFieldError13 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _radioFieldError13 = false;
      });
    }

    // Validate Issue Reported By selection
    if (_selectedValue11 == null || _selectedValue11!.isEmpty) {
      setState(() {
        _radioFieldError11 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _radioFieldError11 = false;
      });
    }

    if (_selectedValue12 == null || _selectedValue12!.isEmpty) {
      setState(() {
        _radioFieldError12 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _radioFieldError12 = false;
      });
    }

    if (_dateFieldError6 = _selectedValue12 == 'Closed' &&
        issueTrackerController.dateController6.text.isEmpty) {
      setState(() {
        _dateFieldError6 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _dateFieldError6 = false;
      });
    }

    // Validate image upload
    if (issueTrackerController.multipleImage3.isEmpty) {
      setState(() {
        validateRegister3 = true;
      });
      isValid = false;
    } else {
      setState(() {
        validateRegister3 = false;
      });
    }

    // Validate "Library Issue Reported On" date field
    if (issueTrackerController.dateController5.text.isEmpty) {
      setState(() {
        _dateFieldError5 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _dateFieldError5 = false;
      });
    }

    // If all validations pass, add the issue
    if (isValid && (_formKey.currentState!.validate())) {
      setState(() {
        List<String> imagePaths3 = issueTrackerController.multipleImage3
            .map((imageFile) => imageFile.path)
            .toList();

        issuesList3.add({
          'issue': _selectedValue12!,
          'part': _selectedValue13!,
          'description':
              issueTrackerController.digiLabDescriptionController.text,
          'reportedOn': issueTrackerController.dateController5.text,
          'resolvedOn': issueTrackerController.dateController6.text,
          'resolvedBy': _selectedResolvedBy5 ?? '',
          'reportedBy': _selectedValue11!,
          'status': _selectedValue12!,
          'images': imagePaths3.join(', '),
        });

        _resetForm3();
      });
    }
  }

  void _resetForm3() {
    _selectedValue10 = '';
    _selectedValue13 = '';
    _selectedValue11 = '';
    _selectedValue12 = '';
    _selectedResolvedBy5 = null;
    issueTrackerController.playgroundDescriptionController.clear();
    issueTrackerController.multipleImage3.clear();
    issueTrackerController.dateController5.clear();
    issueTrackerController.dateController6.clear();
  }

  List<Map<String, String>> issuesList4 = [];
  void _addIssue4() {
    // Validate form fields
    bool isValid = true;

    // Validate Library part selection
    if (_selectedValue15 == null || _selectedValue15!.isEmpty) {
      setState(() {
        _radioFieldError15 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _radioFieldError15 = false;
      });
    }

    // Validate Issue Reported By selection
    if (_selectedValue16 == null || _selectedValue16!.isEmpty) {
      setState(() {
        _radioFieldError16 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _radioFieldError16 = false;
      });
    }

    if (_selectedValue17 == null || _selectedValue17!.isEmpty) {
      setState(() {
        _radioFieldError17 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _radioFieldError17 = false;
      });
    }

    if (_dateFieldError8 = _selectedValue17 == 'Closed' &&
        issueTrackerController.dateController8.text.isEmpty) {
      setState(() {
        _dateFieldError8 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _dateFieldError8 = false;
      });
    }

    // Validate image upload
    if (issueTrackerController.multipleImage4.isEmpty) {
      setState(() {
        validateRegister4 = true;
      });
      isValid = false;
    } else {
      setState(() {
        validateRegister4 = false;
      });
    }

    // Validate "Library Issue Reported On" date field
    if (issueTrackerController.dateController7.text.isEmpty) {
      setState(() {
        _dateFieldError7 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _dateFieldError7 = false;
      });
    }
    print(issueTrackerController.imagePaths4);
    // If all validations pass, add the issue
    if (isValid && (_formKey.currentState!.validate())) {
      setState(() {
        List<String> imagePaths4 = issueTrackerController.multipleImage4
            .map((imageFile) => imageFile.path)
            .toList();

        issuesList4.add({
          'issue': _selectedValue14!,
          'part': _selectedValue15!,
          'description':
              issueTrackerController.classroomDescriptionController.text,
          'reportedOn': issueTrackerController.dateController7.text,
          'resolvedOn': issueTrackerController.dateController8.text,
          'reportedBy': _selectedValue16!,
          'status': _selectedValue17!,
          'images': imagePaths4.join(', '),
          'resolvedBy': _selectedResolvedBy ?? '',
        });

        _resetForm4();
      });
    }
  }

  void _resetForm4() {
    _selectedValue16 = '';
    _selectedValue15 = '';
    _selectedValue11 = '';
    _selectedValue14 = '';
    _selectedValue17 = '';
    _selectedResolvedBy = null;
    issueTrackerController.classroomDescriptionController.clear();
    issueTrackerController.multipleImage4.clear();
    issueTrackerController.dateController7.clear();
    issueTrackerController.dateController8.clear();
  }

  List<Map<String, String>> issuesList5 = [];

  void _addIssue5() {
    // Validate form fields
    bool isValid = true;

    // Validate Library part selection
    if (_selectedValue19 == null || _selectedValue19!.isEmpty) {
      setState(() {
        _radioFieldError19 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _radioFieldError19 = false;
      });
    }

    // Validate Issue Reported By selection
    if (_selectedValue20 == null || _selectedValue20!.isEmpty) {
      setState(() {
        _radioFieldError20 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _radioFieldError20 = false;
      });
    }

    // Validate Issue Status selection
    if (_selectedValue21 == null || _selectedValue21!.isEmpty) {
      setState(() {
        _radioFieldError21 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _radioFieldError21 = false;
      });
    }

    // Validate resolved date field
    if (_selectedValue21 == 'Closed' &&
        issueTrackerController.dateController10.text.isEmpty) {
      setState(() {
        _dateFieldError10 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _dateFieldError10 = false; // Corrected this from _dateFieldError8
      });
    }

    // Validate image upload
    if (issueTrackerController.multipleImage5.isEmpty) {
      setState(() {
        validateRegister5 = true;
      });
      isValid = false;
    } else {
      setState(() {
        validateRegister5 = false;
      });
    }

    // Validate "Library Issue Reported On" date field
    if (issueTrackerController.dateController9.text.isEmpty) {
      setState(() {
        _dateFieldError9 = true;
      });
      isValid = false;
    } else {
      setState(() {
        _dateFieldError9 = false;
      });
    }

    print(issueTrackerController.imagePaths5);

    // If all validations pass, add the issue
    if (isValid && (_formKey.currentState!.validate())) {
      setState(() {
        List<String> imagePaths5 = issueTrackerController.multipleImage5
            .map((imageFile) => imageFile.path)
            .toList();

        issuesList5.add({
          'issue': _selectedValue18!,
          'part': _selectedValue19!,
          'description': issueTrackerController.alexaDescriptionController.text,
          'reportedOn': issueTrackerController.dateController9.text,
          'resolvedOn': issueTrackerController.dateController10.text,
          'reportedBy': _selectedValue20!,
          'status': _selectedValue21!,
          'images': imagePaths5.join(', '),
          'resolvedBy': _selectedResolvedBy2 ?? '',
        });

        _resetForm5();
      });
    }
  }

  void _resetForm5() {
    _selectedValue20 = '';
    _selectedValue19 = '';
    _selectedValue18 = '';
    _selectedValue21 = '';
    _selectedResolvedBy2 = null;
    issueTrackerController.alexaDescriptionController.clear();
    issueTrackerController.multipleImage5.clear();
    issueTrackerController.dateController9.clear();
    issueTrackerController.dateController10.clear();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
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
          title: 'Issue Tracker Form',
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(children: [
                  GetBuilder<IssueTrackerController>(
                      init: IssueTrackerController(),
                      builder: (issueTrackerController) {
                        return Form(
                            key: _formKey,
                            child: GetBuilder<TourController>(
                                init: TourController(),
                                builder: (tourController) {
                                  tourController.fetchTourDetails();
                                  return Column(children: [
                                    // Start of basic details
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
                                        focusNode: issueTrackerController
                                            .tourIdFocusNode,
                                        options: tourController.getLocalTourList
                                            .map((e) => e.tourId)
                                            .toList(),
                                        selectedOption:
                                            issueTrackerController.tourValue,
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
                                            issueTrackerController
                                                .setSchool(null);
                                            issueTrackerController
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
                                          if (value == null || value.isEmpty) {
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
                                            issueTrackerController
                                                .setSchool(value);
                                          });
                                        },
                                        selectedItem:
                                            issueTrackerController.schoolValue,
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label: 'Is this UDISE code is correct?',
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
                                          padding: EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
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
                                          textController: issueTrackerController
                                              .correctUdiseCodeController,
                                          textInputType: TextInputType.number,
                                          labelText: 'Enter correct UDISE code',
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
                                              showLibrary = true;
                                            });
                                          }
                                        },
                                      ),

                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                    ], // End of basic details

                                    //Start of Library
                                    if (showLibrary) ...[
                                      LabelText(
                                        label: 'Library',
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            'Did you find any issues in the Library?',
                                        astrick: true,
                                      ),

                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
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
                                      // make it that user can also edit the tourId and school
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
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
                                          padding: EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),

                                      if (_selectedValue2 == 'Yes') ...[
                                        LabelText(
                                          label:
                                              '1) Which part of the Library is the issue related to?',
                                        ),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Library Register',
                                                  groupValue: _selectedValue3,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue3 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Library Register'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Library Racks',
                                                  groupValue: _selectedValue3,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue3 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Library Racks'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Books',
                                                  groupValue: _selectedValue3,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue3 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Books'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Carpet',
                                                  groupValue: _selectedValue3,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue3 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Carpet'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Time table not there',
                                                  groupValue: _selectedValue3,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue3 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                    'Time table not there'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value:
                                                      'Library in bad condition',
                                                  groupValue: _selectedValue3,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue3 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                    'Library in bad condition'),
                                              ],
                                            ),
                                          ],
                                        ),

                                        if (_radioFieldError3)
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
                                        LabelText(
                                          label:
                                              '2) Click an Image related to the selected issue',
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
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                                width: 2,
                                                color: _isImageUploaded == false
                                                    ? AppColors.primary
                                                    : AppColors.error),
                                          ),
                                          child: ListTile(
                                              title: _isImageUploaded == false
                                                  ? const Text(
                                                      'Click or Upload Image',
                                                    )
                                                  : const Text(
                                                      'Click or Upload Image',
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.error),
                                                    ),
                                              trailing: const Icon(
                                                  Icons.camera_alt,
                                                  color:
                                                      AppColors.onBackground),
                                              onTap: () {
                                                showModalBottomSheet(
                                                    backgroundColor:
                                                        AppColors.primary,
                                                    context: context,
                                                    builder: ((builder) =>
                                                        issueTrackerController
                                                            .bottomSheet(
                                                                context)));
                                              }),
                                        ),
                                        ErrorText(
                                          isVisible: validateRegister,
                                          message: 'Image Required',
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        issueTrackerController
                                                .multipleImage.isNotEmpty
                                            ? Container(
                                                width:
                                                    responsive.responsiveValue(
                                                        small: 600.0,
                                                        medium: 900.0,
                                                        large: 1400.0),
                                                height:
                                                    responsive.responsiveValue(
                                                        small: 170.0,
                                                        medium: 170.0,
                                                        large: 170.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child:
                                                    issueTrackerController
                                                            .multipleImage
                                                            .isEmpty
                                                        ? const Center(
                                                            child: Text(
                                                                'No images selected.'),
                                                          )
                                                        : ListView.builder(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                issueTrackerController
                                                                    .multipleImage
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return SizedBox(
                                                                height: 200,
                                                                width: 200,
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          CustomImagePreview.showImagePreview(
                                                                              issueTrackerController.multipleImage[index].path,
                                                                              context);
                                                                        },
                                                                        child: Image
                                                                            .file(
                                                                          File(issueTrackerController
                                                                              .multipleImage[index]
                                                                              .path),
                                                                          width:
                                                                              190,
                                                                          height:
                                                                              120,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          issueTrackerController
                                                                              .multipleImage
                                                                              .removeAt(index);
                                                                        });
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color: Colors
                                                                            .red,
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
                                        LabelText(
                                          label:
                                              '3) Write brief description related to the selected issue',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        CustomTextFormField(
                                          textController: issueTrackerController
                                              .libraryDescriptionController,
                                          maxlines: 3,
                                          labelText: 'Write Description',
                                          showCharacterCount: true,
                                        ),

                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),

                                        LabelText(
                                          label: '4) Issue Reported On',
                                          astrick: true,
                                        ),

                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        TextField(
                                          controller: issueTrackerController
                                              .dateController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            labelText: 'Select Date',
                                            errorText: _dateFieldError
                                                ? 'Date is required'
                                                : null,
                                            suffixIcon: IconButton(
                                              icon: const Icon(
                                                  Icons.calendar_today),
                                              onPressed: () {
                                                _selectDate(context);
                                              },
                                            ),
                                          ),
                                          onTap: () {
                                            _selectDate(context);
                                          },
                                        ),

                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),

                                        LabelText(
                                          label: '5) Issue Reported By',
                                          astrick: true,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Teacher',
                                                  groupValue: _selectedValue4,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue4 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Teacher'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'HeadMaster/Incharge',
                                                  groupValue: _selectedValue4,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue4 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                    'HeadMaster/Incharge'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'SMC/VEC',
                                                  groupValue: _selectedValue4,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue4 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('SMC/VEC'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: '17000ft Team Member',
                                                  groupValue: _selectedValue4,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue4 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                    '17000ft Team Member'),
                                              ],
                                            ),
                                          ],
                                        ),

                                        if (_radioFieldError4)
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
                                        LabelText(
                                          label: '6) Issue Status',
                                          astrick: true,
                                        ),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Open',
                                                  groupValue: _selectedValue5,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue5 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Open'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Closed',
                                                  groupValue: _selectedValue5,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue5 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Closed'),
                                              ],
                                            ),
                                          ],
                                        ),

                                        if (_radioFieldError5)
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

                                        if (_selectedValue5 == 'Closed') ...[
                                          LabelText(
                                            label: '7) Issue resolved On',
                                            astrick: true,
                                          ),
                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                          TextField(
                                            controller: issueTrackerController
                                                .dateController2,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              labelText: 'Select Date',
                                              errorText: _dateFieldError2
                                                  ? 'Date is required'
                                                  : null,
                                              suffixIcon: IconButton(
                                                icon: const Icon(
                                                    Icons.calendar_today),
                                                onPressed: () {
                                                  _selectDate2(context);
                                                },
                                              ),
                                            ),
                                            onTap: () {
                                              _selectDate2(context);
                                            },
                                          ),
                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                          LabelText(
                                            label: '8) Issue Resolved By',
                                            astrick: true,
                                          ),
                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                          DropdownButtonFormField<String>(
                                            value: _selectedResolvedBy3,
                                            items:
                                                _filteredStaffNames3.isNotEmpty
                                                    ? _filteredStaffNames3
                                                        .map((name) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: name,
                                                          child: Text(name),
                                                        );
                                                      }).toList()
                                                    : [],
                                            onChanged: (newValue) {
                                              setState(() {
                                                _selectedResolvedBy3 = newValue;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Select Staff Member',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                        ], // for select value 5
],
                                        SizedBox(height: 20),
                                        ElevatedButton(
                                          onPressed: _addIssue,
                                          child: Text('Add Issue'),
                                        ),


                                        Row(
                                          children: [
                                            CustomButton(
                                                title: 'Back',
                                                onPressedButton: () {
                                                  setState(() {
                                                    showBasicDetails = true;
                                                    showLibrary = false;
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
                                                  });

                                                  if (_formKey.currentState!
                                                          .validate() &&
                                                      !_radioFieldError2) {
                                                    setState(() {
                                                      showLibrary = false;
                                                      showPlayground = true;
                                                    });
                                                  }
                                                })
                                          ],
                                        ),

                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                    ], //End of Library
                                    // start of Playground
                                    if (showPlayground) ...[
                                      LabelText(
                                        label: 'Playground',
                                      ),

                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            'Did you find any issues in the Playground?',
                                        astrick: true,
                                      ),

                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
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
                                        padding:
                                            const EdgeInsets.only(right: 300),
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
                                          padding: EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),

                                      if (_selectedValue6 == 'Yes') ...[
                                        LabelText(
                                          label:
                                              '1) Which part of the Library is the issue related to?',
                                        ),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Swing',
                                                  groupValue: _selectedValue7,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue7 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Swing'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'See Saw',
                                                  groupValue: _selectedValue7,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue7 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('See Saw'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Slide',
                                                  groupValue: _selectedValue7,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue7 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Slide'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Net Scrambler',
                                                  groupValue: _selectedValue7,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue7 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Net Scrambler'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Monkey bar',
                                                  groupValue: _selectedValue7,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue7 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Monkey bar'),
                                              ],
                                            ),
                                          ],
                                        ),

                                        if (_radioFieldError7)
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

                                        LabelText(
                                          label:
                                              '1.1.2) Click an image related to the selected issue',
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
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                                width: 2,
                                                color:
                                                    _isImageUploaded2 == false
                                                        ? AppColors.primary
                                                        : AppColors.error),
                                          ),
                                          child: ListTile(
                                              title: _isImageUploaded2 == false
                                                  ? const Text(
                                                      'Click or Upload Image',
                                                    )
                                                  : const Text(
                                                      'Click or Upload Image',
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.error),
                                                    ),
                                              trailing: const Icon(
                                                  Icons.camera_alt,
                                                  color:
                                                      AppColors.onBackground),
                                              onTap: () {
                                                showModalBottomSheet(
                                                    backgroundColor:
                                                        AppColors.primary,
                                                    context: context,
                                                    builder: ((builder) =>
                                                        issueTrackerController
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
                                        issueTrackerController
                                                .multipleImage2.isNotEmpty
                                            ? Container(
                                                width:
                                                    responsive.responsiveValue(
                                                        small: 600.0,
                                                        medium: 900.0,
                                                        large: 1400.0),
                                                height:
                                                    responsive.responsiveValue(
                                                        small: 170.0,
                                                        medium: 170.0,
                                                        large: 170.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child:
                                                    issueTrackerController
                                                            .multipleImage2
                                                            .isEmpty
                                                        ? const Center(
                                                            child: Text(
                                                                'No images selected.'),
                                                          )
                                                        : ListView.builder(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                issueTrackerController
                                                                    .multipleImage2
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return SizedBox(
                                                                height: 200,
                                                                width: 200,
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          CustomImagePreview2.showImagePreview2(
                                                                              issueTrackerController.multipleImage2[index].path,
                                                                              context);
                                                                        },
                                                                        child: Image
                                                                            .file(
                                                                          File(issueTrackerController
                                                                              .multipleImage2[index]
                                                                              .path),
                                                                          width:
                                                                              190,
                                                                          height:
                                                                              120,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          issueTrackerController
                                                                              .multipleImage2
                                                                              .removeAt(index);
                                                                        });
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color: Colors
                                                                            .red,
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
                                        LabelText(
                                          label:
                                              '3) Write brief description related to the selected issue',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        CustomTextFormField(
                                          textController: issueTrackerController
                                              .playgroundDescriptionController,
                                          maxlines: 3,
                                          labelText: 'Write Description',
                                          showCharacterCount: true,
                                        ),

                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        LabelText(
                                          label: '4) Issue Reported On',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        TextField(
                                          controller: issueTrackerController
                                              .dateController3,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            labelText: 'Select Date',
                                            errorText: _dateFieldError3
                                                ? 'Date is required'
                                                : null,
                                            suffixIcon: IconButton(
                                              icon: const Icon(
                                                  Icons.calendar_today),
                                              onPressed: () {
                                                _selectDate3(context);
                                              },
                                            ),
                                          ),
                                          onTap: () {
                                            _selectDate3(context);
                                          },
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        LabelText(
                                          label: '5) Issue Reported By',
                                          astrick: true,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Teacher',
                                                  groupValue: _selectedValue8,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue8 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Teacher'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'HeadMaster/Incharge',
                                                  groupValue: _selectedValue8,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue8 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                    'HeadMaster/Incharge'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'SMC/VEC',
                                                  groupValue: _selectedValue8,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue8 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('SMC/VEC'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: '17000ft Team Member',
                                                  groupValue: _selectedValue8,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue8 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                    '17000ft Team Member'),
                                              ],
                                            ),
                                          ],
                                        ),

                                        if (_radioFieldError8)
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

                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        LabelText(
                                          label: '6) Issue Status',
                                          astrick: true,
                                        ),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Open',
                                                  groupValue: _selectedValue9,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue9 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Open'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Closed',
                                                  groupValue: _selectedValue9,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue9 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Closed'),
                                              ],
                                            ),
                                          ],
                                        ),

                                        if (_radioFieldError9)
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
                                        if (_selectedValue9 == 'Closed') ...[
                                          LabelText(
                                            label: '7) Issue resolved On',
                                            astrick: true,
                                          ),
                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                          TextField(
                                            controller: issueTrackerController
                                                .dateController4,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              labelText: 'Select Date',
                                              errorText: _dateFieldError4
                                                  ? 'Date is required'
                                                  : null,
                                              suffixIcon: IconButton(
                                                icon: const Icon(
                                                    Icons.calendar_today),
                                                onPressed: () {
                                                  _selectDate4(context);
                                                },
                                              ),
                                            ),
                                            onTap: () {
                                              _selectDate4(context);
                                            },
                                          ),
                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                          LabelText(
                                            label: '8) Issue Resolved By',
                                            astrick: true,
                                          ),
                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                          DropdownButtonFormField<String>(
                                            value: _selectedResolvedBy4,
                                            items:
                                                _filteredStaffNames4.isNotEmpty
                                                    ? _filteredStaffNames4
                                                        .map((name) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: name,
                                                          child: Text(name),
                                                        );
                                                      }).toList()
                                                    : [],
                                            onChanged: (newValue) {
                                              setState(() {
                                                _selectedResolvedBy4 = newValue;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Select Staff Member',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                        ], // end of selectvalue9

                                        ElevatedButton(
                                          onPressed: _addIssue2,
                                          child: Text('Add Issue'),
                                        ),
                                      ], // for selectvalue6
                                      if (_selectedValue6 != 'Yes') ...[
                                        Row(
                                          children: [
                                            CustomButton(
                                                title: 'Back',
                                                onPressedButton: () {
                                                  setState(() {
                                                    showLibrary = true;
                                                    showPlayground = false;
                                                  });
                                                }),
                                            const Spacer(),
                                            CustomButton(
                                                title: 'Next',
                                                onPressedButton: () {
                                                  setState(() {
                                                    _radioFieldError6 =
                                                        _selectedValue6 ==
                                                                null ||
                                                            _selectedValue6!
                                                                .isEmpty;
                                                  });

                                                  if (_formKey.currentState!
                                                          .validate() &&
                                                      !_radioFieldError6) {
                                                    setState(() {
                                                      showPlayground = false;
                                                      showDigiLab = true;
                                                    });
                                                  }
                                                })
                                          ],
                                        ),
                                      ],
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                    ], // end of playground
                                    // start of digiLab

                                    if (showDigiLab) ...[
                                      LabelText(
                                        label: 'DigiLab',
                                      ),

                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            'Did you find any issues in the Digilab?',
                                        astrick: true,
                                      ),

                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'Yes',
                                              groupValue: _selectedValue10,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue10 =
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
                                              groupValue: _selectedValue10,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue10 =
                                                      value as String?;
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                      ),
                                      if (_radioFieldError10)
                                        const Padding(
                                          padding: EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),

                                      if (_selectedValue10 == 'Yes') ...[
                                        LabelText(
                                          label:
                                              '1) Which part of the DigiLab is the issue related to?',
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Solar',
                                                  groupValue: _selectedValue13,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue13 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Solar'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Battery Box',
                                                  groupValue: _selectedValue13,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue13 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Battery Box'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Charging Dock',
                                                  groupValue: _selectedValue13,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue13 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Charging Dock'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Raspberry Pi',
                                                  groupValue: _selectedValue13,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue13 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Raspberry Pi'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'TV',
                                                  groupValue: _selectedValue13,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue13 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('TV'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Converter Box',
                                                  groupValue: _selectedValue13,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue13 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Converter Box'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Tablets',
                                                  groupValue: _selectedValue13,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue13 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Tablets'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'CG State',
                                                  groupValue: _selectedValue13,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue13 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('CG State'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value:
                                                      'DigiLab Room/Generic Issues',
                                                  groupValue: _selectedValue13,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue13 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                    'DigiLab Room/Generic Issues'),
                                              ],
                                            ),
                                          ],
                                        ),
                                        if (_radioFieldError13)
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

                                        LabelText(
                                          label:
                                              '1.1.2) Click an image related to the selected issue',
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
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                                width: 2,
                                                color:
                                                    _isImageUploaded3 == false
                                                        ? AppColors.primary
                                                        : AppColors.error),
                                          ),
                                          child: ListTile(
                                              title: _isImageUploaded3 == false
                                                  ? const Text(
                                                      'Click or Upload Image',
                                                    )
                                                  : const Text(
                                                      'Click or Upload Image',
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.error),
                                                    ),
                                              trailing: const Icon(
                                                  Icons.camera_alt,
                                                  color:
                                                      AppColors.onBackground),
                                              onTap: () {
                                                showModalBottomSheet(
                                                    backgroundColor:
                                                        AppColors.primary,
                                                    context: context,
                                                    builder: ((builder) =>
                                                        issueTrackerController
                                                            .bottomSheet3(
                                                                context)));
                                              }),
                                        ),
                                        ErrorText(
                                          isVisible: validateRegister3,
                                          message:
                                              'library Register Image Required',
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        issueTrackerController
                                                .multipleImage3.isNotEmpty
                                            ? Container(
                                                width:
                                                    responsive.responsiveValue(
                                                        small: 600.0,
                                                        medium: 900.0,
                                                        large: 1400.0),
                                                height:
                                                    responsive.responsiveValue(
                                                        small: 170.0,
                                                        medium: 170.0,
                                                        large: 170.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child:
                                                    issueTrackerController
                                                            .multipleImage3
                                                            .isEmpty
                                                        ? const Center(
                                                            child: Text(
                                                                'No images selected.'),
                                                          )
                                                        : ListView.builder(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                issueTrackerController
                                                                    .multipleImage3
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return SizedBox(
                                                                height: 200,
                                                                width: 200,
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          CustomImagePreview3.showImagePreview3(
                                                                              issueTrackerController.multipleImage3[index].path,
                                                                              context);
                                                                        },
                                                                        child: Image
                                                                            .file(
                                                                          File(issueTrackerController
                                                                              .multipleImage3[index]
                                                                              .path),
                                                                          width:
                                                                              190,
                                                                          height:
                                                                              120,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          issueTrackerController
                                                                              .multipleImage3
                                                                              .removeAt(index);
                                                                        });
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color: Colors
                                                                            .red,
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

                                        LabelText(
                                          label:
                                              '1.1.3) Write brief description related to the selected issue',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        CustomTextFormField(
                                          textController: issueTrackerController
                                              .digiLabDescriptionController,
                                          maxlines: 3,
                                          labelText: 'Write Description',
                                          showCharacterCount: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),

                                        LabelText(
                                          label: '4) Issue Reported On',
                                          astrick: true,
                                        ),

                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        TextField(
                                          controller: issueTrackerController
                                              .dateController5,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            labelText: 'Select Date',
                                            errorText: _dateFieldError5
                                                ? 'Date is required'
                                                : null,
                                            suffixIcon: IconButton(
                                              icon: const Icon(
                                                  Icons.calendar_today),
                                              onPressed: () {
                                                _selectDate5(context);
                                              },
                                            ),
                                          ),
                                          onTap: () {
                                            _selectDate5(context);
                                          },
                                        ),

                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        LabelText(
                                          label: '5) Issue Reported By',
                                          astrick: true,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Teacher',
                                                  groupValue: _selectedValue11,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue11 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Teacher'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'HeadMaster/Incharge',
                                                  groupValue: _selectedValue11,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue11 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                    'HeadMaster/Incharge'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'SMC/VEC',
                                                  groupValue: _selectedValue11,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue11 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('SMC/VEC'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: '17000ft Team Member',
                                                  groupValue: _selectedValue11,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue11 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                    '17000ft Team Member'),
                                              ],
                                            ),
                                          ],
                                        ),

                                        if (_radioFieldError11)
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

                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),

                                        LabelText(
                                          label: '6) Issue Status',
                                          astrick: true,
                                        ),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Open',
                                                  groupValue: _selectedValue12,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue12 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Open'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'Closed',
                                                  groupValue: _selectedValue12,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue12 =
                                                          value as String?;
                                                    });
                                                  },
                                                ),
                                                const Text('Closed'),
                                              ],
                                            ),
                                          ],
                                        ),

                                        if (_radioFieldError12)
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
                                        if (_selectedValue12 == 'Closed') ...[
                                          LabelText(
                                            label: '7) Issue resolved On',
                                            astrick: true,
                                          ),
                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                          TextField(
                                            controller: issueTrackerController
                                                .dateController6,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              labelText: 'Select Date',
                                              errorText: _dateFieldError6
                                                  ? 'Date is required'
                                                  : null,
                                              suffixIcon: IconButton(
                                                icon: const Icon(
                                                    Icons.calendar_today),
                                                onPressed: () {
                                                  _selectDate6(context);
                                                },
                                              ),
                                            ),
                                            onTap: () {
                                              _selectDate6(context);
                                            },
                                          ),
                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                          LabelText(
                                            label: '8) Issue Resolved By',
                                            astrick: true,
                                          ),
                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                          DropdownButtonFormField<String>(
                                            value: _selectedResolvedBy5,
                                            items:
                                                _filteredStaffNames5.isNotEmpty
                                                    ? _filteredStaffNames5
                                                        .map((name) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: name,
                                                          child: Text(name),
                                                        );
                                                      }).toList()
                                                    : [],
                                            onChanged: (newValue) {
                                              setState(() {
                                                _selectedResolvedBy5 = newValue;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Select Staff Member',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                        ], // for select value 12

                                        SizedBox(height: 20),
                                        ElevatedButton(
                                          onPressed: _addIssue3,
                                          child: Text('Add Issue'),
                                        ),
                                      ], //for selectvalue10

                                      if (_selectedValue10 != 'Yes') ...[
                                        Row(
                                          children: [
                                            CustomButton(
                                                title: 'Back',
                                                onPressedButton: () {
                                                  setState(() {
                                                    showPlayground = true;
                                                    showDigiLab = false;
                                                  });
                                                }),
                                            const Spacer(),
                                            CustomButton(
                                                title: 'Next',
                                                onPressedButton: () {
                                                  setState(() {
                                                    _radioFieldError10 =
                                                        _selectedValue10 ==
                                                                null ||
                                                            _selectedValue10!
                                                                .isEmpty;
                                                  });

                                                  if (_formKey.currentState!
                                                          .validate() &&
                                                      !_radioFieldError10) {
                                                    setState(() {
                                                      showDigiLab = false;
                                                      showClassroom = true;
                                                    });
                                                  }
                                                })
                                          ],
                                        ),
                                      ],
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                    ], // end of digiLab

                                    // start of clasroom
                                    if (showClassroom) ...[
                                      LabelText(
                                        label: 'Classroom',
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),

                                      if (controller.office == 'Sikkim')
                                        const Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Center(
                                            // Center the text in the middle of the available space
                                            child: Text(
                                              'This program is not for Sikkim.',
                                              style: TextStyle(
                                                color: Colors
                                                    .black, // Set the text color to black
                                                fontSize: 28,
                                                fontWeight: FontWeight
                                                    .bold, // Make the text bold for clarity
                                              ),
                                              textAlign: TextAlign
                                                  .center, // Center align the text
                                            ),
                                          ),
                                        )
                                      else ...[
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        LabelText(
                                          label:
                                              'Did you find any issues in the Classroom?',
                                          astrick: true,
                                        ),

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 300),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 'Yes',
                                                groupValue: _selectedValue14,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedValue14 =
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
                                                groupValue: _selectedValue14,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedValue14 =
                                                        value as String?;
                                                  });
                                                },
                                              ),
                                              const Text('No'),
                                            ],
                                          ),
                                        ),
                                        if (_radioFieldError14)
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

                                        if (_selectedValue14 == 'Yes') ...[
                                          LabelText(
                                            label:
                                                '1) Which part of the classroom Furniture is the issue related to?',
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Radio(
                                                    value:
                                                        'Round bean for Pre primary',
                                                    groupValue:
                                                        _selectedValue15,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue15 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text(
                                                      'Round bean for Pre primary'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value:
                                                        'Small Plastic Chair',
                                                    groupValue:
                                                        _selectedValue15,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue15 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text(
                                                      'Small Plastic Chair'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value:
                                                        'Medium Plastic Chair',
                                                    groupValue:
                                                        _selectedValue15,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue15 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text(
                                                      'Medium Plastic Chair'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'Metal Desk-Small',
                                                    groupValue:
                                                        _selectedValue15,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue15 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text(
                                                      'Metal Desk-Small'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'Metal Chair-Small',
                                                    groupValue:
                                                        _selectedValue15,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue15 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text(
                                                      'Metal Chair-Small'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'Metal Desk-Large',
                                                    groupValue:
                                                        _selectedValue15,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue15 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text(
                                                      'Metal Desk-Large'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'Metal Chair-Large',
                                                    groupValue:
                                                        _selectedValue15,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue15 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text(
                                                      'Metal Chair-Large'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'Carpet',
                                                    groupValue:
                                                        _selectedValue15,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue15 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Carpet'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'Other',
                                                    groupValue:
                                                        _selectedValue15,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue15 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Other'),
                                                ],
                                              ),
                                            ],
                                          ),
                                          if (_radioFieldError15)
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

                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),

                                          LabelText(
                                            label:
                                                '1.1.2) Click an image related to the selected issue',
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
                                                  BorderRadius.circular(10.0),
                                              border: Border.all(
                                                  width: 2,
                                                  color:
                                                      _isImageUploaded4 == false
                                                          ? AppColors.primary
                                                          : AppColors.error),
                                            ),
                                            child: ListTile(
                                                title:
                                                    _isImageUploaded4 == false
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
                                                    color:
                                                        AppColors.onBackground),
                                                onTap: () {
                                                  showModalBottomSheet(
                                                      backgroundColor:
                                                          AppColors.primary,
                                                      context: context,
                                                      builder: ((builder) =>
                                                          issueTrackerController
                                                              .bottomSheet4(
                                                                  context)));
                                                }),
                                          ),
                                          ErrorText(
                                            isVisible: validateRegister4,
                                            message:
                                                'library Register Image Required',
                                          ),
                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                          issueTrackerController
                                                  .multipleImage4.isNotEmpty
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
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child:
                                                      issueTrackerController
                                                              .multipleImage4
                                                              .isEmpty
                                                          ? const Center(
                                                              child: Text(
                                                                  'No images selected.'),
                                                            )
                                                          : ListView.builder(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              itemCount:
                                                                  issueTrackerController
                                                                      .multipleImage4
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return SizedBox(
                                                                  height: 200,
                                                                  width: 200,
                                                                  child: Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            CustomImagePreview4.showImagePreview4(issueTrackerController.multipleImage4[index].path,
                                                                                context);
                                                                          },
                                                                          child:
                                                                              Image.file(
                                                                            File(issueTrackerController.multipleImage4[index].path),
                                                                            width:
                                                                                190,
                                                                            height:
                                                                                120,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            issueTrackerController.multipleImage4.removeAt(index);
                                                                          });
                                                                        },
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Colors.red,
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

                                          LabelText(
                                            label:
                                                '1.1.3) Describe the issue in detail ? Also mention quantities of the damaged part?',
                                            astrick: true,
                                          ),
                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                          CustomTextFormField(
                                            textController: issueTrackerController
                                                .classroomDescriptionController,
                                            maxlines: 3,
                                            labelText: 'Write Description',
                                            showCharacterCount: true,
                                          ),

                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),

                                          LabelText(
                                            label: '4) Issue Reported On',
                                            astrick: true,
                                          ),

                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                          TextField(
                                            controller: issueTrackerController
                                                .dateController7,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              labelText: 'Select Date',
                                              errorText: _dateFieldError7
                                                  ? 'Date is required'
                                                  : null,
                                              suffixIcon: IconButton(
                                                icon: const Icon(
                                                    Icons.calendar_today),
                                                onPressed: () {
                                                  _selectDate7(context);
                                                },
                                              ),
                                            ),
                                            onTap: () {
                                              _selectDate7(context);
                                            },
                                          ),

                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),

                                          LabelText(
                                            label: '5) Issue Reported By',
                                            astrick: true,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'Teacher',
                                                    groupValue:
                                                        _selectedValue16,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue16 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Teacher'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value:
                                                        'HeadMaster/Incharge',
                                                    groupValue:
                                                        _selectedValue16,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue16 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text(
                                                      'HeadMaster/Incharge'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'SMC/VEC',
                                                    groupValue:
                                                        _selectedValue16,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue16 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('SMC/VEC'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value:
                                                        '17000ft Team Member',
                                                    groupValue:
                                                        _selectedValue16,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue16 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text(
                                                      '17000ft Team Member'),
                                                ],
                                              ),
                                            ],
                                          ),

                                          if (_radioFieldError16)
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

                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                          LabelText(
                                            label: '6) Issue Status',
                                            astrick: true,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'Open',
                                                    groupValue:
                                                        _selectedValue17,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue17 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Open'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'Closed',
                                                    groupValue:
                                                        _selectedValue17,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue17 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Closed'),
                                                ],
                                              ),
                                            ],
                                          ),

                                          if (_radioFieldError17)
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
                                          if (_selectedValue17 == 'Closed') ...[
                                            LabelText(
                                              label: '7) Issue resolved On',
                                              astrick: true,
                                            ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            TextField(
                                              controller: issueTrackerController
                                                  .dateController8,
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                labelText: 'Select Date',
                                                errorText: _dateFieldError8
                                                    ? 'Date is required'
                                                    : null,
                                                suffixIcon: IconButton(
                                                  icon: const Icon(
                                                      Icons.calendar_today),
                                                  onPressed: () {
                                                    _selectDate8(context);
                                                  },
                                                ),
                                              ),
                                              onTap: () {
                                                _selectDate8(context);
                                              },
                                            ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            LabelText(
                                              label: '8) Issue Resolved By',
                                              astrick: true,
                                            ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            DropdownButtonFormField<String>(
                                              value: _selectedResolvedBy,
                                              items:
                                                  _filteredStaffNames.isNotEmpty
                                                      ? _filteredStaffNames
                                                          .map((name) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: name,
                                                            child: Text(name),
                                                          );
                                                        }).toList()
                                                      : [],
                                              onChanged: (newValue) {
                                                setState(() {
                                                  _selectedResolvedBy =
                                                      newValue;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Select Staff Member',
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                          ], // for select value 17

                                          ElevatedButton(
                                            onPressed: _addIssue4,
                                            child: Text('Add Issue'),
                                          ),
                                        ]
                                      ],
                                      if (_selectedValue14 != 'Yes') ...[
                                        Row(
                                          children: [
                                            CustomButton(
                                                title: 'Back',
                                                onPressedButton: () {
                                                  setState(() {
                                                    showDigiLab = true;
                                                    showClassroom = false;
                                                  });
                                                }),
                                            const Spacer(),
                                            CustomButton(
                                                title: 'Next',
                                                onPressedButton: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      showClassroom = false;
                                                      showAlexa = true;
                                                    });
                                                  }
                                                })
                                          ],
                                        ),
                                      ],
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ), // selectvalue14
                                    ], //end of classroom

                                    // start of Alexa project
                                    if (showAlexa) ...[
                                      LabelText(
                                        label: 'Alexa project',
                                      ),

                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      if (controller.office == 'Sikkim')
                                        const Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Center(
                                            // Center the text in the middle of the available space
                                            child: Text(
                                              'This program is not for Sikkim.',
                                              style: TextStyle(
                                                color: Colors
                                                    .black, // Set the text color to black
                                                fontSize: 28,
                                                fontWeight: FontWeight
                                                    .bold, // Make the text bold for clarity
                                              ),
                                              textAlign: TextAlign
                                                  .center, // Center align the text
                                            ),
                                          ),
                                        )
                                      else ...[
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        LabelText(
                                          label:
                                              'Did you find any issues in the Alexa Project?',
                                          astrick: true,
                                        ),

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 300),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 'Yes',
                                                groupValue: _selectedValue18,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedValue18 =
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
                                                groupValue: _selectedValue18,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedValue18 =
                                                        value as String?;
                                                  });
                                                },
                                              ),
                                              const Text('No'),
                                            ],
                                          ),
                                        ),
                                        if (_radioFieldError18)
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

                                        if (_selectedValue18 == 'Yes') ...[
                                          LabelText(
                                            label:
                                                '1) Which part of the classroom Furniture is the issue related to?',
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'Solar Panel',
                                                    groupValue:
                                                        _selectedValue19,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue19 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Solar Panel'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'Charging Station',
                                                    groupValue:
                                                        _selectedValue19,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue19 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text(
                                                      'Charging Station'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'Router',
                                                    groupValue:
                                                        _selectedValue19,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue19 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Router'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'Dot Device',
                                                    groupValue:
                                                        _selectedValue19,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue19 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Dot Device'),
                                                ],
                                              ),
                                            ],
                                          ),
                                          if (_radioFieldError19)
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

                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),

                                          LabelText(
                                            label:
                                                '1.1.2) Click an image related to the selected issue',
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
                                                  BorderRadius.circular(10.0),
                                              border: Border.all(
                                                  width: 2,
                                                  color:
                                                      _isImageUploaded5 == false
                                                          ? AppColors.primary
                                                          : AppColors.error),
                                            ),
                                            child: ListTile(
                                                title:
                                                    _isImageUploaded5 == false
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
                                                    color:
                                                        AppColors.onBackground),
                                                onTap: () {
                                                  showModalBottomSheet(
                                                      backgroundColor:
                                                          AppColors.primary,
                                                      context: context,
                                                      builder: ((builder) =>
                                                          issueTrackerController
                                                              .bottomSheet5(
                                                                  context)));
                                                }),
                                          ),
                                          ErrorText(
                                            isVisible: validateRegister5,
                                            message:
                                                'library Register Image Required',
                                          ),
                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                          issueTrackerController
                                                  .multipleImage5.isNotEmpty
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
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child:
                                                      issueTrackerController
                                                              .multipleImage5
                                                              .isEmpty
                                                          ? const Center(
                                                              child: Text(
                                                                  'No images selected.'),
                                                            )
                                                          : ListView.builder(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              itemCount:
                                                                  issueTrackerController
                                                                      .multipleImage5
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return SizedBox(
                                                                  height: 200,
                                                                  width: 200,
                                                                  child: Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            CustomImagePreview5.showImagePreview5(issueTrackerController.multipleImage5[index].path,
                                                                                context);
                                                                          },
                                                                          child:
                                                                              Image.file(
                                                                            File(issueTrackerController.multipleImage5[index].path),
                                                                            width:
                                                                                190,
                                                                            height:
                                                                                120,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            issueTrackerController.multipleImage5.removeAt(index);
                                                                          });
                                                                        },
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Colors.red,
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

                                          LabelText(
                                            label:
                                                '1.1.3) Write brief description related to the selected issue',
                                            astrick: true,
                                          ),
                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                          CustomTextFormField(
                                            textController:
                                                issueTrackerController
                                                    .alexaDescriptionController,
                                            maxlines: 3,
                                            labelText: 'Write Description',
                                            showCharacterCount: true,
                                          ),

                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),

                                          LabelText(
                                            label: '4) Issue Reported On',
                                            astrick: true,
                                          ),

                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                          TextField(
                                            controller: issueTrackerController
                                                .dateController9,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              labelText: 'Select Date',
                                              errorText: _dateFieldError9
                                                  ? 'Date is required'
                                                  : null,
                                              suffixIcon: IconButton(
                                                icon: const Icon(
                                                    Icons.calendar_today),
                                                onPressed: () {
                                                  _selectDate9(context);
                                                },
                                              ),
                                            ),
                                            onTap: () {
                                              _selectDate9(context);
                                            },
                                          ),

                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),

                                          LabelText(
                                            label: '5) Issue Reported By',
                                            astrick: true,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'Teacher',
                                                    groupValue:
                                                        _selectedValue20,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue20 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Teacher'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value:
                                                        'HeadMaster/Incharge',
                                                    groupValue:
                                                        _selectedValue20,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue20 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text(
                                                      'HeadMaster/Incharge'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'SMC/VEC',
                                                    groupValue:
                                                        _selectedValue20,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue20 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('SMC/VEC'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value:
                                                        '17000ft Team Member',
                                                    groupValue:
                                                        _selectedValue20,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue20 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text(
                                                      '17000ft Team Member'),
                                                ],
                                              ),
                                            ],
                                          ),

                                          if (_radioFieldError20)
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

                                          CustomSizedBox(
                                            value: 20,
                                            side: 'height',
                                          ),
                                          LabelText(
                                            label: '6) Issue Status',
                                            astrick: true,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'Open',
                                                    groupValue:
                                                        _selectedValue21,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue21 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Open'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'Closed',
                                                    groupValue:
                                                        _selectedValue21,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedValue21 =
                                                            value as String?;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Closed'),
                                                ],
                                              ),
                                            ],
                                          ),

                                          if (_radioFieldError21)
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
                                          if (_selectedValue21 == 'Closed') ...[
                                            LabelText(
                                              label: '7) Issue resolved On',
                                              astrick: true,
                                            ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            TextField(
                                              controller: issueTrackerController
                                                  .dateController10,
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                labelText: 'Select Date',
                                                errorText: _dateFieldError10
                                                    ? 'Date is required'
                                                    : null,
                                                suffixIcon: IconButton(
                                                  icon: const Icon(
                                                      Icons.calendar_today),
                                                  onPressed: () {
                                                    _selectDate10(context);
                                                  },
                                                ),
                                              ),
                                              onTap: () {
                                                _selectDate10(context);
                                              },
                                            ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            LabelText(
                                              label: '8) Issue Resolved By',
                                              astrick: true,
                                            ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                            DropdownButtonFormField<String>(
                                              value: _selectedResolvedBy2,
                                              items: _filteredStaffNames2
                                                      .isNotEmpty
                                                  ? _filteredStaffNames2
                                                      .map((name) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: name,
                                                        child: Text(name),
                                                      );
                                                    }).toList()
                                                  : [],
                                              onChanged: (newValue) {
                                                setState(() {
                                                  _selectedResolvedBy2 =
                                                      newValue;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Select Staff Member',
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            CustomSizedBox(
                                              value: 20,
                                              side: 'height',
                                            ),
                                          ], // for select value 17

                                          ElevatedButton(
                                            onPressed: _addIssue5,
                                            child: Text('Add Issue'),
                                          ),
                                        ]
                                      ],
                                      if (_selectedValue18 != 'Yes') ...[
                                        Row(
                                          children: [
                                            CustomButton(
                                                title: 'Back',
                                                onPressedButton: () {
                                                  setState(() {
                                                    showClassroom = true;
                                                    showAlexa = false;
                                                  });
                                                }),
                                            const Spacer(),
                                            CustomButton(
                                              title: 'Submit',
                                              onPressedButton: () async {
                                                if (_formKey.currentState!.validate()) {
                                                  DateTime now = DateTime.now();
                                                  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                                                  // Call the _addIssue method to validate and get issue data
                                                  _addIssue();



                                                  // Check if all necessary fields are populated before creating the objects
                                                  if (_selectedValue2 != null && _selectedValue3 != null) {
                                                    // Create IssueTrackerRecords object
                                                    IssueTrackerRecords enrolmentCollectionObj = IssueTrackerRecords(
                                                      office: controller.office ?? '',
                                                      tourId: issueTrackerController.tourValue ?? '',
                                                      school: issueTrackerController.schoolValue ?? '',
                                                      udiseCode: _selectedValue!,
                                                      correctUdise: issueTrackerController.correctUdiseCodeController.text,
                                                      createdAt: formattedDate.toString(),
                                                      uniqueId: uniqueId, // Add unique ID here
                                                    );

                                                    // // Fetch the last added LibIssue from lib_issuesList
                                                    // // Fetch the last added LibIssue from lib_issuesList
                                                    // Map<String, String> lastLibIssueData = lib_issuesList.lastWhere(
                                                    //       (issue) => issue['unique_id'] == uniqueId,
                                                    //   orElse: () => {}, // Return an empty map if no match is found
                                                    // );

// Create LibIssue object only if the map is not empty
//                                                     LibIssue? libIssueObj;
//                                                     if (lastLibIssueData.isNotEmpty) {
//                                                       libIssueObj = LibIssue(
//                                                         libIssue: lastLibIssueData['lib_issue']!,
//                                                         libIssueValue: lastLibIssueData['lib_issue_value']!,
//                                                         libDesc: lastLibIssueData['lib_desc']!,
//                                                         uniqueId: lastLibIssueData['unique_id']!,
//                                                         libIssueImg: lastLibIssueData['lib_issue_img']!,
//                                                         reportedOn: lastLibIssueData['reported_on']!,
//                                                         resolvedOn: lastLibIssueData['resolved_on']!,
//                                                         reportedBy: lastLibIssueData['reported_by']!,
//                                                         resolvedBy: lastLibIssueData['resolved_by']!,
//                                                         issueStatus: lastLibIssueData['issue_status']!,
//                                                       );
//                                                     }

                                                    // // Create PlayIssue object
                                                    // PlayIssue playIssueObj = PlayIssue(
                                                    //   playIssue: _selectedValue6!,
                                                    //   playIssueValue: _selectedValue7!,
                                                    //   playDesc: issueTrackerController.playgroundDescriptionController.text,
                                                    //   uniqueId: uniqueId, // Add the same unique ID here
                                                    //   playIssueImg: issueTrackerController.multipleImage2
                                                    //       .map((imageFile) => imageFile.path)
                                                    //       .join(', '), // Combine the image paths into a string
                                                    //   reportedOn: issueTrackerController.dateController3.text,
                                                    //   resolvedOn: issueTrackerController.dateController4.text,
                                                    //   reportedBy: _selectedValue8!,
                                                    //   resolvedBy: _selectedResolvedBy4 ?? '',
                                                    //   issueStatus: _selectedValue9!,
                                                    // );

                                                    // Create LibIssue object(s) from lib_issuesList
                                                    List<LibIssue> libIssues = lib_issuesList.map((issueData) {
                                                      return LibIssue(
                                                        libIssue: issueData['lib_issue'],
                                                        libIssueValue: issueData['lib_issue_value'],
                                                        libDesc: issueData['lib_desc'],
                                                        reportedOn: issueData['reported_on'],
                                                        resolvedOn: issueData['resolved_on'],
                                                        reportedBy: issueData['reported_by'],
                                                        resolvedBy: issueData['resolved_by'],
                                                        issueStatus: issueData['issue_status'],
                                                        libIssueImg: issueData['lib_issue_img'],
                                                        uniqueId: issueData['unique_id'],
                                                      );
                                                    }).toList();


                                                    // Save data to local database
                                                    int result = await LocalDbController().addData(
                                                      issueTrackerRecords: enrolmentCollectionObj,
                                                      libIssues: libIssues, // Pass the libIssues list to the database
                                                      // playIssue: playIssueObj, // Pass PlayIssue object
                                                    );

                                                    if (result > 0) {
                                                      issueTrackerController.clearFields();
                                                      setState(() {
                                                        jsonData = {};
                                                      });

                                                      customSnackbar(
                                                        'Submitted Successfully',
                                                        'submitted',
                                                        AppColors.primary,
                                                        AppColors.onPrimary,
                                                        Icons.verified,
                                                      );
                                                      // Navigate to HomeScreen
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => HomeScreen()),
                                                      );
                                                    } else {
                                                      customSnackbar(
                                                        'Error',
                                                        'Something went wrong',
                                                        AppColors.primary,
                                                        AppColors.onPrimary,
                                                        Icons.error,
                                                      );
                                                    }
                                                  } else {
                                                    customSnackbar(
                                                      'Error',
                                                      'Please fill out all required fields',
                                                      AppColors.primary,
                                                      AppColors.onPrimary,
                                                      Icons.error,
                                                    );
                                                  }
                                                }
                                              },
                                            )

                                          ],
                                        ),
                                      ],
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ), // selectvalue14
                                    ], //end of alexa
                                  ]);
                                }));
                      })
                ]))),
        floatingActionButton: showLibrary
            ? IssuesFloatingButton(
                issuesList: lib_issuesList,
                onDelete: (index) {
                  setState(() {
                    lib_issuesList.removeAt(index);
                  });
                },
              )
            : showPlayground
                ? IssuesFloatingButton2(
                    issuesList2: issuesList2,
                    onDelete: (index) {
                      setState(() {
                        issuesList2.removeAt(index);
                      });
                    },
                  )
                : showDigiLab
                    ? IssuesFloatingButton3(
                        issuesList3: issuesList3,
                        onDelete: (index) {
                          setState(() {
                            issuesList3.removeAt(index);
                          });
                        },
                      )
                    : showClassroom
                        ? IssuesFloatingButton4(
                            issuesList4: issuesList4,
                            onDelete: (index) {
                              setState(() {
                                issuesList4.removeAt(index);
                              });
                            },
                          )
                        : showAlexa
                            ? IssuesFloatingButton5(
                                issuesList5: issuesList5,
                                onDelete: (index) {
                                  setState(() {
                                    issuesList5.removeAt(index);
                                  });
                                },
                              )
                            : null,
      ),
    );
  }
}
class IssuesFloatingButton extends StatelessWidget {
  final List<Map<String, dynamic>> issuesList;
  final Function(int) onDelete; // Callback to handle delete action

  IssuesFloatingButton({required this.issuesList, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              children: [
                AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Library Issue List',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Text(
                        'Total Issues: ${issuesList.length}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  backgroundColor: AppColors.primary,
                  elevation: 0, // Optional: remove shadow
                  automaticallyImplyLeading:
                  false, // Prevent the default back button
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: issuesList.length,
                    itemBuilder: (context, index) {
                      final issue = issuesList[index];
                      return ListTile(
                        title: Text(
                          '1) Images: ${issue['lib_issue_img']?.split(",")?.join(", ") ?? "No images"}\n'
                              '2) Description: ${issue['lib_desc'] ?? "No description"}\n'
                              '3) Reported by: ${issue['reported_by'] ?? "Unknown"}\n'
                              '4) Resolved By: ${issue['resolved_by'] ?? "Not resolved"}\n'
                              '5) Reported On: ${issue['reported_on'] ?? "No date"}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            Navigator.pop(context); // Close bottom sheet
                            onDelete(index); // Notify parent to remove item
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Icon(Icons.list),
      backgroundColor: AppColors.primary,
    );
  }
}


class IssuesFloatingButton2 extends StatelessWidget {
  final List<Map<String, dynamic>> issuesList2;
  final Function(int) onDelete; // Callback to handle delete action

  IssuesFloatingButton2({required this.issuesList2, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              children: [
                AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Playground Issue List',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Text(
                        'Total Issues: ${issuesList2.length}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  backgroundColor: AppColors.primary,
                  elevation: 0, // Optional: remove shadow
                  automaticallyImplyLeading:
                      false, // Prevent the default back button
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: issuesList2.length,
                    itemBuilder: (context, index) {
                      final issue = issuesList2[index];
                      return ListTile(
                        title: Text(
                          '1) Images: ${issue['play_issue_img'].split(',')}\n'
                          '2) Description: ${issue['play_desc']}\n'
                          '3) Reported by: ${issue['reported_by']}\n'
                          '4) Resolved by: ${issue['resolved_by']}\n'
                          '5) Reported On: ${issue['reported_on']}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            Navigator.pop(context); // Close bottom sheet
                            onDelete(index); // Notify parent to remove item
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Icon(Icons.list),
      backgroundColor: AppColors.primary,
    );
  }
}

class IssuesFloatingButton3 extends StatelessWidget {
  final List<Map<String, dynamic>> issuesList3;
  final Function(int) onDelete; // Callback to handle delete action

  IssuesFloatingButton3({required this.issuesList3, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              children: [
                AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'DigiLab Issue List',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Text(
                        'Total Issues: ${issuesList3.length}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  backgroundColor: AppColors.primary,
                  elevation: 0, // Optional: remove shadow
                  automaticallyImplyLeading:
                      false, // Prevent the default back button
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: issuesList3.length,
                    itemBuilder: (context, index) {
                      final issue = issuesList3[index];
                      return ListTile(
                        title: Text(
                          '1) Images: ${issue['images'].split(',')}\n'
                          '2) Description: ${issue['description']}\n'
                          '3) Reported by: ${issue['reportedBy']}\n'
                          '3) Resolved by: ${issue['resolvedBy']}\n'
                          '4) Reported On: ${issue['reportedOn']}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            Navigator.pop(context); // Close bottom sheet
                            onDelete(index); // Notify parent to remove item
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Icon(Icons.list),
      backgroundColor: AppColors.primary,
    );
  }
}

class IssuesFloatingButton4 extends StatelessWidget {
  final List<Map<String, dynamic>> issuesList4;
  final Function(int) onDelete; // Callback to handle delete action

  IssuesFloatingButton4({required this.issuesList4, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              children: [
                AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Classroom Issue List',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Text(
                        'Total Issues: ${issuesList4.length}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  backgroundColor: AppColors.primary,
                  elevation: 0, // Optional: remove shadow
                  automaticallyImplyLeading:
                      false, // Prevent the default back button
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: issuesList4.length,
                    itemBuilder: (context, index) {
                      final issue = issuesList4[index];
                      return ListTile(
                        title: Text(
                          '1) Images: ${issue['images'].split(',')}\n'
                          '2) Description: ${issue['description']}\n'
                          '3) Reported by: ${issue['reportedBy']}\n'
                          '4) Resoved By: ${issue['resolvedBy']}\n'
                          '5) Reported On: ${issue['reportedOn']}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            Navigator.pop(context); // Close bottom sheet
                            onDelete(index); // Notify parent to remove item
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Icon(Icons.list),
      backgroundColor: AppColors.primary,
    );
  }
}

class IssuesFloatingButton5 extends StatelessWidget {
  final List<Map<String, dynamic>> issuesList5;
  final Function(int) onDelete; // Callback to handle delete action

  IssuesFloatingButton5({required this.issuesList5, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              children: [
                AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Alexa Issue List',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Text(
                        'Total Issues: ${issuesList5.length}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  backgroundColor: AppColors.primary,
                  elevation: 0, // Optional: remove shadow
                  automaticallyImplyLeading:
                      false, // Prevent the default back button
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: issuesList5.length,
                    itemBuilder: (context, index) {
                      final issue = issuesList5[index];
                      return ListTile(
                        title: Text(
                          '1) Images: ${issue['images'].split(',')}\n'
                          '2) Description: ${issue['description']}\n'
                          '3) Reported by: ${issue['reportedBy']}\n'
                          '4) Resoved By: ${issue['resolvedBy']}\n'
                          '5) Reported On: ${issue['reportedOn']}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            Navigator.pop(context); // Close bottom sheet
                            onDelete(index); // Notify parent to remove item
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Icon(Icons.list),
      backgroundColor: AppColors.primary,
    );
  }
}




class UniqueIdGenerator {
  static String generate(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }
}
