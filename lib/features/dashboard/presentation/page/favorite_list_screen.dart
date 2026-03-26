import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/color_config.dart';
import '../../../../core/global/widgets/custom_appbar.dart';
import '../../../../core/global/widgets/custom_image_view.dart';
import '../../provider/dashboard_provider.dart';

class FavoriteListScreen extends ConsumerStatefulWidget {
  const FavoriteListScreen({super.key});

  @override
  ConsumerState<FavoriteListScreen> createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends ConsumerState<FavoriteListScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      ref.read(getFavoriteCharactersProvider.notifier).clearState();
      ref.read(getFavoriteCharactersProvider.notifier).getFavoriteCharacters();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var favoriteList = ref.watch(getFavoriteCharactersProvider);
    return Scaffold(
      appBar: GlobalAppBar(
          title: 'Favorite List',
          titleColor: ColorConfig.whiteColor,
          titleAlignment: TitleAlignment.left,
          backgroundColor: ColorConfig.primaryColor,
      ),
      body: (favoriteList ?? []).isNotEmpty ? ListView.builder(
        itemCount: (favoriteList ?? []).length,
        itemBuilder: (context, index) {
          var item = favoriteList?[index];
          return Card(
            child: Container(
              padding: EdgeInsets.only(top: 8.0.sp, bottom: 8.0.sp, right: 8.0.sp),
              margin: EdgeInsets.symmetric(horizontal: 8.0.sp, vertical: 4.sp),
              decoration: BoxDecoration(
                color: ColorConfig.whiteColor,
                borderRadius: BorderRadius.circular(8.0.sp),
              ),
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: '${item?.image}',
                    width: 48.sp,
                    height: 48.sp,
                    radius: BorderRadius.circular(8.0.sp),
                  ),
                  SizedBox(
                    width: 8.sp,
                  ),
                  Text(
                    '${item?.name}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () async{
                      await ref.read(dashboardController.notifier).setFavoriteCharacters(item!.id, isFavorite: false);
                      ref.read(getFavoriteCharactersProvider.notifier).clearState();
                      ref.read(getFavoriteCharactersProvider.notifier).getFavoriteCharacters();
                      ref.read(getCharacterListProvider.notifier).getCachedCharacters();
                    },
                    icon: Icon(
                      Icons.group_remove,
                      color: ColorConfig.redColor,
                    )
                  )
                ]
              )
            ),
          );
        },
      ) : Center(
        child: Text("No Favorite Data Found",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      )
    );
  }
}
