import 'package:go_router/go_router.dart';
import 'package:task/core/config/color_config.dart';
import 'package:task/core/global/widgets/app_background_view.dart';
import 'package:task/core/global/widgets/custom_appbar.dart';
import 'package:task/core/global/widgets/custom_image_view.dart';
import 'package:task/features/dashboard/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/config/router_config.dart';
import '../../../../core/global/widgets/CommonListShimmer.dart';



class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {

  final ScrollController scrollController = ScrollController();
  bool isScroll = true;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      ref.read(getCharacterListProvider.notifier).getCachedCharacters();

      scrollController.addListener(() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent) {
          if (isScroll) {
            ref.read(getCharacterListProvider.notifier).getCharacterList();
          }
          isScroll = false;
        } else {
          isScroll = true;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(dashboardController);
    var getCharacterList = ref.watch(getCharacterListProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {

    });

    return BackgroundView(
      child: Scaffold(
        backgroundColor: ColorConfig.transparentColor,
        appBar: GlobalAppBar(
          title: 'Characters',
          titleColor: ColorConfig.whiteColor,
          titleAlignment: TitleAlignment.left,
          backgroundColor: ColorConfig.primaryColor,
          customIcon: IconButton(
            icon: const Icon(Icons.favorite,
              color: ColorConfig.whiteColor,
            ),
            onPressed: () {
              context.push(RouterPath.favoriteListScreenPath);
            },
          )
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0.sp),
          child: Column(
            children: [

              Container(
                height: 48.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                margin: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: ColorConfig.transparentColor,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: ColorConfig.greyColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 16.sp,
                      color: ColorConfig.greyColor,
                    ),

                    SizedBox(width: 8.w),

                    Expanded(
                      child: TextField(
                        controller: controller.searchTextController,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: ColorConfig.whiteColor,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                          hintText: "Search by name",
                          hintStyle: TextStyle(
                            fontSize: 12.sp,
                            color: ColorConfig.greyColor,
                            fontWeight: FontWeight.w300,
                          ),
                          isDense: true, // 🔑 removes extra height
                          contentPadding: EdgeInsets.zero, // 🔑 aligns with icons
                          border: InputBorder.none,
                        ),
                        onEditingComplete: () {
                          FocusScope.of(Get.context!).unfocus();
                        },
                        onChanged: (value) {
                          if (value.isEmpty) {
                            return;
                          }

                        },
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                      ),
                    ),

                    SizedBox(width: 8.w),

                    GestureDetector(
                      onTap: () {
                        controller.searchTextController.clear();
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        size: 16.sp,
                        color: ColorConfig.greyColor,
                      ),
                    ),
                  ],
                ),
              ),


              Expanded(
                child: getCharacterList.when(
                    data: (itemList) {
                      return GridView.builder(
                        controller: scrollController,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 🔥 2 columns
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          childAspectRatio: .6, // adjust UI height
                        ),
                        itemCount: itemList.length,
                        itemBuilder: (context, index) {
                          var item = itemList[index];
                          return GestureDetector(
                            onTap: (){
                              context.push(RouterPath.detailsScreenPath, extra: item);
                            },
                            child: Container(
                              padding: EdgeInsets.all(4.0.sp),
                              decoration: BoxDecoration(
                                color: ColorConfig.primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorConfig.blackColor.withValues(alpha: 30),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Hero(
                                    tag: item.id,
                                    child: CustomImageView(imagePath: item.image,
                                      placeHolderWidget: Icon(Icons.image),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(item.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap:  true,
                                    style: TextStyle(
                                      color: ColorConfig.whiteColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(item.species,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: ColorConfig.greyColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(item.status,
                                    style: TextStyle(
                                        color: item.status.toLowerCase() == "alive" ? ColorConfig.greenColor : item.status.toLowerCase() == "dead" ? ColorConfig.redColor : ColorConfig.greyColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  loading: () => CommonListShimmer(),
                  error: (err, _) => SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text('Error: $err')),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
