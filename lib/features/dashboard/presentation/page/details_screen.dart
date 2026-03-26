import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/config/size_config.dart';
import 'package:task/core/global/widgets/app_background_view.dart';

import '../../../../core/config/color_config.dart';
import '../../../../core/global/widgets/custom_appbar.dart';
import '../../../../core/global/widgets/custom_image_view.dart';
import '../../model/response/hive_character_model.dart';
import '../../provider/dashboard_provider.dart';
import '../component/details_component.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  const DetailsScreen({super.key, required this.item});

  final CharacterModel item;

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundView(
      child: Scaffold(
        backgroundColor: ColorConfig.transparentColor,
        appBar: GlobalAppBar(
            title: widget.item.name,
            titleColor: ColorConfig.whiteColor,
            titleAlignment: TitleAlignment.left,
            backgroundColor: ColorConfig.primaryColor,
            customIcon: IconButton(
              icon: Icon( widget.item.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: ColorConfig.whiteColor,
              ),
              onPressed: () {
                setState(() {
                  widget.item.isFavorite = !widget.item.isFavorite;
                  ref.read(dashboardController.notifier).setFavoriteCharacters(widget.item.id, isFavorite: widget.item.isFavorite);
                });
              },
            )
        ),

        body: SingleChildScrollView(
          child: Column(
              children: [
                Hero(
                  tag: widget.item.id,
                  child: CustomImageView(imagePath: widget.item.image,
                    height: SizeConfig.screenWidth,
                    width: SizeConfig.screenWidth,
                    placeHolderWidget: Icon(Icons.image),
                  ),
                ),

                SizedBox(
                  height: 8.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.item.name,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorConfig.whiteColor
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Icon(widget.item.gender.toLowerCase() == "male" ? Icons.male : Icons.female,
                      color: ColorConfig.whiteColor,
                      size: 20.sp,
                    ),
                    Text("(${widget.item.gender})",
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.normal,
                        color: ColorConfig.whiteColor,
                      ),
                    ),
                  ],
                ),

                Text(widget.item.status,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: widget.item.status.toLowerCase() == "alive" ? ColorConfig.greenColor : widget.item.status.toLowerCase() == "dead" ? ColorConfig.redColor : ColorConfig.greyColor,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),

                detailsComponentGenderSpecies(widget.item),
                detailsComponentOriginType(widget.item),
                detailsComponentLocation(widget.item),
              ]
          ),
        ),
      ),
    );
  }
}
