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
        ),
        body: RefreshIndicator(
          onRefresh: () async{

          },
          child: Padding(
            padding: EdgeInsets.all(16.0.sp),
            child: Column(
              children: [
                // Text("Character List",
                //   style: TextStyle(
                //     color: ColorConfig.whiteColor,
                //     fontSize: 20.sp,
                //     fontWeight: FontWeight.w500
                //   ),
                // ),
                // SizedBox(
                //   height: 8.h,
                // ),

                Container(
                  decoration: BoxDecoration(
                    color: ColorConfig.whiteColor,
                    borderRadius: BorderRadius.circular(8.0.r),
                  ),
                  child: TextField(
                    controller: controller.searchTextController,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: ColorConfig.textColorSecondary,
                        fontWeight: FontWeight.w300
                    ),
                    decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                            fontSize: 12.sp,
                            color: ColorConfig.textColorDark,
                            fontWeight: FontWeight.w300
                        ),
                        border: InputBorder.none,
                      prefixIcon: Icon(Icons.search,
                        color: ColorConfig.textColorSecondary,
                        size: 14.sp,
                      ),

                    ),
                    onEditingComplete: () {
                      FocusScope.of(Get.context!).unfocus(); // hide keyboard
                    },
                    onChanged: (value) {

                    },
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                  ),
                ).marginSymmetric(vertical: 12.0.h),


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
      ),
    );
  }
}
