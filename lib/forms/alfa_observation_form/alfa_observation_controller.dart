
import 'dart:io';

import 'package:app17000ft/constants/color_const.dart';
import 'package:app17000ft/forms/alfa_observation_form/alfa_obervation_modal.dart';
import 'package:app17000ft/forms/school_enrolment/school_enrolment_model.dart';
import 'package:app17000ft/forms/school_enrolment/school_enrolment_sync.dart';
import 'package:app17000ft/helper/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../base_client/baseClient_controller.dart';
class AlfaObservationController extends GetxController with BaseController{

  String? _tourValue;
  String? get tourValue => _tourValue;

  //school Value
  String? _schoolValue;
  String? get schoolValue => _schoolValue;

  bool isLoading = false;

  final TextEditingController remarksController = TextEditingController();
  final TextEditingController correctUdiseCodeController = TextEditingController();
  final TextEditingController noOfStaffTrainedController = TextEditingController();
  final TextEditingController moduleEnglishController = TextEditingController();
  final TextEditingController alfaNumercyController = TextEditingController();
  final TextEditingController noOfTeacherTrainedController = TextEditingController();









  // Map to store selected values for radio buttons
  final Map<String, String?> _selectedValues = {};
  String? getSelectedValue(String key) => _selectedValues[key];

  // Map to store error states for radio buttons
  final Map<String, bool> _radioFieldErrors = {};
  bool getRadioFieldError(String key) => _radioFieldErrors[key] ?? false;

  // Method to set the selected value and clear any previous error
  void setRadioValue(String key, String? value) {
    _selectedValues[key] = value;
    _radioFieldErrors[key] = false; // Clear error when a value is selected
    update(); // Update the UI
  }

  // Method to validate radio button selection
  bool validateRadioSelection(String key) {
    if (_selectedValues[key] == null) {
      _radioFieldErrors[key] = true;
      update(); // Update the UI
      return false;
    }
    _radioFieldErrors[key] = false;
    update(); // Update the UI
    return true;
  }



  //Focus nodes
  final FocusNode _tourIdFocusNode = FocusNode();
  FocusNode get  tourIdFocusNode => _tourIdFocusNode;
  final FocusNode _schoolFocusNode = FocusNode();
  FocusNode get  schoolFocusNode => _schoolFocusNode;

  List<AlfaObservationModel> _alfaObservationList =[];
  List<AlfaObservationModel> get alfaObservationList => _alfaObservationList;

  final List<XFile> _multipleImage = [];
  List<XFile> get multipleImage => _multipleImage;
  List<String> _imagePaths = [];
  List<String> get imagePaths => _imagePaths;

  final List<XFile> _multipleImage2 = [];
  List<XFile> get multipleImage2 => _multipleImage2;

  List<String> _imagePaths2 = [];
  List<String> get imagePaths2 => _imagePaths2;


  final List<XFile> _multipleImage3 = [];
  List<XFile> get multipleImage3 => _multipleImage3;

  List<String> _imagePaths3 = [];
  List<String> get imagePaths3 => _imagePaths3;

  final List<XFile> _multipleImage4 = [];
  List<XFile> get multipleImage4 => _multipleImage4;

  List<String> _imagePaths4 = [];
  List<String> get imagePaths4 => _imagePaths4;


  final List<XFile> _multipleImage5 = [];
  List<XFile> get multipleImage5 => _multipleImage5;

  List<String> _imagePaths5 = [];
  List<String> get imagePaths5 => _imagePaths5;


  final List<XFile> _multipleImage6 = [];
  List<XFile> get multipleImage6 => _multipleImage6;

  List<String> _imagePaths6 = [];
  List<String> get imagePaths6 => _imagePaths6;



  final List<XFile> _multipleImage7 = [];
  List<XFile> get multipleImage7 => _multipleImage7;

  List<String> _imagePaths7 = [];
  List<String> get imagePaths7 => _imagePaths7;


  Future<String> takePhoto(ImageSource source,) async {
    final ImagePicker picker = ImagePicker();
    List<XFile> selectedImages = [];

    _imagePaths = [];
    XFile? pickedImage;
    if (source == ImageSource.gallery) {
      selectedImages = await picker.pickMultiImage();
      // if (type == 'lib') {
      _multipleImage.addAll(selectedImages);
      for (var path in _multipleImage) {
        _imagePaths.add(path.path);
      }
      update();
      //  return _imagePaths.toString();
    } else if (source == ImageSource.camera) {
      pickedImage = await picker.pickImage(source: source);
      _multipleImage.add(pickedImage!);
      for (var path in _multipleImage) {
        _imagePaths.add(path.path);
      }
      update();
    }
    update();
    return _imagePaths.toString();
  }


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


