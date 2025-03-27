import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/providers/async_value.dart';
import 'package:week_3_blabla_project/repository/ride_preferences_repository.dart';

class RidesPreferenceProvider extends ChangeNotifier {
  final RidePreferencesRepository repository;

//List<RidePreference> pastPreference = [];

  /// Initialize pastPreference with AsyncValue.loading() by default
  late AsyncValue<List<RidePreference>> pastPreference = AsyncValue.loading();

  RidePreference? _currentPreference;

  RidesPreferenceProvider({required this.repository});

  RidePreference? get currentPreference {
    //  print("Get current pref: $_currentPreference");
    return _currentPreference;
  }

  void setCurrentPreference(RidePreference preference) {
    if (_currentPreference != preference) {
      //    print("Set current pref to $_currentPreference");
      _currentPreference = preference;
      addPreference(preference);
      //    repository.addPreference(preference);
      notifyListeners();
    }
  }

//    void addPreference(RidePreference preference) {
//      pastPreference.add(preference);
  Future<void> addPreference(RidePreference preference) async {
    try {
      // 1. Add to the Repository
      repository.addPreference(preference);

      // 2. Refetch data again
      await fetchPastPreferences();
    } catch (e) {
      pastPreference = AsyncValue.error(e);
    }
    notifyListeners();
  }

//   List<RidePreference> getPastPreferences() {
//     return pastPreference.reversed.toList();
  Future<void> fetchPastPreferences() async {
    // 1- Handle loading
    pastPreference = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch Data
      List<RidePreference> pastPrefs = await repository.getPastPreferences();

      // 3- Handle Success
      pastPreference = AsyncValue.success(pastPrefs);

      // 4- Hanles Error
    } catch (e) {
      pastPreference = AsyncValue.error(e);
    }

    notifyListeners();
  }
}
