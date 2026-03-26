import 'package:task/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/response/hive_character_model.dart';



var dashboardController = ChangeNotifierProvider((ref) {
  DashboardController controller = DashboardController();
  return controller;
});

final getCharacterListProvider = StateNotifierProvider<CharacterListNotifier, AsyncValue<List<CharacterModel>>>((ref) {
  return CharacterListNotifier(DashboardController());
});

class CharacterListNotifier extends StateNotifier<AsyncValue<List<CharacterModel>>> {
  CharacterListNotifier(this.controller) : super(const AsyncValue.data([]));
  DashboardController controller;

  getCharacterList() async {
    if((state.value ?? []).isEmpty) {
      state = const AsyncValue.loading(); // Set loading state before fetching data
    }
    try {
      final newItems = await controller.getCharacterList();
      if((state.value ?? []).isEmpty) {
        state = AsyncValue.data(newItems);
      }else{
        state = state.whenData((items) => [...items, ...newItems]);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack); // Handle errors properly
    }
  }

  getCachedCharacters() async {
    if((state.value ?? []).isEmpty) {
      state = const AsyncValue.loading(); // Set loading state before fetching data
    }
    try {
      final newItems = await controller.getCachedCharacters();
      state = AsyncValue.data(newItems);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack); // Handle errors properly
    }
  }

  void clearState() {
    state = const AsyncValue.data([]);
  }
}


var searchEnableProvider = StateProvider.autoDispose<bool>((ref) => false);