  Future<String> takePhoto3(ImageSource source) async {
    final ImagePicker picker3 = ImagePicker();
    List<XFile> selectedImages3 = [];

    _imagePaths3 = [];
    if (source == ImageSource.gallery) {
      selectedImages3 = await picker3.pickMultiImage();
      _multipleImage3.addAll(selectedImages3);
      for (var image in _multipleImage3) {
        _imagePaths3.add(image.path);
      }
    } else if (source == ImageSource.camera) {
      XFile? pickedImage3 = await picker3.pickImage(source: source);
      if (pickedImage3 != null) {
        _multipleImage3.add(pickedImage3);
        _imagePaths3.add(pickedImage3.path);
      }
    }
    update();
    return _imagePaths3.toString();
  }

  Future<String> takePhoto4(ImageSource source) async {
    final ImagePicker picker4 = ImagePicker();
    List<XFile> selectedImages4 = [];

    _imagePaths3 = [];
    if (source == ImageSource.gallery) {
      selectedImages4 = await picker4.pickMultiImage();
      _multipleImage4.addAll(selectedImages4);
      for (var image in _multipleImage4) {
        _imagePaths4.add(image.path);
      }
    } else if (source == ImageSource.camera) {
      XFile? pickedImage4 = await picker4.pickImage(source: source);
      if (pickedImage4 != null) {
        _multipleImage4.add(pickedImage4);
        _imagePaths4.add(pickedImage4.path);
      }
    }
    update();
    return _imagePaths4.toString();
  }


  Future<String> takePhoto5(ImageSource source) async {
    final ImagePicker picker5 = ImagePicker();
    List<XFile> selectedImages5 = [];

    _imagePaths5 = [];
    if (source == ImageSource.gallery) {
      selectedImages5 = await picker5.pickMultiImage();
      _multipleImage5.addAll(selectedImages5);
      for (var image in _multipleImage5) {
        _imagePaths5.add(image.path);
      }
    } else if (source == ImageSource.camera) {
      XFile? pickedImage5 = await picker5.pickImage(source: source);
      if (pickedImage5 != null) {
        _multipleImage5.add(pickedImage5);
        _imagePaths5.add(pickedImage5.path);
      }
    }
    update();
    return _imagePaths5.toString();
  }


  Future<String> takePhoto6(ImageSource source) async {
    final ImagePicker picker6 = ImagePicker();
    List<XFile> selectedImages6 = [];

    _imagePaths6 = [];
    if (source == ImageSource.gallery) {
      selectedImages6 = await picker6.pickMultiImage();
      _multipleImage6.addAll(selectedImages6);
      for (var image in _multipleImage6) {
        _imagePaths6.add(image.path);
      }
    } else if (source == ImageSource.camera) {
      XFile? pickedImage6 = await picker6.pickImage(source: source);
      if (pickedImage6 != null) {
        _multipleImage6.add(pickedImage6);
        _imagePaths6.add(pickedImage6.path);
      }
    }
    update();
    return _imagePaths6.toString();
  }


  Future<String> takePhoto7(ImageSource source) async {
    final ImagePicker picker7 = ImagePicker();
    List<XFile> selectedImages7 = [];

    _imagePaths7 = [];
    if (source == ImageSource.gallery) {
      selectedImages7 = await picker7.pickMultiImage();
      _multipleImage7.addAll(selectedImages7);
      for (var image in _multipleImage7) {
        _imagePaths7.add(image.path);
      }
    } else if (source == ImageSource.camera) {
      XFile? pickedImage7 = await picker7.pickImage(source: source);
      if (pickedImage7 != null) {
        _multipleImage7.add(pickedImage7);
        _imagePaths7.add(pickedImage7.path);
      }
    }
    update();
    return _imagePaths7.toString();
  }

  setSchool(value)
  {
    _schoolValue = value;
    // update();
  }

  setTour(value){
    _tourValue = value;
    // update();

  }
  Widget bottomSheet(BuildContext context) {
    String? imagePicked;
    PickedFile? imageFile;
    final ImagePicker picker = ImagePicker();
    XFile? image;
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
              // ignore: deprecated_member_use
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  imagePicked = await takePhoto(ImageSource.camera);

                  // uploadFile(userdata.read('customerID'));
                  Get.back();
                  //  update();
                },
                child: const Text(
                  'Camera',
                  style: TextStyle(
                      fontSize: 20.0, color: AppColors.primary),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  imagePicked = await takePhoto(
                    ImageSource.gallery,
                  );

                  Get.back();
                  //  update();
                },
                child: const Text(
                  'Gallery',
                  style: TextStyle(
                      fontSize: 20.0, color: AppColors.primary),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }


