import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:image/image.dart' as img;

import '../../config/color_config.dart';


class CommonImagePicker{
  static XFile? pickedImageFile;
  static XFile? croppedImageFile;
  static String? pickedImageFilePath;


  /// pickType = >> 1 = camera, 2 = gallery
  static Future<File?> showImagePicker(BuildContext context, {CropAspectRatio? aspectRatio}) async {
    Completer<File?> completer = Completer<File?>();

    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, res) async {
            if (didPop) return;
            pickedImageFile = null;
            croppedImageFile = null;
            pickedImageFilePath = null;
            completer.complete(null);
            context.pop();
          },
          child: Container(
            padding: const EdgeInsets.only(top: 25.0),
            child: ListView(
              shrinkWrap: true,
              children: [

                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(
                      height: 5.0,
                      width: 50.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorConfig.backgroundColorSecondary,
                          border: Border.all(color: ColorConfig.backgroundColorSecondary,),
                          borderRadius: const BorderRadius.all(Radius.circular(40)),
                        ),
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 16.sp),
                const Divider(thickness: 3, color: ColorConfig.greyColor,),

                SizedBox(height: 24.sp,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                          pickedImageFile = await pickImageFromCameraOrGallery(context, 1, aspectRatio);
                          debugPrint("croppedImageFile :: $pickedImageFile");

                          /// Convert XFile to File
                          if ((pickedImageFile?.path ?? "").isNotEmpty) {
                            File? file = pickedImageFile != null ? File(pickedImageFile!.path) : null;
                            completer.complete(file);
                          }
                        },
                        child: const Column(
                          children: [
                            const Icon(Icons.photo_camera_rounded, size: 65.0, color: ColorConfig.primaryColor,),
                            Text("Camera", style: TextStyle(fontSize: 12, color: ColorConfig.textColorPrimary, fontWeight: FontWeight.w400),),
                          ],
                        ),
                      ),
                    ),

                    // SizedBox(width: getProportionateScreenWidth(10.0),),
                    Container(
                      height: 56.sp,
                      width: 4.sp,
                      decoration: BoxDecoration(
                        //color: ColorConfig.primaryColor,
                        border: Border.all(color: ColorConfig.primaryColor,),
                        borderRadius: const BorderRadius.all(Radius.circular(35)),
                      ),
                    ),

