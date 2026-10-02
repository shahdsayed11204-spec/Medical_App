import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/cache_helper.dart';



class LocaleCubit extends Cubit<Locale> {
  static const _key = 'languageCode';
  static const supported = [Locale('en'), Locale('ar')];

  LocaleCubit() : super(_initial());

  static Locale _initial() {
    final saved = CacheHelper.getData(key: _key) as String?;
    return Locale(saved ?? 'ar');
  }

  Future<void> change(String languageCode) async {
    await CacheHelper.saveData(key: _key, value: languageCode);
    emit(Locale(languageCode));
  }

  Future<void> toggle() => change(state.languageCode == 'ar' ? 'en' : 'ar');
}