  Widget bottomSheet2(BuildContext context) {
    return Container(
      color: AppColors.primary,
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text("Select Image", style: TextStyle(fontSize: 20.0, color: Colors.white)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await takePhoto2(ImageSource.camera);
                  Get.back();
                },
                child: const Text('Camera', style: TextStyle(fontSize: 20.0, color: AppColors.primary)),
              ),
              const SizedBox(width: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await takePhoto2(ImageSource.gallery);
                  Get.back();
                },
                child: const Text('Gallery', style: TextStyle(fontSize: 20.0, color: AppColors.primary)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomSheet3(BuildContext context) {
    return Container(
      color: AppColors.primary,
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text("Select Image", style: TextStyle(fontSize: 20.0, color: Colors.white)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await takePhoto3(ImageSource.camera);
                  Get.back();
                },
                child: const Text('Camera', style: TextStyle(fontSize: 20.0, color: AppColors.primary)),
              ),
              const SizedBox(width: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await takePhoto3(ImageSource.gallery);
                  Get.back();
                },
                child: const Text('Gallery', style: TextStyle(fontSize: 20.0, color: AppColors.primary)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomSheet4(BuildContext context) {
    return Container(
      color: AppColors.primary,
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text("Select Image", style: TextStyle(fontSize: 20.0, color: Colors.white)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await takePhoto4(ImageSource.camera);
                  Get.back();
                },
                child: const Text('Camera', style: TextStyle(fontSize: 20.0, color: AppColors.primary)),
              ),
              const SizedBox(width: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await takePhoto4(ImageSource.gallery);
                  Get.back();
                },
                child: const Text('Gallery', style: TextStyle(fontSize: 20.0, color: AppColors.primary)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomSheet5(BuildContext context) {
    return Container(
      color: AppColors.primary,
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text("Select Image", style: TextStyle(fontSize: 20.0, color: Colors.white)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await takePhoto5(ImageSource.camera);
                  Get.back();
                },
                child: const Text('Camera', style: TextStyle(fontSize: 20.0, color: AppColors.primary)),
              ),
              const SizedBox(width: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await takePhoto5(ImageSource.gallery);
                  Get.back();
                },
                child: const Text('Gallery', style: TextStyle(fontSize: 20.0, color: AppColors.primary)),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget bottomSheet6(BuildContext context) {
    return Container(
      color: AppColors.primary,
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text("Select Image", style: TextStyle(fontSize: 20.0, color: Colors.white)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await takePhoto6(ImageSource.camera);
                  Get.back();
                },
                child: const Text('Camera', style: TextStyle(fontSize: 20.0, color: AppColors.primary)),
              ),
              const SizedBox(width: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await takePhoto6(ImageSource.gallery);
                  Get.back();
                },
                child: const Text('Gallery', style: TextStyle(fontSize: 20.0, color: AppColors.primary)),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget bottomSheet7(BuildContext context) {
    return Container(
      color: AppColors.primary,
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text("Select Image", style: TextStyle(fontSize: 20.0, color: Colors.white)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await takePhoto7(ImageSource.camera);
                  Get.back();
                },
                child: const Text('Camera', style: TextStyle(fontSize: 20.0, color: AppColors.primary)),
              ),
              const SizedBox(width: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await takePhoto7(ImageSource.gallery);
                  Get.back();
                },
                child: const Text('Gallery', style: TextStyle(fontSize: 20.0, color: AppColors.primary)),
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
              child: Image.file(File(imagePath2), fit: BoxFit.contain),
            ),
          ),
        );
      },
    );
  }

  void showImagePreview3(String imagePath3, BuildContext context) {
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
              child: Image.file(File(imagePath3), fit: BoxFit.contain),
            ),
          ),
        );
      },
    );
  }


  void showImagePreview4(String imagePath4, BuildContext context) {
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
              child: Image.file(File(imagePath4), fit: BoxFit.contain),
            ),
          ),
        );
      },
    );
  }


  void showImagePreview5(String imagePath5, BuildContext context) {
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
              child: Image.file(File(imagePath5), fit: BoxFit.contain),
            ),
          ),
        );
      },
    );
  }


  void showImagePreview6(String imagePath6, BuildContext context) {
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
              child: Image.file(File(imagePath6), fit: BoxFit.contain),
            ),
          ),
        );
      },
    );
  }

  void showImagePreview7(String imagePath7, BuildContext context) {
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
              child: Image.file(File(imagePath7), fit: BoxFit.contain),
            ),
          ),
        );
      },
    );
  }

  //Clear fields
  void clearFields() {

    update();
  }

  fetchData() async {
    isLoading = true;

    _alfaObservationList = [];
    _alfaObservationList = await LocalDbController().fetchLocalAlfaObservationModel();

    update();
  }

//

//Update the UI


}