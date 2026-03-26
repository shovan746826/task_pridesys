import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/config/color_config.dart';

import '../../model/response/hive_character_model.dart';

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