                    Expanded(
                      child: InkWell(
                          onTap: () async {
                            Navigator.pop(context);
                            pickedImageFile = await pickImageFromCameraOrGallery(context, 2, aspectRatio);
                            debugPrint("croppedImageFile :: $pickedImageFile");

                            /// Convert XFile to File
                            if ((pickedImageFile?.path ?? "").isNotEmpty) {
                              File? file = pickedImageFile != null ? File(pickedImageFile!.path) : null;
                              completer.complete(file);
                            }
                          },
                          child: const Column(
                            children: [
                               Icon(Icons.photo_library_rounded, size: 65.0, color: ColorConfig.primaryColor,),
                              Text("Gallery", style: TextStyle(fontSize: 12, color: ColorConfig.textColorPrimary, fontWeight: FontWeight.w400),),
                            ],
                          )),
                    ),

                  ],
                ),
                SizedBox(height: 40.sp,),

              ],
            ),
          ),
        );
      },
    );

    return completer.future;
  }

  /// pickType = >> 1 = camera, 2 = gallery
  static Future<XFile?> pickImageFromCameraOrGallery(BuildContext context, int pickType, CropAspectRatio? aspectRatio) async {
    final ImagePicker imagePicker = ImagePicker();

    if (pickType == 1) {
      try {
        pickedImageFile = await imagePicker.pickImage(source: ImageSource.camera);
        pickedImageFilePath = pickedImageFile?.path;

        if (pickedImageFile != null) {
          XFile? croppedFile = await cropTheChosenImage(File(pickedImageFilePath!), aspectRatio);
          pickedImageFile = croppedFile;

          return pickedImageFile;
        }
      } on Exception catch (e) {
        if (e is PlatformException && e.code == 'no_available_camera') {
          // Handle the case when no cameras are available
          debugPrint("Error: ${e.message}");

        } else {
          // Handle other exceptions
          debugPrint("Unexpected Error: $e");
        }
      }

    } else if (pickType == 2) {
      pickedImageFile = await imagePicker.pickImage(source: ImageSource.gallery);
      pickedImageFilePath = pickedImageFile?.path;

      if (pickedImageFile != null) {
        XFile? croppedFile = await cropTheChosenImage(File(pickedImageFilePath!), aspectRatio);
        pickedImageFile = croppedFile;

        return pickedImageFile;
      }

    }
    return null;

  }

  static Future<XFile?> cropTheChosenImage(File file, CropAspectRatio? aspectRatio) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: aspectRatio,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Cropper",
          toolbarColor: ColorConfig.primaryColor,
          toolbarWidgetColor: ColorConfig.secondaryColor,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          hideBottomControls: false,
          cropFrameStrokeWidth: 2,
          showCropGrid: true,
        ),
        IOSUiSettings(
          title: "Cropper",
          aspectRatioLockEnabled: false,
          rotateButtonsHidden: false,
        ),
      ],
    );

    print("croppedFile :: $croppedFile");
    if (croppedFile != null) {
      croppedImageFile = XFile(croppedFile.path);
    } else {
      croppedImageFile = XFile('');
    }

    return croppedImageFile;
  }

  static Future<File?> convertXFileToFile({required String croppedImageXFilePath}) async {
    return File(croppedImageXFilePath);
  }

  static Future<XFile> correctImageOrientation(XFile imageFile) async {
    var imageFileMain = File(imageFile.path);
    // Read image bytes
    List<int> imageBytes = await imageFileMain.readAsBytes();

    // Decode image
    img.Image? image = img.decodeImage(Uint8List.fromList(imageBytes));

    // Extract orientation information from EXIF data
    int orientation = getOrientation(imageBytes);
    // int orientation = 8;
    debugPrint("IsImageLandscapeOrVertical [Orientation] > Image is :: $orientation");

    // Rotate/flip the image based on orientation
    switch (orientation) {
      case 2:
        image = img.flipHorizontal(image!);
        break;
      case 3:
        image = img.flipVertical(image!);
        break;
      case 4:
        image = img.flipVertical(image!);
        break;
        // case 5:
        //   image = img.transpose(image);
        break;
      case 6:
        image = img.copyRotate(image!, angle: 90);
        break;
    // case 7:
    //   image = img.transverse(image!);
    //   break;
      case 8:
        image = img.copyRotate(image!, angle: -90);
        break;
      default:
      // No need to rotate/flip if orientation is 1 (normal)
        break;
    }

    // Save the corrected image
    List<int> correctedImageBytes = img.encodeJpg(image!);
    var fileConverted = await imageFileMain.writeAsBytes(correctedImageBytes);
    return XFile(fileConverted.path);
  }

  static int getOrientation(List<int> bytes) {
    // Extract orientation from EXIF data
    const int startOffset = 2;
    const int tiffMarker = 0x2A;
    const int exifMarker = 0xE1;
    const int orientationTag = 0x0112;

    int offset = startOffset;

    while (offset < bytes.length - 1) {
      if (bytes[offset] == tiffMarker && bytes[offset + 1] == exifMarker) {
        // Found the EXIF marker
        offset += 4; // Skip to the start of the IFD (Image File Directory)
        break;
      }
      offset++;
    }

    int ifdLength = bytes[offset] | (bytes[offset + 1] << 8);

    for (int i = 0; i < ifdLength; i++) {
      int tag = bytes[offset + 2 + i * 12] | (bytes[offset + 3 + i * 12] << 8);
      if (tag == orientationTag) {
        int type = bytes[offset + 4 + i * 12] | (bytes[offset + 5 + i * 12] << 8);
        int count = bytes[offset + 6 + i * 12] | (bytes[offset + 7 + i * 12] << 8);
        int valueOffset = bytes[offset + 8 + i * 12] | (bytes[offset + 9 + i * 12] << 8);

        if (type == 3 && count == 1) {
          // Found the orientation tag
          return bytes[valueOffset];
        }
      }
    }

    // Default to normal orientation if no orientation tag is found
    return 1;
  }

  static Future<File?> applyRotationFix(String originalPath) async {
    File contrastFile = File(originalPath);
    try {
      img.Image? contrast = img.decodeImage(contrastFile.readAsBytesSync());
      contrast = img.copyRotate(contrast!, angle: -90);
      contrastFile.writeAsBytesSync(img.encodeJpg(contrast));

      return contrastFile;
    } catch (e) {
      print(e);
      return null;
    }
  }

}