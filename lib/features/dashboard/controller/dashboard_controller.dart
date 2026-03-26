import 'package:hive/hive.dart';
import 'package:task/core/global/global_features/controller/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:task/core/global/util/shared_preferences.dart';

import '../../../core/config/api_config.dart';
import '../model/response/character_response_model.dart';
import '../model/response/hive_character_model.dart';
import '../repository/dashboard_repository.dart';

class DashboardController extends BaseController{
  var dashboardRepository = DashboardRepository();

  var searchTextController = TextEditingController();
  final characterHiveBox = Hive.box<CharacterModel>('characterModelBox');


  Future<List<CharacterModel>> getCharacterList() async {
    var nextPage = await SharedPreference.getNextPage();
    var url =  (nextPage ?? "").isNotEmpty ? nextPage! : UrlUtils.characterListUrl;
    var response = await dashboardRepository.getCharacterList(url);
    SharedPreference.storeNextPage(response.info?.next ?? "");
    List<CharacterModel> list = [];
    for (Results? element in (response.results ?? [])) {
      characterHiveBox.add(CharacterModel(
          id: (element?.id ?? -1) as  int,
          name: element?.name ?? "",
          image: element?.image ?? "",
          species: element?.species ?? "",
          status: element?.status ?? "",
          type: element?.type ?? "",
          gender: element?.gender ?? "",
          origin: element?.origin?.name ?? "",
          location: element?.location?.name ?? "",
          isFavorite: false,
      ));
      list.add(CharacterModel(
        id: (element?.id ?? -1) as  int,
        name: element?.name ?? "",
        image: element?.image ?? "",
        species: element?.species ?? "",
        status: element?.status ?? "",
        type: element?.type ?? "",
        gender: element?.gender ?? "",
        origin: element?.origin?.name ?? "",
        location: element?.location?.name ?? "",
        isFavorite: false,
      ));
    }

    return list;
  }

  Future<List<CharacterModel>> getCachedCharacters() async{
    return characterHiveBox.values.toList().isNotEmpty ? characterHiveBox.values.toList() : await getCharacterList();
  }


  Future<void> setFavoriteCharacters(int id) async{
    var index = characterHiveBox.values.toList().indexWhere((element) => element.id == id);
    await characterHiveBox.putAt(index, CharacterModel(
      id: characterHiveBox.values.toList()[index].id,
      name: characterHiveBox.values.toList()[index].name,
      image: characterHiveBox.values.toList()[index].image,
      species: characterHiveBox.values.toList()[index].species,
      status: characterHiveBox.values.toList()[index].status,
      type: characterHiveBox.values.toList()[index].type,
      gender: characterHiveBox.values.toList()[index].gender,
      origin: characterHiveBox.values.toList()[index].origin,
      location: characterHiveBox.values.toList()[index].location,
      isFavorite: !characterHiveBox.values.toList()[index].isFavorite,
    ));
  }

  Future<List<CharacterModel>> getFavoriteCharacters() async{
    return characterHiveBox.values.toList().where((element) => element.isFavorite).toList();
  }

}