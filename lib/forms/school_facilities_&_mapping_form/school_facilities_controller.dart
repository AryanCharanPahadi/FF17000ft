import 'dart:io';

import 'package:app17000ft/constants/color_const.dart';

import 'package:app17000ft/forms/school_facilities_&_mapping_form/school_facilities_modals.dart';
import 'package:app17000ft/helper/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../base_client/baseClient_controller.dart';


class SchoolFacilitiesController extends GetxController with BaseController {
  var counterText = ''.obs;
  String? _tourValue;
  String? get tourValue => _tourValue;

  String? _schoolValue;
  String? get schoolValue => _schoolValue;

  bool isLoading = false;
  final TextEditingController noOfEnrolledStudentAsOnDateController = TextEditingController();
  final TextEditingController noOfFunctionalClassroomController = TextEditingController();
  final TextEditingController nameOfLibrarianController = TextEditingController();
  final TextEditingController correctUdiseCodeController = TextEditingController();



  final FocusNode _tourIdFocusNode = FocusNode();
  FocusNode get tourIdFocusNode => _tourIdFocusNode;

  final FocusNode _schoolFocusNode = FocusNode();
  FocusNode get schoolFocusNode => _schoolFocusNode;

  List<SchoolFacilitiesRecords> _schoolFacilitiesList = [];
  List<SchoolFacilitiesRecords> get schoolFacilitiesList => _schoolFacilitiesList;

  final List<XFile> _multipleImage = [];
  List<XFile> get multipleImage => _multipleImage;

  List<String> _imagePaths = [];
  List<String> get imagePaths => _imagePaths;

  Future<String> takePhoto(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    List<XFile> selectedImages = [];

    _imagePaths = [];
    if (source == ImageSource.gallery) {
      selectedImages = await picker.pickMultiImage();
      _multipleImage.addAll(selectedImages);
      for (var image in _multipleImage) {
        _imagePaths.add(image.path);
      }
    } else if (source == ImageSource.camera) {
      XFile? pickedImage = await picker.pickImage(source: source);
      if (pickedImage != null) {
        _multipleImage.add(pickedImage);
        _imagePaths.add(pickedImage.path);
      }
    }
    update();
    return _imagePaths.toString();
  }


  final List<XFile> _multipleImage2 = [];
  List<XFile> get multipleImage2 => _multipleImage2;

  List<String> _imagePaths2 = [];
  List<String> get imagePaths2 => _imagePaths2;

  Future<String> takePhoto2(ImageSource source) async {
    final ImagePicker picker2 = ImagePicker();
    List<XFile> selectedImages2 = [];

    _imagePaths2 = [];
    if (source == ImageSource.gallery) {
      selectedImages2 = await picker2.pickMultiImage();
      _multipleImage2.addAll(selectedImages2);
      for (var image in _multipleImage2) {
        _imagePaths2.add(image.path);
      }
    } else if (source == ImageSource.camera) {
      XFile? pickedImage2 = await picker2.pickImage(source: source);
      if (pickedImage2 != null) {
        _multipleImage2.add(pickedImage2);
        _imagePaths2.add(pickedImage2.path);
      }
    }
    update();
    return _imagePaths2.toString();
  }


  void setSchool(String? value) {
    _schoolValue = value;

  }

  void setTour(String? value) {
    _tourValue = value;

  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      color: AppColors.primary,
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
          vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Select Image",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await takePhoto(ImageSource.camera);
                  Get.back();
                },
                child: const Text(
                  'Camera',
                  style: TextStyle(fontSize: 20.0, color: AppColors.primary),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await takePhoto(ImageSource.gallery);
                  Get.back();
                },
                child: const Text(
                  'Gallery',
                  style: TextStyle(fontSize: 20.0, color: AppColors.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget bottomSheet2(BuildContext context) {
    return Container(
      color: AppColors.primary,
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Select Image",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await takePhoto2(ImageSource.camera);
                  Get.back();
                },
                child: const Text(
                  'Camera',
                  style: TextStyle(fontSize: 20.0, color: AppColors.primary),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await takePhoto2(ImageSource.gallery);
                  Get.back();
                },
                child: const Text(
                  'Gallery',
                  style: TextStyle(fontSize: 20.0, color: AppColors.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showImagePreview(String imagePath, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.file(
                File(imagePath),
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
 void showImagePreview2(String imagePath2, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.file(
                File(imagePath2),
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }


  void clearFields() {
    _tourValue = null;
    _schoolValue = null;
    correctUdiseCodeController.clear();
    noOfFunctionalClassroomController.clear();

  }

  Future<void> fetchData() async {
    isLoading = true;
    update();
    _schoolFacilitiesList = await LocalDbController().fetchLocalSchoolFacilitiesRecords();
    isLoading = false;
    update();
  }
}