import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return const Placeholder();
  }
}
