import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/config/color_config.dart';

import '../../../../core/global/widgets/input_text_field.dart';
import '../../../../core/global/widgets/primary_button.dart';
import '../../model/response/hive_character_model.dart';
import '../../provider/dashboard_provider.dart';

Widget detailsComponentGenderSpecies(CharacterModel item) {
  return Container(
    padding: EdgeInsets.all(8.0.sp),
    margin: EdgeInsets.all(8.0.sp),
    decoration: BoxDecoration(
      color: ColorConfig.primaryColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Species",
              style: TextStyle(
                color: ColorConfig.greyColor,
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
              ),
            ),
            Text(
              item.species,
              style: TextStyle(
                color: ColorConfig.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Gender",
              style: TextStyle(
                color: ColorConfig.greyColor,
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
              ),
            ),
            Text(
              item.gender,
              style: TextStyle(
                color: ColorConfig.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ],
    )
  );
}


Widget detailsComponentOriginType(CharacterModel item) {
  return Container(
      padding: EdgeInsets.all(8.0.sp),
      margin: EdgeInsets.all(8.0.sp),
      decoration: BoxDecoration(
        color: ColorConfig.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Origin",
                style: TextStyle(
                  color: ColorConfig.greyColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                item.origin,
                style: TextStyle(
                  color: ColorConfig.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Type",
                style: TextStyle(
                  color: ColorConfig.greyColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                item.type.isEmpty ? "Unknown" : item.type,
                style: TextStyle(
                  color: ColorConfig.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ],
      )
  );
}

Widget detailsComponentLocation(CharacterModel item) {
  return Container(
      padding: EdgeInsets.all(8.0.sp),
      margin: EdgeInsets.all(8.0.sp),
      decoration: BoxDecoration(
        color: ColorConfig.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Location",
            style: TextStyle(
              color: ColorConfig.greyColor,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),
          Text(
            item.location,
            style: TextStyle(
              color: ColorConfig.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
  );
}

Widget detailsComponentEditView(CharacterModel item, BuildContext context, WidgetRef ref, Function() onUpdate){
  var controller = ref.watch(dashboardController);
  controller.nameEditTextController.text = item.name;
  controller.statusEditTextController.text = item.status;
  controller.speciesEditTextController.text = item.species;
  controller.originEditTextController.text = item.origin;
  controller.typeEditTextController.text = item.type;
  controller.locationEditTextController.text = item.location;
  controller.genderEditTextController.text = item.gender;

  return Expanded(
    child: Container(
      padding: EdgeInsets.all(8.0.sp),
      decoration: BoxDecoration(
        color: ColorConfig.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        primary: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Update Info",
              style: TextStyle(
                color: ColorConfig.greyColor,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              )
            ),

            SizedBox(
              height: 8.sp,
            ),

            InputTextField(
              controller: controller.nameEditTextController,
              labelText: "Name",
              hintText: "Enter Name",
            ),

            SizedBox(
              height: 8.sp,
            ),

            InputTextField(
              controller: controller.statusEditTextController,
              labelText: "Status",
              hintText: "Enter Status",
            ),

            SizedBox(
              height: 8.sp,
            ),

            InputTextField(
              controller: controller.speciesEditTextController,
              labelText: "Species",
              hintText: "Enter Species",
            ),

            SizedBox(
              height: 8.sp,
            ),

            InputTextField(
              controller: controller.originEditTextController,
              labelText: "Origin",
              hintText: "Enter Origin",
            ),

            SizedBox(
              height: 8.sp,
            ),

            InputTextField(
              controller: controller.typeEditTextController,
              labelText: "Type",
              hintText: "Enter Type",
            ),

            SizedBox(
              height: 8.sp,
            ),

            InputTextField(
              controller: controller.genderEditTextController,
              labelText: "Gender",
              hintText: "Enter Gender",
            ),

            SizedBox(
              height: 8.sp,
            ),

            InputTextField(
              controller: controller.locationEditTextController,
              labelText: "Location",
              hintText: "Enter Location",
            ),

            SizedBox(
              height: 16.sp,
            ),

            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                      isPrimaryButton: false,
                      btnText: "Not Now",
                      onPressed: (){
                        Navigator.pop(context);
                      }
                  ),
                ),

                SizedBox(
                  width: 8.sp,
                ),

                Expanded(
                  child: PrimaryButton(
                      btnText: "Update",
                      onPressed: (){
                        onUpdate.call();
                        Navigator.pop(context);
                      }
                  ),
                ),
              ],
            )
          ]
        ),
      )
    ),
  );
}